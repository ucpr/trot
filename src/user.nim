import ospaths
import httpclient
import strutils, sequtils
import nre, options

import types
export types.colorData

let
  regex = re".*<rect.*>.*"
  reColor = re"fill=\S#\w{6}\S"
  reDate = re"data-date=\S\d{4}-\d{1,2}-\d{1,2}\S"

  http_proxy = if existsEnv("http_proxy"): getEnv("http_proxy") else: nil
  client = newHttpClient(proxy = if http_proxy.isNil: nil else: newProxy(http_proxy))
  body = client.getContent("https://github.com/users/nve3pd/contributions")

proc userContributions*(): seq[colorData] =
  result = @[]
  for i in body.strip().split("\n"):
    let r = i.match(regex)
    if not r.isNone:
      let tmp: colorData = (
        $($r.get()).find(reDate).get(),
        $($r.get()).find(reColor).get()
      )
      result.add(tmp)

if isMainModule:
  for i in userContributions():
    echo i
