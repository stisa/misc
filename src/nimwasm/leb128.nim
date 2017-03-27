from math import log2,ceil

proc signedLEB128* (value:int32):string =
  var 
    val = value
    # log2 is expensive, could be replace by a lookup table
    size = ceil(log2(abs(val).float)).int32
    more = true
    isNegative = (value < 0)
    b = 0'i32
  while more:
    # get 7 least significant bits
    b = val and 127
    # left shift value 7 bits
    val = val shr 7
    if isNegative:
      # extend sign
      val = (val or (- (1 shr (size - 7)))).int32
    # sign bit of byte is second high order bit
    if ((val == 0 and ((b and 0x40) == 0)) or ((val == -1 and ((b and 0x40) == 0x40)))):
        # calculation is complete
        more = false
    else:
        b = b or 128
    if result.isnil: result = $chr(b)
    else: add result, chr(b)

proc unsignedLEB128* (value:int32, padding:int=0):string =
  var
    val = value
    b = 0
    pad = padding
  # no padding unless specified
  b = val and 127
  val = val shr 7
  if val != 0 or pad > 0:
    b = b or 128
  result = $chr(b)
  dec pad
  
  while val != 0 or pad > -1:
    b = val and 127
    val = val shr 7
    if val != 0 or padding > 0:
      b = b or 128
    add result, chr(b)
    dec pad