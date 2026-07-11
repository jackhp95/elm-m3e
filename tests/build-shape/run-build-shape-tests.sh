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
# Positive test
# ---------------------------------------------------------------------------
positive="BuildShapeTest.elm"
echo "== Positive: $positive must compile =="
if ! pos_out=$("$ELM" make "$positive" --output=/dev/null 2>&1); then
    echo "FAIL: positive test did not compile"
    echo "$pos_out"
    exit 1
fi
echo "$pos_out" | tail -3
echo "OK: positive compiled"

echo

# ---------------------------------------------------------------------------
# Negative test
# ---------------------------------------------------------------------------
negative="BuildShapeNegative.elm"
echo "== Negative: $negative must NOT compile =="
neg_out=$("$ELM" make "$negative" --output=/dev/null 2>&1 || true)

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

# Check for at least one of the expected phantom-type tokens.
# Elm's error messages have varied historically — require TYPE MISMATCH plus
# at least one phantom-marker token.  The script greps for any of four tokens
# (two per failure) rather than all four simultaneously, because a compilation
# may short-circuit after the first error under some elm versions.
if echo "$neg_out" | grep -qE "Available|Used|NotFilled|Filled"; then
    echo "OK: negative failed with TYPE MISMATCH containing phantom-type tokens"
else
    echo "WARN: negative failed with TYPE MISMATCH but phantom-type tokens (Available/Used/NotFilled/Filled) not found in output."
    echo "      This may indicate a compiler version difference — inspect the error below."
    echo "$neg_out" | tail -20
    # Still consider this a pass: TYPE MISMATCH is the hard requirement.
fi

echo
echo "$neg_out" | tail -10

echo
echo "== ALL BUILD SHAPE TYPE TESTS PASSED =="
