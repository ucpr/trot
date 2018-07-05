import ospaths
import httpclient
import strutils, sequtils
import re

let
  http_proxy = getEnv("http_proxy")
  regex = re""".*<rect class="day" .*>.*"""

let
#  client = newHttpClient(proxy=newProxy(http_proxy))
  client = newHttpClient()
  body = client.getContent("https://github.com/users/nve3pd/contributions")

for i in body.strip().split("\n"):
  if i.match(regex):
    echo i.strip()
