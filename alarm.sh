#!/bin/bash

HOUR=$(date +%H)
MIN=$(date +%M)

TIME="${HOUR}:${MIN}"
echo "$(date) - alarm checked at $TIME" >> /tmp/commandcentre.log

speak() {
  say "$1"
}

popup() {
  osascript -e "display dialog \"$1\" buttons {\"OK\"} default button 1"
}

case "$TIME" in

"23:15")
  speak "Wake up. Fajr prayer time."
  popup "WAKE UP. Fajr prayer time."
  ;;

"04:05")
  speak "Second alarm. Get out of bed."
  popup "SECOND ALARM. Get out of bed."
  ;;

"04:10")
  speak "Third alarm. Move now."
  popup "THIRD ALARM. Move now."
  ;;

"04:15")
  speak "Final alarm. Get up immediately."
  popup "FINAL ALARM. Get up immediately."
  ;;

"04:30")
  speak "Math Block 1 begins now."
  popup "Math Block 1 begins now."
  ;;

"07:30")
  speak "Breakfast."
  popup "Breakfast time."
  ;;

"08:00")
  speak "Math Block 2 begins now."
  popup "Math Block 2 begins now."
  ;;

"13:00")
  speak "Dhuhr prayer and lunch."
  popup "Dhuhr prayer and lunch."
  ;;

"14:00")
  speak "Python Deep Dive begins."
  popup "Python Deep Dive begins."
  ;;

"15:30")
  speak "Stats and Artificial Intelligence preparation."
  popup "Stats and AI preparation."
  ;;

"16:30")
  speak "Asr prayer and tea."
  popup "Asr prayer and tea."
  ;;

"17:15")
  speak "Python Part Two A begins."
  popup "Python Part Two A begins."
  ;;

"18:20")
  speak "Maghrib prayer."
  popup "Maghrib prayer."
  ;;

"18:30")
  speak "Dinner time."
  popup "Dinner time."
  ;;

"18:50")
  speak "Python Part Two B begins."
  popup "Python Part Two B begins."
  ;;

"19:45")
  speak "Stats and Artificial Intelligence Part Two."
  popup "Stats and AI Part Two."
  ;;

"21:00")
  speak "Isha prayer."
  popup "Isha prayer."
  ;;

"21:15")
  speak "Daily review begins."
  popup "Daily review begins."
  ;;

"21:45")
  speak "Sleep release."
  popup "Sleep release."
  ;;
esac