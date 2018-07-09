import os, osproc, terminal, times
import strutils, sequtils
import times
from colors as cs import parseColor

import user

enableTrueColors()

const
  Version = "0.1.0"
  colors = @["#FFFFFF", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]
  days = @["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  space = "  "

#[
for i in colors:
  setBackgroundColor(stdout, parseColor(i))
  stdout.write(space)
  resetAttributes(stdout)
  echo "reset"
]#

proc outputColor(color: string): void =
  setBackgroundColor(stdout, parseColor(color))
  write(stdout, space)
  resetAttributes(stdout)

proc print_glass(glassData: seq[colorData]): void =
  for i in days:
    write(stdout, i[0..2] & " ")
    for j in glassData:
      let d: string = $parse(j.date, "yyyy-MM-dd").weekday
      if d == i:
        outputColor(j.color)
    write(stdout, "\n")

proc main(): void =
  print_glass(userContributions())

if isMainModule:
  main()
