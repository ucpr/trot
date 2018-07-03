import os, osproc, terminal, times
import strutils, sequtils
from colors as cs import parseColor

enableTrueColors()

const
  colors = @["#FFFFFF", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]
  space = "  "

#[
for i in colors:
  setBackgroundColor(stdout, parseColor(i))
  stdout.write(space)
  resetAttributes(stdout)
  echo "reset"
]#

proc main(): void =
  echo "Hello World"

if isMainModule:
  main()
