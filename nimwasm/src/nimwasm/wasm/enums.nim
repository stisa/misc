type SecCode* {.pure.} = enum
  Custom =   (0,"\0")
  Type =     (1,"\1") # Function signature declarations
  Import =   (2, "\2") # Import declarations
  Function = (3, "\3") # Function declarations
  Table =    (4, "\4") # Indirect function table and other tables
  Memory =   (5, "\5") # Memory attributes
  Global =   (6, "\6") # Global declarations
  Export =   (7, "\7") # Exports
  Start =    (8, "\8") # Start function declaration
  Element =  (9, "\9") # Elements section
  Code =     (10, "\10") # Function bodies (code)
  Data =     (11, "\11") # Data segments

type WasmType* {.pure.} = enum
  Pseudo = (-0x40,"\64") #(i.e., the byte 0x40) pseudo type for representing an empty block_type
  Func = (-0x20,"\96") #(i.e., the byte 0x60) func
  AnyFunc = (-0x10,"\112") #(i.e., the byte 0x70) anyfunc
  F64 = (-0x04 , "\124") #(i.e., the byte 0x7c) f64
  F32 = (-0x03 , "\125")  #(i.e., the byte 0x7d) f32
  I64 = (-0x02 , "\126") #(i.e., the byte 0x7e) i64
  I32 = (-0x01 , "\127") #(i.e., the byte 0x7f) i32

type ValueType* {.pure.} = enum
  Pseudo = (-0x40,"\64") # no result
  F64 = (-0x04 , "\124")
  F32 = (-0x03 , "\125") 
  I64 = (-0x02 , "\126")
  I32 = (-0x01 , "\127")

type BlockType* {.pure.} = enum
  Pseudo = (-0x40,"\64") # no result
  F64 = (-0x04 , "\124")
  F32 = (-0x03 , "\125") 
  I64 = (-0x02 , "\126")
  I32 = (-0x01 , "\127")

type ElemType* {.pure.} = enum
  AnyFunc = (-0x10,"\112")

type Mutable* {.pure.} = enum
  No = 0
  Yes = 1

type ExternalKind *{.pure.} = enum
  ## A single-byte unsigned integer indicating the kind of definition being imported or defined:
  Function = (0,"\0") ## indicating a Function import or definition
  Table = (1,"\1") ## indicating a Table import or definition
  Memory = (2,"\2") ## indicating a Memory import or definition
  Global = (3,"\3") ## indicating a Global import or definition
