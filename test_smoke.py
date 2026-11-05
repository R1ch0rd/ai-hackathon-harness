from eval import evaluate


def test_evaluate_returns_dict():
    assert isinstance(evaluate(), dict)
