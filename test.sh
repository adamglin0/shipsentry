#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMP_REPORT="$(mktemp)"
trap 'rm -f "$TEMP_REPORT"' EXIT

"$ROOT_DIR/scan.sh" "$ROOT_DIR/sample" "$TEMP_REPORT"

grep -q '| 2 | 4 | 2 | 8 |' "$TEMP_REPORT"
grep -q 'Release build may be debuggable' "$TEMP_REPORT"
grep -q 'Cleartext network traffic is enabled' "$TEMP_REPORT"
grep -q 'WebView exposes a JavaScript bridge' "$TEMP_REPORT"
grep -q 'Development logging remains in source' "$TEMP_REPORT"

printf 'ShipSentry tests passed.\n'

