import asyncdispatch
import httpclient
import prologue
import ed25519
import json

include utils

let config = parseJson(readFile("config.json"))
let publicKey = config["application_public_key"].getStr.hexStringToPublicKey

let http = newAsyncHttpClient()

proc setupInteractions() {.async.} =
  discard

proc startup() {.gcsafe, async.} =
  await setupInteractions()
  echo "Kermit started! Webhook listening on ", config["address"].getStr(), ":", config["port"].getInt(), "!"

let appSettings = newSettings(
  appName = "Kermit Bot",
  address = config["address"].getStr(),
  port = Port(config["port"].getInt()),
  debug = config["debug"].getBool()
)

let app = newApp(appSettings, startup = @[initEvent(startup)])

proc interaction(ctx: Context) {.async, gcsafe.} =
  # verify the request
  let signature = ctx.request.getHeader("X-Signature-Ed25519")[0].hexStringToSignature
  let timestamp = ctx.request.getHeader("X-Signature-Timestamp")[0]

  let verified = verify(timestamp&ctx.request.body, signature, publicKey)

  if not verified:
    resp "Unauthorized", Http401

  # actually handle interactions

  resp "sus", Http200

# add route
app.post("/interaction", interaction)

app.run()
