import ../src/nimwasm

var mymod = module()

var ft = fnType(WasmType.Func,ValueType.I32, ValueType.I32,ValueType.I32)
mymod.types = typeSec(ft)

mymod.functions = fnSec(0,0)

var 
  ee = exportEntry("add",ExternalKind.Function,0)
  ee2 = exportEntry("sub",ExternalKind.Function,1)

mymod.exports.add(ee,ee2)

# load 0, load 1, add
var 
  op1 = opbody(Numeric.addI32,(Local.Get,0),(Local.Get,1))
  op2 = opbody(Numeric.subI32,(Local.Get,0),(Local.Get,1))
mymod.codes = codeSec(op1,op2)

writefile("ops.wasm",encode(mymod))