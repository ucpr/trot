import os, osproc, times
import strutils, sequtils
import tables

import types
export types.colorData

const
  git_log = "git log --oneline --branches --reverse --since=\"1year\" --date=iso --pretty=format:\"%ad\""
  colors = @["#ebedf0", "#C6E48B", "#7BC96F", "#239A3B", "#196127"]
  days = @["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

proc `$`(t: DateTime) : string =
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

proc getLastYear(today: DateTime): DateTime =
  result = today - 1.years - days.find($today.weekday).days

proc repoContributions*(): seq[colorData] =
  result = @[]
  let
    today: DateTime = local(now())
    lastYear: DateTime = getLastYear(today)
    logs: CountTable[string] = sumLogs()
    ave: int = getAverage(logs)
  var cnt = 1

  echo lastYear, " - ", today
  while $(lastYear + cnt.days) != $(today + 1.days):
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
  echo repoContributions().len()
