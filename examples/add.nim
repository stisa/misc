import ../src/nimwasm

var mymod = module()

var ft = fnType(WasmType.Func,ValueType.I32, ValueType.I32,ValueType.I32)
mymod.types = typeSec(ft)

mymod.functions = fnSec(0)

var ee = exportEntry("add",ExternalKind.Function,0)
mymod.exports = exportSec(ee)

# load 0, load 1, add
var fb = fnBody("\32\0\32\1\106")
mymod.codes = codeSec(fb)


writefile("add.wasm",encode(mymod))