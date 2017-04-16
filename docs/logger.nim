import ../src/nimwasm

var mymod = module()

var ft = fnType(WasmType.Func,ValueType.I32)
mymod.types = typeSec(ft)

mymod.functions = fnSec(0)
var 
  ie = fnimportEntry("console","log",0)

mymod.imports = importSec(ie)

var ee = exportEntry("log",ExternalKind.Function,0)
mymod.exports = exportSec(ee)

var fb = fnBody("\32\0\16\0")
mymod.codes = codeSec(fb)

writefile("logger.wasm",encode(mymod))