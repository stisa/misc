import ./nimwasm/wasm/generation
import ./nimwasm/wasm/encodes
import ./nimwasm/wasm/enums
import ./nimwasm/wasm/opcodes
export encodes, generation, enums, opcodes

when defined js:
  import ./nimwasm/js/webassembly
  export webassembly