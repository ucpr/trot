import ospaths
import httpclient
import strutils, sequtils
import nre, options

import types

let
  http_proxy = getEnv("http_proxy")
  regex = re".*<rect.*>.*"
  reColor = re"fill=\S#\w{6}\S"
  reDate = re"data-date=\S\d{4}-\d{1,2}-\d{1,2}\S"

let
#  client = newHttpClient(proxy=newProxy(http_proxy))
  client = newHttpClient()
  body = client.getContent("https://github.com/users/nve3pd/contributions")

for i in body.strip().split("\n"):
  let r = i.match(regex)
  if not r.isnone:
    echo $($r.get()).find(reColor).get()
    echo $($r.get()).find(reDate).get()
