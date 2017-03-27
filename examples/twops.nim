import ../src/nimwasm

var mymod = module()

var ft = fnType(WasmType.Func,ValueType.I32, ValueType.I32,ValueType.I32)
mymod.types = typeSec(ft)

# Signature is the same for add and sub, so we just repeat the signature index
mymod.functions = fnSec(0,0) 

var 
  ee = exportEntry("add",ExternalKind.Function,0)
  ee2 = exportEntry("sub",ExternalKind.Function,1)
mymod.exports = exportSec(ee,ee2)

# load 0, load 1, add
var fb = fnBody("\32\0\32\1\106") # add
var fb2 = fnBody("\32\0\32\1\107") # sub
mymod.codes = codeSec(fb,fb2)

writefile("twoops.wasm",encode(mymod))