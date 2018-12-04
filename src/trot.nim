import os, osproc, terminal, times
import strutils, sequtils
import parseopt
import strformat
from colors as cs import parseColor

import trotpkg/[user, repo]

enableTrueColors()

const
  Version = "0.1.0"
  days = @["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  space = "  "
  
proc writeHelp(): void =
  echo """
  trot is a CLI Application that expresses grass of GitHub at terminal.
  Usage: trot [OPTION] [username]
         trot -h | --help
         trot -v | --version
  Option:
    -h --help      show this screen.
    -v --version   show version."""

proc writeVersion(): void =
  echo fmt"trot version {Version}"

proc drawColor(color: string): void =
  setBackgroundColor(stdout, parseColor(color))
  write(stdout, space)
  resetAttributes(stdout)

proc writeGlass(glassData: seq[colorData]): void =
  for i in days:
    write(stdout, i[0..2] & " ")
    for j in glassData:
      let d: string = $parse(j.date, "yyyy-MM-dd").weekday
      if d == i:
        drawColor(j.color)
    write(stdout, "\n")

proc main(): void =
  if paramCount() == 0:
    writeGlass(repoContributions())
    quit(0)

  let params = commandLineParams()
  var p = initOptParser(params)
  for kind, key, val in p.getopt():
    case kind
    of cmdArgument:
      let glassData = userContributions(key)
      if glassData.len == 0:
        echo fmt"cannot find {val}"
        quit(1)
      writeGlass(glassData)
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": writeHelp()
      of "version", "v": writeVersion()
    of cmdEnd: assert(false)  # cannot happen

if isMainModule:
  main()
