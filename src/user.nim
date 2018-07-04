import ospaths
import httpclient

let http_proxy = getEnv("http_proxy")
let
  client = newHttpClient(proxy=newProxy(http_proxy))
#  client = newHttpClient()
  body = client.getContent("https://github.com/users/nve3pd/contributions")
echo body
