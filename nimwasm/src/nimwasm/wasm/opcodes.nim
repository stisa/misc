
type

  OpCodes* = Local | Global | I32 | I64 | F32 | F64 | MemorySize | ConstType | Numeric

  Local* {.pure.} = enum
    Get = (0x20,"\32")
    Set = (0x21, "\33")
    Tee = (0x22, "\34")
  Global* {.pure.} = enum
    Get = (0x23, "\35")
    Set = (0x24, "\36")
  
  I32* {.pure.} = enum
    Load = (0x28, "\40")
    LoadI8 = (0x2c, "\44")
    LoadU8= (0x2d, "\45")
    LoadI16 = (0x2e, "\46")
    LoadU16 = (0x2f, "\47")
    Store = (0x36, "\54")
    Store8 = (0x3a, "\58")
    Store16 = (0x3b, "\59")
  I64* {.pure.} = enum
    Load = (0x29, "\41")
    LoadI8 = (0x30, "\48")
    LoadU8 = (0x31, "\49")
    LoadI16 = (0x32, "\50")
    LoadU16 = (0x33, "\51")
    LoadI32 = (0x34, "\52")
    LoadU32 = (0x35, "\53")
    Store = (0x37, "\55")
    Store8 = (0x3c, "\60")
    Store16 = (0x3d, "\61")
    Store32= (0x3e, "\62")
  F32* {.pure.} = enum
    Load = (0x2a, "\42")
    Store = (0x38, "\56")
  F64* {.pure.} = enum
    Load = (0x2b, "\43")
    Store = (0x39, "\57")
  
  # TODO:
  MemorySize* {.pure.} = enum
    Current = (0x3f, "\63")
    Grow = (0x40, "\64")
  
  ConstType* {.pure.}= enum
    I32 = (0x41, "\65")
    I64 = (0x42, "\66")
    F32 = (0x43, "\67")
    F64 = (0x44, "\68")
  
  Numeric* {.pure.} = enum
    addI32 = (0x6a, "\106")
    subI32 = (0x6b, "\107")
    mulI32 = (0x6c, "\108")
    divI32 = (0x6d, "\109")
    divUI32 = (0x6e, "\110")
    remI32 = (0x6f, "\111")
    remUI32 = (0x70, "\112")
    #clzi32 0x67
    # i32.ctz 0x68
    #i32.popcnt 0x69
    #i32.and 0x71
    #i32.or 0x72
    #i32.xor 0x73
    #i32.shl 0x74
    #i32.shr_s 0x75
    #i32.shr_u 0x76
    #i32.rotl 0x77
    #i32.rotr 0x78
    #i64.clz 0x79
    #i64.ctz 0x7a