import ../src/nimwasm

var mymod = module()

var ft = fnType(WasmType.Func,ValueType.I32)
mymod.add(ft)

var 
  ie = fnimportEntry("console","log",0)

mymod.imports = importSec(ie)

writefile("imp.wasm",encode(mymod))
