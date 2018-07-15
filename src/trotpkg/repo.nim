import os, osproc, times
import strutils, sequtils
import tables

import types
export types.colorData

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""
  colors = @["#ebedf0", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]

proc `$`(t: TimeInfo) : string =
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

proc getAverage(logs: CountTable[string]): int =
  result = 0
  for i in logs.values():
    result += i
  return (result div len(logs))

proc getColorCode(cnt, average: int): string =
  result = ""
  if cnt in 1..(average - 1):
    result = colors[1]
  elif cnt in average..(average * 2 - 1):
    result = colors[2]
  elif cnt in (average * 2)..(average * 3 - 1):
    result = colors[3]
  else:
    result = colors[4]

proc repoContributions*(): seq[colorData] =
  result = @[]
  let
    today: Timeinfo = getLocalTime(getTime())
    lastYear: Timeinfo = today - 1.years
    logs: CountTable[string] = sumLogs()
    ave: int = getAverage(logs)
  var cnt = 1

  while $(lastYear + cnt.days) != $today:
    var tmp: colorData
    if logs.hasKey($(lastYear + cnt.days)):
      tmp = (
        $($(lastYear + cnt.days)),
        getColorCode(logs[$(lastYear + cnt.days)], ave)
      )
    else:
      tmp = (
        $($(lastYear + cnt.days)),
        colors[0]
      )
    result.add(tmp)
    cnt += 1

if isMainModule:
  echo $repoContributions()
