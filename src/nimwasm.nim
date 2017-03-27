import ./nimwasm/wasm/generation
import ./nimwasm/wasm/encodes
import ./nimwasm/wasm/enums
import ./nimwasm/wasm/opcodes
import ./nimwasm/operations
export encodes, generation, enums, opcodes,operations

when defined js:
  import ./nimwasm/js/webassembly
  export webassembly