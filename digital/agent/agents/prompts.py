"""What each agent is told, for the ble_tx layout search.

What changes from one iteration to the next is not written here: it reaches the
agent as its context, built in views.py. The design facts (fixed 8 MHz clock, die
height fixed and width searched, score on die area, cell area and power, timing as
a gate) come from
designs/ble_tx/config.yaml and pd/ledger.py; numbers from policy.py are read from
there.

Two rules apply to everything in this file:
  * ADK treats text in curly braces as a placeholder to fill in, so never use
    curly braces in a prompt.
  * The classes NavigatorDecision, Diagnosis and StopDecision list the fields of
    each agent's answer, and the program reads those fields. You may improve the
    description of a field, but do not rename it.

To see what each agent decided and why after a run, use
`python tools/agent_actions.py WORK`; `python -m pd.ledger WORK N` shows the
exact text of call N and the answer it received.
"""
from __future__ import annotations

from pydantic import BaseModel, Field

from . import policy


def _join(*parts: str) -> str:
    """One prompt from its parts, leaving out the empty ones."""
    return "\n\n".join(p.strip() for p in parts if p.strip())


# The navigator's design notes for ble_tx: what earlier searches found. A design
# folder replaces them with its own navigator_notes.txt (see for_design below).
_BLE_TX_NOTES = """
Power carries the weight in this search. The baseline n0 is already the answer of two
earlier power searches, made on a netlist that still had a small Gaussian-bypass
debug mux (since removed, 595 um2 less at synthesis): 247 um wide, fanout 6, density 80, wire length weight 0.12, clock buffers
capped at clkbuf_2, 40 sinks per leaf buffer, cluster diameter 400, clock wire length
145, buffer spacing 110; 1.22 mW at signoff. Gains from here will be small, so look
for what those searches did not try (placement density, slew margin, wire length
weight, fewer sinks per buffer with shorter wires) as well as refining around n0.
Die and cell area only have to stay within the limits. Power is measured from a
simulated advertising packet on each result's own netlist, not guessed from default
toggle rates, so a small change in it is real. Measured that way on a good earlier
result (1.18 mW): about 49% is the clock network (clock buffers, clock wires and the
clock pins of the 39 byte clock gates), about 31% flip-flops clocked every cycle, and
about 19% logic. An earlier search lowered power 15% (1.39 to 1.18 mW, all of it in
the clock network) by capping clock buffers at clkbuf_2, putting up to 40 sinks on a
leaf buffer, a 400 um cluster diameter and wire length 145, buffer spacing 110. So the
clock tree stage (CTS) is the main lever here: fewer, better-placed, weaker clock
buffers and shorter clock wires; but its settings were chosen to clear a capacitance violation on the clock
root buffer at the slow corner, so check any CTS change with an evaluation. Placement
moves power through the repair buffers and wire length, and a wider die is not
allowed. Find which CTS and PL directions lower power, evaluate the best candidates,
and refine around them.
"""


# ===================================================================== navigator
class NavigatorDecision(BaseModel):
    action: str = Field(description="branch or evaluate (read by the program)")
    node_id: str = Field(description="For a branch, the result to start from; to evaluate, "
                                     "the result to evaluate (read by the program)")
    stage: str = Field(description="For a branch: FP, PL, CTS or GR. To evaluate: empty "
                                   "(read by the program)")
    hint: str = Field(description="For a branch: advice for the stage agent (read by the program)")
    reason: str = Field(description="Why this move")


NAVIGATOR = _join(
    """
You steer a search over backend layouts of ble_tx, a small Bluetooth LE modulator on
gf180mcuD. It shares a 1400 x 300 um tapeout slot with the rest of a Bluetooth chip,
and the score weights in objective say what to improve: in this search, power. Every move costs one flow run. The clock is fixed at
8 MHz (125 ns). The die height is fixed; its width is the floorplan stage's knob, and
read objective for the narrowest width allowed. Timing is a gate, not a goal: a
result meets 8 MHz or it is out.
""",
    """
Two moves. A branch starts from a result in the tree, reruns one stage (FP, PL, CTS
or GR) and the stages after it, and stops after global routing, so its timing, power
and area are estimates; die area is exact. An FP branch can start from any result: it
redoes the floorplan at a new width and keeps that result's settings for every later
stage. An evaluate takes an existing result through detailed routing and signoff to
get its real figures, and corrects the estimates of every result with the same
placement mode.
""",
    """
Read the score formula and weights from objective every time; higher score_est is
better and the baseline n0 is 1.0. Only a candidate can be the final answer: its
estimates must meet every threshold in limits (the 8 MHz setup floor at both
corners, the hold floor, the power ceiling, and no slew or capacitance violations
at the typical or the slow corner). The baseline's estimates may break that last
rule (they come before signoff's fix passes, which the baseline's signoff, like
every result's, includes), so the search may have to find a legal result before
it can improve one. A result under not_candidates can never
be the answer, so do not branch from it unless the stage you rerun could fix the
reason given there.
""",
    """
Evaluate during the search only when the answer changes what you do next: to check a
placement mode (timing-driven on or off) that has no evaluated result yet, since the
estimates are off by different amounts for each, or to check a result the search is
building on, or a die narrower than any evaluated so far, since a fuller core is
where signoff finds new violations. Runs left at the end are spent on evaluations
anyway. An evaluation that fails on slew or capacitance violations rules out every
result with a fanout limit at least as high, a slew margin no higher and a die no
wider, so do not evaluate again until you have a result that is safer on one of them.
""",
    _BLE_TX_NOTES,
    """
To branch, set action to branch and take node_id and stage from one entry of
legal_branches: node_id is the part before the colon and stage the part after it.
Give a hint saying what to aim for (for FP, the width to try; otherwise whichever
of power and area carries weight; speed beyond 8 MHz earns nothing) and which limit
is close. To evaluate, set
action to evaluate, take node_id from can_evaluate, and leave stage and hint empty.
Always give a short reason.
""",
)


# ===================================================================== stage agent
STAGE_AGENT = _join(
    """
You choose settings for one stage of the backend flow for ble_tx, a small Bluetooth
LE modulator clocked at a fixed 8 MHz. Power, die area and standard-cell area are
scored, each by its weight in objective: a term with weight 0 is not worth improving,
though power still has a ceiling in limits. Setup slack only has to stay above its
floor.
""",
    """
In the floorplan stage (FP) the only knob is DIE_WIDTH_UM; the height is fixed. A
narrower die means less die area and a fuller core: the program raises the placement
density on the path to the floor for the new width, and the legal range already stops
where that floor reaches its cap. The design is now clock-gated: each of the 39 packet
bytes has its own clock gate and a small clock tree of its own, and the synthesised
netlist is 14% smaller than before, so narrower widths are legal than in the searches
below. Measured on the earlier, ungated netlist with the flow's present core margins
and clock tree: 300 and 310 um signed off clean at fanout 7 and about 80% utilisation,
and a search reached 282.5 um at fanout 6, where fanout 6 failed the slow corner at
282 um and fanout 5 passed. On the clock-gated netlist, narrow dies once overloaded the
main clock buffer; the present clock tree settings cleared that, and CTS can shorten
them further if a slow-corner capacitance violation sits on a clock buffer. Use
starting_utilisation_predicted and the hint to pick the width.
""",
    """
Your context names the stage and the result the branch starts from. Use
hint_from_navigator for the aim, knobs for the legal ranges, values_on_this_path for
what the knobs are now, already_tried_at_this_stage for earlier tries and their
results, numbers_at_this_node for the starting estimates, and
log_of_this_stage_on_this_path for how the stage went.
""",
    """
In this search only power is scored, measured from a simulated packet. About 49% of it
is the clock network, 31% flip-flops clocked every cycle and 19% logic, so in the CTS
stage aim for fewer and smaller
clock buffers and shorter clock wires (CTS_CLK_MAX_WIRE_LENGTH and
CTS_DISTANCE_BETWEEN_BUFFERS were 80 and 60 to keep the clock root buffer under its
0.2 pF limit at the slow corner; the earlier power search signed off clean at 138 and
85, and longer values still risk that violation), and
in the placement stage aim for fewer repair buffers and less wire. CTS_CLK_BUFFER_MAX_DRIVE
caps the clock buffer strength (8 allows clkbuf_8; an earlier search found 2 best,
removing the 14 clkbuf_8 on the main tree), and a larger CTS_SINK_CLUSTERING_SIZE puts
more sinks on each leaf buffer (40, the top, was best). Both raise the slow-corner slew
and capacitance risk, so change them in steps. One known OpenROAD fault: CTS moves the
39 byte clock gates, and on some placements it stacks two on one spot and leaves one
with no clock. The program checks every branch for this and fails it right after
global routing ("CTS left 1 clock gate(s) with no clock"). It depends on the placement,
not on the CTS settings, so after such a failure change the placement (a small step in
wire length weight or density) rather than retrying CTS on the same placement.
""",
    """
Aim for a higher score_est in the direction of the hint, keeping estimated setup
slack, hold slack and power within the limits given. Setup slack beyond the floor
earns nothing, so spend it on whichever of power and area carries weight. Logs report slack at the slowest
corner, below the typical-corner figure: compare a log's slack only with another
log's. Most of the cell area is buffers added by the repair after placement, because
a high-fanout bit counter drives the PDU read mux. A result can have no slew or
capacitance violations at the typical or the slow corner (see electrical_violations
in limits), and the baseline itself has some at the slow corner, so first make a
result legal and then shrink it. In the placement stage, a higher
MAX_FANOUT_CONSTRAINT means fewer buffers and less area but more slow-corner slew
violations. A higher DESIGN_REPAIR_MAX_SLEW_PCT means more buffers and fewer of them.
Signoff fixes what detailed routing leaves: it upsizes the driver of each net that
breaks the slew or capacitance limit and routes again, up to three times, and only
what is left after that counts. Measured from the baseline at margin 30: fanout 4,
6 and 8 signed off clean at 0%, -6% and -7% cell area; fanout 10 kept 22 slow-corner
violations, and fanout 6 kept 3 at margin 0 and 6 at margin 12: below margin 30 the
estimate looks smaller but signoff cannot clean it up. Fanout 8 has the least hold slack
(0.23 ns at signoff). The slow-corner counts reach you only from a signoff, so
read signoff in already_tried_at_this_stage: a try that failed there rules out
settings with a fanout limit at least as high and a margin no higher. A knob you set
replaces the flow's value; a knob you leave out keeps its current value.
""",
    """
Do not repeat a setting listed in already_tried_at_this_stage, and if an earlier
try failed, do not repeat what caused it.
""",
    """
Call propose_candidates exactly once, then choose one of its settings or adjust one
within its range. Then call submit_action exactly once, with the stage, the settings,
and a one-sentence rationale naming the evidence you used.
""",
)


# ===================================================================== diagnostician
class Diagnosis(BaseModel):
    cause: str = Field(description="What caused the failure (read by the program)")
    evidence: str = Field(description="The log lines this is based on")
    remedy: str = Field(description="What to change (read by the program)")


# Called only when a flow run fails. `python -m agents.diagnose_cases` gives it
# four real failures and prints its answer next to the cause that was found. In
# this flow a failure seldom names its own cause.
DIAGNOSTICIAN = _join(
    """
A LibreLane backend run of ble_tx on gf180mcuD failed. Say what went wrong and what
to change.
""",
    """
Find the first error in the log, not the last, and name the flow step that failed
(global placement, clock tree synthesis, global routing, detailed routing). Say which
of the given settings most likely caused it and why. If the settings are not to
blame, say so: a tool can crash or reject a command whatever the settings are.
""",
    """
The navigator acts on the remedy next, so write it as one sentence: a setting to
avoid, or a value to change and in which direction. Under evidence, quote the exact
log lines you rely on.
""",
)


# ===================================================================== stop agent
class StopDecision(BaseModel):
    stop: bool = Field(description="true to end the search (read by the program)")
    reason: str = Field(description="One sentence")


# The stop agent's answer is recorded next to the stopping rule in policy.py
# (report.json, stop_decisions). The prompt states that rule so the two can be
# compared where they disagree.
STOP_AGENT = _join(
    """
Decide whether the search should continue or stop early. Your context gives the
budget (including candidates_waiting_for_evaluation), best_score_est_after_each_run
(starting at 1.0 for the baseline), and best_evaluated_score (1.0 until something
beats the baseline).
""",
    f"""
Unused flow runs earn nothing, so stop only when more runs are unlikely to help. The
rule in policy.py stops when the best estimated score has risen by less than
{policy.MIN_GAIN:.1%} over the last {policy.PATIENCE} runs, or when only the runs
held back for final evaluations are left (at most {policy.SPARE_RUNS}). A waiting
candidate is worth a run only if one is left to spend on it. If you disagree with
the rule, say so in the reason.
""",
)


# ===================================================================== per design
_ABOUT_BLE_TX = "ble_tx, a small Bluetooth LE modulator"


def for_design(design_dir) -> dict:
    """NAVIGATOR, STAGE_AGENT, DIAGNOSTICIAN and STOP_AGENT for one design folder.

    The text above is written for designs/ble_tx. Another design folder may hold
      about.txt            one line naming the block, used where the prompts say
                           "ble_tx, a small Bluetooth LE modulator"
      navigator_notes.txt  what the navigator should know about this design and
                           its earlier searches, in place of the ble_tx notes
    Without them a design gets the ble_tx text unchanged. No curly braces in either.
    """
    import re
    from pathlib import Path
    d = Path(design_dir)
    out = {"NAVIGATOR": NAVIGATOR, "STAGE_AGENT": STAGE_AGENT,
           "DIAGNOSTICIAN": DIAGNOSTICIAN, "STOP_AGENT": STOP_AGENT}
    about_f, notes_f = d / "about.txt", d / "navigator_notes.txt"
    if notes_f.is_file():
        notes = notes_f.read_text().strip()
        if "{" in notes or "}" in notes:
            raise ValueError(f"{notes_f}: no curly braces in prompt text")
        out["NAVIGATOR"] = out["NAVIGATOR"].replace(_BLE_TX_NOTES.strip(), notes)
        # The ble_tx text names its own search's objective; a design with its own
        # notes is scored by whatever weights objective shows.
        for k, a, b in (("NAVIGATOR", "say what to improve: in this search, power.",
                         "say what to improve."),
                        ("STAGE_AGENT", "In this search only power is scored, measured from a "
                         "simulated packet.", "Score terms and their weights are in objective; "
                         "power is measured from a simulated packet.")):
            if a not in out[k]:
                raise ValueError(f"prompts.for_design: the {k} text changed; update this rewrite")
            out[k] = out[k].replace(a, b)
    if about_f.is_file():
        about = " ".join(about_f.read_text().split())
        if "{" in about or "}" in about:
            raise ValueError(f"{about_f}: no curly braces in prompt text")
        name = about.split(",")[0].strip()
        pat = re.compile(r"ble_tx,\s+a\s+small\s+Bluetooth\s+LE\s+modulator")
        for k in out:
            out[k] = pat.sub(about, out[k])
            out[k] = re.sub(r"\bble_tx\b(?!_)", name, out[k]) if name != "ble_tx" else out[k]
    return out
