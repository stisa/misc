import ./wasm/generation
import ./wasm/encodes
import ./wasm/enums
import ./wasm/opcodes
export encodes, generation, enums, opcodes

when defined js:
  import ./js/webassembly
  export webassembly

#[ Example
  (module
  (type $0 (func (param i32 i32) (result i32)))
  (memory $0 0)
  (export "add" (func $0))
  (func $0 (type $0) (param $var$0 i32) (param $var$1 i32) (result i32)
    (i32.add
    (get_local $var$0)
    (get_local $var$1)
    )
  )
  )
]#

#[ First thought
  module name:
    type index:
      func( params, result)
    memory 
    export name, index
    fn internalname, type, param,param,..., result
      op:
        op, var
      op, var
]#