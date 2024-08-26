#!/bin/sh
echo -ne '\033c\033]0;DustShift- Last Liquidation\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DustShift_LastLiquidation.x86_64" "$@"
