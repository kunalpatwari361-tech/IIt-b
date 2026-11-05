import math

import pytest

from models.credit_scorecard.scorecard import Scorecard, grade_for
from models.credit_scorecard.train import train

from .synthetic import make_applications


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("scorecard")
    result = train(make_applications(), out_dir=out)
    return result, Scorecard.load(out / "artifacts" / "scorecard.json"), out


def test_training_writes_every_output(trained):
    _, _, out = trained
    for path in ["artifacts/scorecard.json", "reports/metrics.json", "reports/grades.csv",
                 "reports/fairness.csv", "reports/points_table.csv"]:
        assert (out / path).exists(), path


def test_learns_the_pattern(trained):
    result, _, _ = trained
    assert result["metrics"]["test"]["auc"] > 0.7
    assert result["metrics"]["export_matches_model"]


def test_never_uses_gender(trained):
    result, card, _ = trained
    assert "CODE_GENDER" not in card.inputs
    assert all("gender" not in name for name in result["metrics"]["inputs_used"])


@pytest.mark.parametrize("score, grade, flag", [
    (900, "A", "pass"), (760, "A", "pass"), (759, "B", "pass"), (700, "B", "pass"),
    (699, "C", "refer"), (650, "C", "refer"), (649, "D", "reject"), (600, "D", "reject"),
    (599, "E", "reject"), (300, "E", "reject"),
])
def test_grade_bands_match_the_report(score, grade, flag):
    assert grade_for(score)[:2] == (grade, flag)


GOOD = {"bureau_score_1": 0.8, "bureau_score_2": 0.75, "bureau_score_3": 0.8, "payment_to_income": 0.1,
        "loan_to_income": 2.0, "loan_to_price": 1.0, "owns_property": "yes", "years_employed": 10,
        "age_years": 42, "employment_type": "salaried"}


def test_output_follows_the_shared_contract(trained):
    _, card, _ = trained
    out = card.score(GOOD)
    for key in ["model", "model_version", "score", "grade", "flag", "reason_code",
                "probability_of_default", "points", "top_reasons"]:
        assert key in out
    assert 300 <= out["score"] <= 900
    assert out["flag"] in {"pass", "refer", "reject"}
    assert 0 < out["probability_of_default"] < 1


def test_points_add_up_to_the_score(trained):
    _, card, _ = trained
    out = card.score(GOOD)
    total = out["base_score"] + sum(p["points"] for p in out["points"])
    assert out["score"] == min(900, max(300, total))


def test_better_bureau_score_never_lowers_the_score(trained):
    _, card, _ = trained
    weak = card.score({**GOOD, "bureau_score_2": 0.15})
    strong = card.score({**GOOD, "bureau_score_2": 0.85})
    assert strong["score"] >= weak["score"]


def test_weak_profile_gets_reasons(trained):
    _, card, _ = trained
    weak = {**GOOD, "bureau_score_1": 0.1, "bureau_score_2": 0.1, "bureau_score_3": 0.1,
            "payment_to_income": 0.4}
    out = card.score(weak)
    assert out["grade"] in {"C", "D", "E"}
    assert out["reason_code"] in {"R-RSK-01", "R-RSK-02"}
    assert out["top_reasons"]


def test_missing_and_unknown_inputs_still_score(trained):
    _, card, _ = trained
    out = card.score({"employment_type": "astronaut"})
    assert 300 <= out["score"] <= 900
    assert not math.isnan(out["probability_of_default"])


def test_single_and_batch_scoring_agree(trained):
    _, card, _ = trained
    import pandas as pd
    batch = card.score_frame(pd.DataFrame([GOOD]))
    assert int(batch["score"].iloc[0]) == card.score(GOOD)["score"]
