#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMP_REPORT="$(mktemp)"
IN_PROJECT_REPORT="$ROOT_DIR/sample/shipsentry-report.md"
CLEAN_PROJECT="$(mktemp -d)"
trap 'rm -f "$TEMP_REPORT" "$IN_PROJECT_REPORT"; rm -rf "$CLEAN_PROJECT"' EXIT

"$ROOT_DIR/scan.sh" "$ROOT_DIR/sample" "$TEMP_REPORT"

grep -q '| 2 | 4 | 2 | 8 |' "$TEMP_REPORT"
grep -q 'Release build may be debuggable' "$TEMP_REPORT"
grep -q 'Cleartext network traffic is enabled' "$TEMP_REPORT"
grep -q 'WebView exposes a JavaScript bridge' "$TEMP_REPORT"
grep -q 'Development logging remains in source' "$TEMP_REPORT"

"$ROOT_DIR/scan.sh" "$ROOT_DIR/sample" "$IN_PROJECT_REPORT"
"$ROOT_DIR/scan.sh" "$ROOT_DIR/sample" "$IN_PROJECT_REPORT"
grep -q '| 2 | 4 | 2 | 8 |' "$IN_PROJECT_REPORT"

printf 'rootProject.name = "CleanSample"\n' > "$CLEAN_PROJECT/settings.gradle.kts"
"$ROOT_DIR/scan.sh" "$CLEAN_PROJECT" "$TEMP_REPORT"
grep -q '| 0 | 0 | 0 | 0 |' "$TEMP_REPORT"
grep -q 'No patterns were flagged' "$TEMP_REPORT"

printf 'ShipSentry tests passed.\n'

