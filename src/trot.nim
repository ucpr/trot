import os
import osproc
import strutils
import sequtils
import terminal
from colors as cs import parseColor

enableTrueColors()

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""
  colors = @["#FFFFFF", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]
  space = "  "

#[
for i in colors:
  setBackgroundColor(stdout, parseColor(i))
  stdout.write(space)
  resetAttributes(stdout)
  echo "reset"
]#

proc get_log(): seq[string] =
  let (outp, errC) = execCmdEx(git_log)
  if errC != 0:
    echo outp
    quit(1)
  return outp.strip().split("\n")

proc main(): void =
  echo "Hello World"

if isMainModule:
  for i in get_log():
    echo i
