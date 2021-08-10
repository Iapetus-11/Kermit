import ed25519

proc toHexChar*(c: char): byte =
  case c
  of '0'..'9': result = byte(ord(c) - ord('0'))
  of 'a'..'f': result = byte(ord(c) - ord('a') + 10)
  of 'A'..'F': result = byte(ord(c) - ord('A') + 10)
  else:
    raise newException(ValueError, $c & "is not a valid hex character")

proc hexStringToPublicKey*(s: string): PublicKey =
  var byteArray: array[32, byte]

  for i in 0..31:
    byteArray[i] = toHexChar(s[i])

  return PublicKey(byteArray)

proc hexStringToSignature*(s: string): Signature =
  var byteArray: array[64, byte]

  for i in 0..63:
    byteArray[i] = toHexChar(s[i])

  return Signature(byteArray)
