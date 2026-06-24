#!/bin/bash
# ══════════════════════════════════════════════════════════════
# setup.sh — Timetable Notification System Installer
# Run this ONCE. It installs two macOS LaunchAgents:
#   1. Exact block-transition alerts (dialogs + voice)
#   2. 5-minute study-block nag notifications
# ══════════════════════════════════════════════════════════════

set -e

# ── 1. Setup paths ───────────────────────────────────────────
INSTALL_DIR="$HOME/timetable"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
HTML="$INSTALL_DIR/timetable.html"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║        TIMETABLE SYSTEM — INSTALLER              ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "▸ Installing to: $INSTALL_DIR"
echo ""

# ── 2. Create install directory and copy files ───────────────
mkdir -p "$INSTALL_DIR"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/timetable.html" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/notifier.sh"    "$INSTALL_DIR/"
cp "$SCRIPT_DIR/nag.sh"         "$INSTALL_DIR/"

chmod +x "$INSTALL_DIR/notifier.sh"
chmod +x "$INSTALL_DIR/nag.sh"

echo "✓ Files copied to $INSTALL_DIR"

# ── 3. Remove old LaunchAgents if they exist ─────────────────
for LABEL in com.timetable.alerts com.timetable.nag; do
  PLIST="$LAUNCH_AGENTS/${LABEL}.plist"
  if [ -f "$PLIST" ]; then
    launchctl unload "$PLIST" 2>/dev/null || true
    rm "$PLIST"
    echo "✓ Removed old: ${LABEL}"
  fi
done

# ── 4. Create LaunchAgent — EXACT BLOCK TRANSITION ALERTS ────
# Uses StartCalendarInterval to fire at precise times.
cat > "$LAUNCH_AGENTS/com.timetable.alerts.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>             <string>com.timetable.alerts</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>${INSTALL_DIR}/notifier.sh</string>
  </array>

  <!-- Fire at each schedule block transition -->
  <key>StartCalendarInterval</key>
  <array>
    <!-- WAKE-UP ALARMS -->
    <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>0</integer></dict>
    <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>5</integer></dict>
    <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>10</integer></dict>
    <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>15</integer></dict>
    <!-- MATH BLOCK 1 -->
    <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>30</integer></dict>
    <!-- BREAKFAST -->
    <dict><key>Hour</key><integer>7</integer><key>Minute</key><integer>30</integer></dict>
    <!-- MATH BLOCK 2 -->
    <dict><key>Hour</key><integer>8</integer><key>Minute</key><integer>0</integer></dict>
    <!-- DHUHR + LUNCH -->
    <dict><key>Hour</key><integer>13</integer><key>Minute</key><integer>0</integer></dict>
    <!-- PYTHON PART 1 -->
    <dict><key>Hour</key><integer>14</integer><key>Minute</key><integer>0</integer></dict>
    <!-- STATS & AI PART 1 -->
    <dict><key>Hour</key><integer>15</integer><key>Minute</key><integer>30</integer></dict>
    <!-- ASR PRAYER -->
    <dict><key>Hour</key><integer>16</integer><key>Minute</key><integer>30</integer></dict>
    <!-- PYTHON 2A -->
    <dict><key>Hour</key><integer>17</integer><key>Minute</key><integer>15</integer></dict>
    <!-- MAGHRIB PRAYER -->
    <dict><key>Hour</key><integer>18</integer><key>Minute</key><integer>20</integer></dict>
    <!-- DINNER -->
    <dict><key>Hour</key><integer>18</integer><key>Minute</key><integer>30</integer></dict>
    <!-- PYTHON 2B -->
    <dict><key>Hour</key><integer>18</integer><key>Minute</key><integer>50</integer></dict>
    <!-- STATS & AI PART 2 -->
    <dict><key>Hour</key><integer>19</integer><key>Minute</key><integer>45</integer></dict>
    <!-- ISHA PRAYER -->
    <dict><key>Hour</key><integer>21</integer><key>Minute</key><integer>0</integer></dict>
    <!-- FINAL REVIEW -->
    <dict><key>Hour</key><integer>21</integer><key>Minute</key><integer>15</integer></dict>
    <!-- SLEEP RELEASE -->
    <dict><key>Hour</key><integer>21</integer><key>Minute</key><integer>45</integer></dict>
  </array>

  <key>StandardOutPath</key>  <string>/tmp/timetable_alerts.log</string>
  <key>StandardErrorPath</key> <string>/tmp/timetable_alerts_err.log</string>
</dict>
</plist>
PLIST

echo "✓ Created: com.timetable.alerts.plist"

# ── 5. Create LaunchAgent — 5-MINUTE NAG ─────────────────────
# Fires every 5 minutes; nag.sh checks if in a study block.
cat > "$LAUNCH_AGENTS/com.timetable.nag.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>             <string>com.timetable.nag</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>${INSTALL_DIR}/nag.sh</string>
  </array>

  <!-- Run every 5 minutes (300 seconds) -->
  <key>StartInterval</key>     <integer>300</integer>
  <key>RunAtLoad</key>         <true/>

  <key>StandardOutPath</key>   <string>/tmp/timetable_nag.log</string>
  <key>StandardErrorPath</key> <string>/tmp/timetable_nag_err.log</string>
</dict>
</plist>
PLIST

echo "✓ Created: com.timetable.nag.plist"

# ── 6. Load both LaunchAgents ─────────────────────────────────
launchctl load "$LAUNCH_AGENTS/com.timetable.alerts.plist"
launchctl load "$LAUNCH_AGENTS/com.timetable.nag.plist"

echo "✓ LaunchAgents loaded and active"

# ── 7. Open the dashboard ─────────────────────────────────────
open "$HTML"
echo "✓ Dashboard opened in browser"

# ── 8. Notification permission check ─────────────────────────
echo ""
echo "══════════════════════════════════════════════════"
echo "  INSTALLATION COMPLETE"
echo "══════════════════════════════════════════════════"
echo ""
echo "  Dashboard: $HTML"
echo "  (Pin this tab — or drag to another monitor)"
echo ""
echo "  Alerts fire at every block transition."
echo "  Nag banners fire every 5 mins during study blocks."
echo ""
echo "  ⚠  IMPORTANT — GRANT NOTIFICATION PERMISSION:"
echo "  If popups don't appear, go to:"
echo "  System Settings → Notifications → Terminal → Allow"
echo ""
echo "  To UNINSTALL, run:"
echo "  launchctl unload ~/Library/LaunchAgents/com.timetable.alerts.plist"
echo "  launchctl unload ~/Library/LaunchAgents/com.timetable.nag.plist"
echo "  rm -rf ~/timetable"
echo "══════════════════════════════════════════════════"
echo ""
