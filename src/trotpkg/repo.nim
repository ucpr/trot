import os, osproc, times
import strutils, sequtils
import tables

import types
export types.colorData

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""
  colors = @["#FFFFFF", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]

proc `$`(t:TimeInfo) : string =
  return format(t, "yyyy-MM-dd")

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
  let
    today: Timeinfo = getLocalTime(getTime())
    lastYear: Timeinfo = today - 1.years
    logs: CountTable[string] = sumLogs()
  var cnt = 1

  while $(lastYear + cnt.days) != $today:
    var tmp: colorData
    if logs.hasKey($(lastYear + cnt.days)):
      tmp = (
        $($(lastYear + cnt.days)),
        "hoge"
      )
    else:
      tmp = (
        $($(lastYear + cnt.days)),
        "0"
      )
    result.add(tmp)
    cnt += 1

if isMainModule:
  echo $repoContributions()
