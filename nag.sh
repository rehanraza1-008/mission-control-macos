#!/bin/bash
# ══════════════════════════════════════════════════════════════
# nag.sh — 5-minute study-block reminder
# Called every 5 minutes by a macOS LaunchAgent.
# Sends a notification banner when you should be studying.
# ══════════════════════════════════════════════════════════════

HOUR=$((10#$(date +%H)))
MIN=$((10#$(date +%M)))
NOW=$((HOUR * 60 + MIN))

notify() {
  osascript -e "display notification \"$1\" with title \"$2\" sound name \"Basso\""
}

# ── Study blocks only ────────────────────────────────────────
# Math Block 1:        04:30 – 07:30  (270 – 450)
# Math Block 2:        08:00 – 13:00  (480 – 780)
# Python Part 1:       14:00 – 15:30  (840 – 930)
# Stats & AI Part 1:   15:30 – 16:30  (930 – 990)
# Python 2A:           17:15 – 18:20  (1035 – 1100)
# Python 2B:           18:50 – 19:45  (1130 – 1185)
# Stats & AI Part 2:   19:45 – 21:00  (1185 – 1260)

REM=0
BLOCK=""
EMOJI=""

if   [ $NOW -ge 270 ]  && [ $NOW -lt 450 ]; then
  REM=$(( 450 - NOW ))
  BLOCK="Math Block 1"
  EMOJI="📐"

elif [ $NOW -ge 480 ] && [ $NOW -lt 780 ]; then
  REM=$(( 780 - NOW ))
  BLOCK="Math Block 2"
  EMOJI="📐"

elif [ $NOW -ge 840 ] && [ $NOW -lt 930 ]; then
  REM=$(( 930 - NOW ))
  BLOCK="Python Deep Dive Pt 1"
  EMOJI="🐍"

elif [ $NOW -ge 930 ] && [ $NOW -lt 990 ]; then
  REM=$(( 990 - NOW ))
  BLOCK="Stats & AI Prep Pt 1"
  EMOJI="📊"

elif [ $NOW -ge 1035 ] && [ $NOW -lt 1100 ]; then
  REM=$(( 1100 - NOW ))
  BLOCK="Python Deep Dive 2A"
  EMOJI="🐍"

elif [ $NOW -ge 1130 ] && [ $NOW -lt 1185 ]; then
  REM=$(( 1185 - NOW ))
  BLOCK="Python Deep Dive 2B"
  EMOJI="🐍"

elif [ $NOW -ge 1185 ] && [ $NOW -lt 1260 ]; then
  REM=$(( 1260 - NOW ))
  BLOCK="Stats & AI Prep Pt 2"
  EMOJI="📊"
fi

# ── Only fire if we're in a study block ─────────────────────
if [ -n "$BLOCK" ]; then
  H=$(( REM / 60 ))
  M=$(( REM % 60 ))

  if   [ $H -gt 0 ]; then  DUR="${H}h ${M}m remaining"; 
  else                      DUR="${M} mins remaining"; fi

  notify "${EMOJI} ${DUR} — Are you still working?" "${EMOJI} ${BLOCK} — CHECK IN"
fi
