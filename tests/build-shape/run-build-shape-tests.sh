#!/usr/bin/env bash
# Orchestrate positive + negative type-behavior tests for ⑤ Build shape.
# Exit 0 on success, 1 on any failure.
set -uo pipefail

TESTS_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$TESTS_DIR/../.." && pwd)"

# Elm binary: prefer repo-local over PATH
ELM="${REPO_ROOT}/node_modules/.bin/elm"
if [ ! -x "$ELM" ]; then
    ELM="elm"
fi

echo "== elm: $ELM =="
echo "== tests dir: $TESTS_DIR =="
echo

# All elm make calls run from the tests dir (picks up tests/elm.json)
cd "$TESTS_DIR"

# ---------------------------------------------------------------------------
# Positive tests (each must compile)
# ---------------------------------------------------------------------------
run_positive() {
    local file="$1"
    echo "== Positive: $file must compile =="
    if ! pos_out=$("$ELM" make "$file" --output=/dev/null 2>&1); then
        echo "FAIL: positive test did not compile"
        echo "$pos_out"
        exit 1
    fi
    echo "$pos_out" | tail -3
    echo "OK: $file compiled"
    echo
}

run_positive "BuildShapeTest.elm"
run_positive "WS5Positive.elm"
run_positive "WS6Positive.elm"

# ---------------------------------------------------------------------------
# Negative tests (each must fail with TYPE MISMATCH)
# ---------------------------------------------------------------------------
run_negative() {
    local file="$1"
    echo "== Negative: $file must NOT compile =="
    neg_out=$("$ELM" make "$file" --output=/dev/null 2>&1 || true)

    if echo "$neg_out" | grep -q "^Success!"; then
        echo "FAIL: negative test compiled but should not have"
        echo "$neg_out"
        exit 1
    fi

    if ! echo "$neg_out" | grep -qi "TYPE MISMATCH"; then
        echo "FAIL: negative test exited non-zero but did not report a TYPE MISMATCH"
        echo "$neg_out"
        exit 1
    fi

    echo "OK: $file failed with TYPE MISMATCH"
    echo "$neg_out" | tail -6
    echo
}

run_negative "BuildShapeNegative.elm"
run_negative "WS5Negative1.elm"
run_negative "WS5Negative2.elm"
run_negative "WS6Negative.elm"

echo "== ALL BUILD SHAPE TYPE TESTS PASSED =="
