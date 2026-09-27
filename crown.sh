#!/usr/bin/env bash
# Animated crown for the LazyVim dashboard: twinkling jewels + drifting Z's.
# Loops until the dashboard closes (pass a number of seconds to stop after that instead).

DURATION=${1:-0}    # seconds to animate; 0 = loop forever
DELAY=0.25          # seconds per frame
PAD="            "  # left padding to center the art in the dashboard section

GOLD=$'\e[38;5;220m'
RED=$'\e[38;5;196m'
BLUE=$'\e[38;5;39m'
WHITE=$'\e[97m'
DIM=$'\e[38;5;244m'
RESET=$'\e[0m'

crown=(
  "    o       o       o       o    "
  "   / \\     / \\     / \\     / \\   "
  "  /   \\   /   \\   /   \\   /   \\  "
  " /     \\ /     \\ /     \\ /     \\ "
  "/       V       V       V       \\"
  "JEWELS"
  "|_______________________________|"
)

# Z trail: 5 rows to the right of the crown, each Z rises one row per frame
zline() {
  local row=$1 frame=$2 out="" z pos col ch
  local line="            "
  for z in 0 3 6; do
    pos=$(( (frame + z) % 9 ))        # 0..8, only 0..4 are visible
    if (( pos <= 4 )); then
      local r=$(( 4 - pos ))           # starts at bottom row, moves up
      if (( r == row )); then
        col=$(( 1 + pos * 2 ))
        (( pos >= 3 )) && ch="Z" || ch="z"
        line="${line:0:col}${ch}${line:col+1}"
      fi
    fi
  done
  printf '%s%s%s' "$DIM" "$line" "$RESET"
}

jewels() {
  local frame=$1 out="${GOLD}|${RESET}" i color
  for i in 0 1 2 3; do
    (( i % 2 == 0 )) && color=$RED || color=$BLUE
    if (( (frame + i * 3) % 8 < 2 )); then
      out+="  ${GOLD}(${WHITE}*${GOLD})${RESET}"
    else
      out+="  ${GOLD}(${color}o${GOLD})${RESET}"
    fi
    (( i < 3 )) && out+="  ${GOLD}+${RESET}"
  done
  out+="  ${GOLD}|${RESET}"
  printf '%s' "$out"
}

tops() {
  # The four peak tips sparkle in sequence
  local frame=$1 line="    o       o       o       o    " i c
  local active=$(( frame % 4 ))
  local out=""
  for (( i = 0; i < ${#line}; i++ )); do
    c=${line:i:1}
    if [[ $c == "o" ]]; then
      local idx=$(( (i - 4) / 8 ))
      if (( idx == active )); then out+="${WHITE}*${GOLD}"; else out+="o"; fi
    else
      out+="$c"
    fi
  done
  printf '%s%s%s' "$GOLD" "$out" "$RESET"
}

draw() {
  local frame=$1 i
  for i in "${!crown[@]}"; do
    # Jump to the start of row i+1 instead of printing newlines. A newline after
    # the last row would scroll the small dashboard terminal, and the window
    # would stay stuck showing the first frame from the scrollback.
    printf '\e[%d;1H' $(( i + 1 ))
    printf '%s' "$PAD"
    if (( i == 0 )); then
      tops "$frame"
    elif [[ ${crown[i]} == "JEWELS" ]]; then
      jewels "$frame"
    else
      printf '%s%s%s' "$GOLD" "${crown[i]}" "$RESET"
    fi
    (( i <= 4 )) && zline "$i" "$frame"
    printf '\e[K'
  done
}

printf '\e[?25l\e[2J'          # hide cursor, clear once
trap 'printf "\e[?25h"' EXIT

if (( DURATION == 0 )); then
  # Loop forever (until the dashboard closes)
  f=0
  while :; do
    draw "$f"
    f=$(( (f + 1) % 72 ))   # 72 = common cycle of all the animations
    sleep "$DELAY"
  done
fi

frames=$(awk "BEGIN { print int($DURATION / $DELAY) }")
for (( f = 0; f < frames; f++ )); do
  draw "$f"
  sleep "$DELAY"
done
draw 0
# Keep the process alive (idle) so the final frame stays on screen
while :; do sleep 3600; done
