import enums


#FIXME:
{. warning[ProveInit]: off .}

type 
  WasmNode = NimNode

  Module* = ref object
    magic*: int
    version*: int
    custom*: CustomSection
    types*: TypeSection
    imports*: ImportSection
    functions*: FunctionSection
    tables*: TableSection
    memory*: MemorySection
    globals*: GlobalSection
    exports*: ExportSection
    start*: StartSection
    elements*: ElementSection
    codes*: CodeSection
    datas*:DataSection
  
  # Sections  
  CustomSection* = ref object
    name: string
    #TODO:    

  TypeSection* = ref object
    entries*: seq[FuncType]
  ImportSection* = ref object
    entries*: seq[ImportEntry]
  FunctionSection* = ref object
    entries*: seq[int] 
  TableSection* = ref object
    entries*: seq[TableType]
  MemorySection* = ref object
    entries*: seq[MemoryType]
  GlobalSection* = ref object
    entries*: seq[GlobalVariable]
  ExportSection* = ref object
    entries*: seq[ExportEntry]
  StartSection* = ref object
    index*: int
  ElementSection* = ref object
    entries*: seq[ElemSegment]
  CodeSection* = ref object
    entries*: seq[FunctionBody]
  DataSection* = ref object
    entries*: seq[DataSegment]
  
  FuncType* = object
    form* : WasmType
    params*: seq[ValueType]
    returns*: seq[ValueType]

  GlobalType* = object
    contentType* : ValueType
    mutability* : Mutable

  ResizableLimits* = object
    flags*: int # 0 or 1 ( 1-> maximum field is present )
    initial*: int
    maximum*: int #?

  TableType* = object
    elementType*: ElemType
    limits*: ResizableLimits

  MemoryType* = object
    limits*: ResizableLimits

  InitExpr* = object
    # TODO:

  GlobalVariable* = object
    gtype*: GlobalType
    init*: InitExpr

  ImportEntry* = object
    module*: string #module string of module_len bytes
    field*: string #field name string of field_len bytes
    case kind* : External_kind # the kind of definition being imported
    of ExternalKind.Function :
      ftypeindex* : int
    of ExternalKind.Table:
      ttype*: TableType
    of ExternalKind.Memory:
      mtype*: MemoryType
    of ExternalKind.Global:
      gtype*: GlobalType

  ExportEntry* = object
    field*: string #field name string of field_len bytes
    kind* : External_kind # the kind of definition being exported
    index*: int

  ElemSegment* = object
    index*: int
    offset*: InitExpr
    elems*: seq[int]

  DataSegment* = object
    index*: int
    offset*: InitExpr
    #    size*: int
    data*: string

  LocalEntry* = object
    count*: int
    ttype*: ValueType

  FunctionBody* = object
    locals*: seq[LocalEntry]
    code*: string
    #ends*: char # 0x0b