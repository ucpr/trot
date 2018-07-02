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

for i in colors:
  setBackgroundColor(stdout, parseColor(i))
  stdout.write(space)
  resetAttributes(stdout)
  echo "reset"

proc get_log(): string =
  let (outp, errC) = execCmdEx(git_log)
  return outp

if isMainModule:
  echo get_log()
