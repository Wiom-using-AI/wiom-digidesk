#!/usr/bin/env bash
set -euo pipefail

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

bash -n debugging_cli
help_output="$(./debugging_cli --help)"
[[ "$help_output" == *"DigiDesk debugging CLI"* ]]
[[ "$help_output" == *"docs/runbooks/debugging.md"* ]]

export GH_HIMADRI_PAT="debugging-cli-gh-secret"
export HIMADRI_VERCEL_TOKEN="debugging-cli-vercel-secret"
export HIMADRI_SUPABASE_ACCESS_TOKEN="debugging-cli-supabase-secret"

status_output="$(./debugging_cli status)"
doctor_output="$(./debugging_cli doctor --env dev)"
combined="$status_output
$doctor_output"

[[ "$status_output" == *"expected: himadrineogi-source/wiom-digidesk"* ]]
[[ "$status_output" == *"https://wiom-digidesk.vercel.app"* ]]
[[ "$doctor_output" == *"doctor passed (dev; offline)"* ]]

for secret in "$GH_HIMADRI_PAT" "$HIMADRI_VERCEL_TOKEN" "$HIMADRI_SUPABASE_ACCESS_TOKEN"; do
  [[ "$combined" != *"$secret"* ]] || {
    printf 'secret value appeared in debugging output\n' >&2
    exit 1
  }
done

if ./debugging_cli doctor --env qa >/dev/null 2>&1; then
  printf 'invalid environment was accepted\n' >&2
  exit 1
fi
if ./debugging_cli unknown-command >/dev/null 2>&1; then
  printf 'unknown command was accepted\n' >&2
  exit 1
fi
if ./debugging_cli logs --env dev >/dev/null 2>&1; then
  printf 'development logs unexpectedly invoked a provider path\n' >&2
  exit 1
fi

printf 'debugging CLI smoke passed\n'
