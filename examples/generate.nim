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

var wasmexports : WasmExports
let code = encode(mymod)

proc exps(r:ResultObject)= 
  wasmexports = r.instance.exports
  echo cast[int](wasmexports.add(2,3))
var inst = instantiate(code).then(exps)