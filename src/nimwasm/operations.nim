import ./wasm/opcodes , ./wasm/enums, leb128, ./wasm/types, ./wasm/generation
#FIXME:
{. warning[ProveInit]: off .}

type
  AccessGlobal* = tuple
    op: Global
    index: int # uint32
    
  AccessLocal* = tuple
    op: Local
    index: int # uint32

  Access* = AccessGlobal | AccessLocal

  Memory* [T: I32|I64|F32|F64] = object
    flags*: int # log2(alignment)
    offset*: int
    op*: T
  Constant* [T: static[ConstType]]= object
    when T == ConstType.I32:
      value*: int
    elif T == ConstType.I64:
      value*: int64
    elif T == ConstType.F32:
      value*: uint32
    elif T == ConstType.F64:
      value*: uint64
    else: discard

  Operation* = ref object
    locals: seq[AccessLocal]
    globals: seq[AccessGlobal]
    op: Numeric

proc encode*(va:Access):string =
  result = $va.op
  add result, va.index.string

proc encode*(m:Memory):string =
  result = $m.op
  add result, m.flags.string
  add result, m.offset.string

proc encode*[T:static[ConstType]](c:Constant[T]):string =
  result = $T
  add result, $c.value

proc encode*(n:OpCodes):string =
  result = $n

proc op*(op:Numeric, params: varargs[AccessGlobal]):Operation =
  new result
  result.op = op
  result.globals = @params

proc op*(op:Numeric, params: varargs[AccessLocal]):Operation =
  new result
  result.op = op
  result.locals = @params

proc encode*(o:Operation):string =
  result = ""
  for ll in o.locals:
    add result, encode(ll.op)
    add result, ll.index.int32.unsignedLEB128
  for gl in o.globals:
    add result, encode(gl.op)
    add result, gl.index.int32.unsignedLEB128
  add result, encode(o.op)
  
proc opBody*(op:Numeric, 
          params: varargs[AccessLocal]):FunctionBody = 
  fnBody(encode( op(op, params) ))