import os, osproc
import strutils, sequtils

import types
export types.colorData

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""
 
proc get_log(): seq[string] =
  let (outp, errC) = execCmdEx(git_log)
  if errC != 0:
    echo outp
    quit(1)
  return outp.strip().split("\n")

proc sumLogs(): seq[string] =
  return

proc getAverage(): int =
  return 1

proc repoContributions*(): seq[colorData] =
  result = @[]

if isMainModule:
  echo get_log()
