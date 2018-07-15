import os, osproc
import strutils, sequtils
import tables

import types
export types.colorData

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""

proc getLogs(): seq[string] =
  let (outp, errC) = execCmdEx(git_log)
  if errC != 0:
    echo outp
    quit(1)
  return outp.strip().split("\n")

proc sumLogs(): CountTable[string] =
  result = initCountTable[string]()
  for log in getLogs():
    result.inc(log.split()[0])

proc getAverage(): int =
  return 1

proc repoContributions*(): seq[colorData] =
  result = @[]

if isMainModule:
  echo sumLogs()
