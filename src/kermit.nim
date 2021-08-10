import libsodium/sodium
import httpclient
import prologue
import json

let config = parseJson(readFile("config.json"))
let appSettings = newSettings(
  appName="Kermit Bot",
  address=config["address"].getStr(),
  port=Port(config["port"].getInt()),
  debug=config["debug"].getBool()
)

let app = newApp(appSettings)
let http = newAsyncHttpClient()

proc setupInteractions() {.async.} =
  discard

proc interaction(ctx: Context) {.async, gcsafe.} =
  # verify the request
  let signature = ctx.request.getHeader("X-Signature-Ed25519")[0]
  let timestamp = ctx.request.getHeader("X-Signature-Timestamp")[0]
  verify_message(config["application_public_key"].getStr(), timestamp&ctx.request.body, signature)

# add route
app.post("/interaction", interaction)

app.run()
