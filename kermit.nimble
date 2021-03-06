# Package

version       = "0.0.0"
author        = "Milo Weinberg"
description   = "Kermit Bot, a Discord bot written in Nim using Discord interactions / slash commands"
license       = "MIT"
srcDir        = "src"
bin           = @["kermit"]


# Dependencies

requires "nim >= 1.4.8"
requires "ed25519 >= 0.1.0"
requires "prologue >= 0.4.4"
