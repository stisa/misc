import types, enums, ../leb128

proc encode*(ft:FuncType):string =
  result = $ft.form
  add result, ft.params.len.int32.unsignedLEB128
  for p in ft.params:
    add result, $p
  add result, ft.returns.len.int32.unsignedLEB128
  if ft.returns.len>0:
    add result, $ft.returns[0]
  
  
proc encode*(le:LocalEntry):string = le.count.int32.unsignedLEB128 & $le.ttype
proc encode*(fb:FunctionBody):string =
  var temp = fb.locals.len.int32.unsignedLEB128
  for loc in fb.locals:
    add temp, encode(loc)
  add temp, fb.code
  add temp, '\11' # end marker
  result = temp.len.int32.signedLEB128
  add result, temp

proc encode*(fs:FunctionSection):string =
  result = $SecCode.Function
  var temp = fs.entries.len.int32.unsignedLEB128
  for i in fs.entries:
    add temp, i.int32.unsignedLEB128
  add result, temp.len.int32.unsignedLEB128
  add result, temp

proc encode*(ts:TypeSection):string =
  result = $SecCode.Type
  var temp = ts.entries.len.int32.unsignedLEB128
  for entry in ts.entries:
    add temp, encode(entry)
  add result, temp.len.int32.unsignedLEB128
  add result, temp

proc encode*(ee:ExportEntry):string = 
  result = ee.field.len.int32.signedLEB128
  #echo result.len
  add result, ee.field
  #echo result.len
  add result, $ee.kind
  when not defined js:
    if ord(ee.kind) == 0:
      # C bug?: add result, $ee.kind doesn't append if '\0'
      add result, "\0"
  add result, ee.index.int32.unsignedLEB128

proc encode*(es:ExportSection):string =
  result = $SecCode.Export
  var temp = es.entries.len.int32.unsignedLEB128
  # We encode the section in temp
  for entry in es.entries:
    add temp, encode(entry)
  # then we take it's length and finally add the block
  add result, temp.len.int32.unsignedLEB128
  add result, temp

proc encode*(cs:CodeSection):string =
  result = $SecCode.Code
  var temp = cs.entries.len.int32.unsignedLEB128
  #echo repr temp
  for bd in cs.entries:
    add temp, encode(bd)
  add result, temp.len.int32.unsignedLEB128
  add result, temp

proc encode*(x:uint32):string =
  # Little endian.
  # eg 0x6d736100 -> 00 61 73 6d
  result = ""
  result.setLen 4
  when defined(js):
    var 
      bt : uint32= 0
      long = x
    for i in 0..3 :
      bt = long and 0xff
      result[i] = chr(bt)
      long = (long - bt) div 256
    #console.log(result)
  else:
    result[3] = cast[char](x shr 24)
    result[2] = cast[char](x shr 16)
    result[1] = cast[char](x shr  8)
    result[0] = cast[char](x shr  0)
  
proc encode*(x:int32):string =
  # Little endian.
  # eg 0x6d736100 -> 00 61 73 6d
  result = ""
  result.setLen 4
  when defined(js):
    var 
      bt : int32= 0
      long = x
    for i in 0..3 :
      bt = long and 0xff
      result[i] = chr(bt)
      long = (long - bt) div 256
  else:
    result[3] = cast[char](x shr 24)
    result[2] = cast[char](x shr 16)
    result[1] = cast[char](x shr  8)
    result[0] = cast[char](x shr  0)
proc encode*(m:Module):string = 
  result = encode(m.magic.int32) & encode(m.version.int32)
  add result, encode(m.types)
  add result, encode(m.functions)  
  add result, encode(m.exports)
  add result, encode(m.codes)
