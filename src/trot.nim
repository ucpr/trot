import os, osproc, terminal, times
import strutils, sequtils
from colors as cs import parseColor

enableTrueColors()

const
  Version = "0.1.0"
  colors = @["#FFFFFF", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]
  days = @["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  space = "  "

#[
for i in colors:
  setBackgroundColor(stdout, parseColor(i))
  stdout.write(space)
  resetAttributes(stdout)
  echo "reset"
]#

proc print_glass(): void =
  for i in days:
    echo i

proc main(): void =
  echo "Hello World"

if isMainModule:
  main()
