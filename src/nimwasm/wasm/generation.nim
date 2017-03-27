import macros
import ./enums, ../leb128
import types

#FIXME:
{. warning[ProveInit]: off .}

proc importsec*(entries: varargs[ImportEntry]):ImportSection =
  ImportSection(entries: @entries)
# TODO: encode importsection

proc fnImportEntry*(module:string,field:string,typeindex:int):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Function, module:module, field:field, ftypeindex: typeindex)

proc tableImportEntry*(module:string,field:string,tt:TableType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Table, module:module, field:field, ttype: tt)

proc memoryImportEntry*(module:string,field:string,mt:MemoryType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Memory, module:module, field:field, mtype: mt)

proc globalImportEntry*(module:string,field:string,gt:GlobalType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Global, module:module, field:field, gtype: gt)
# TODO: encode importentry

proc fnType*(kind:WasmType,returns:ValueType=ValueType.Pseudo,
            params:varargs[ValueType]): FuncType =
  FuncType(
    form: kind,
    params: @params,
    returns: @[returns]
  )

proc localEntry*(c:int,kind:ValueType):LocalEntry =
  LocalEntry(count: c, ttype: kind)

proc fnBody*(code:string,locals:varargs[LocalEntry]):FunctionBody =
  FunctionBody(locals: @locals, code: code)

proc fnSec*(findices:varargs[int]):FunctionSection =
  new result
  result = FunctionSection(entries: @findices)
proc typeSec*(entries: varargs[FuncType]):TypeSection =
  TypeSection( entries: @entries)
proc exportEntry*(field:string,kind:ExternalKind,index:int):ExportEntry =
  ExportEntry(field:field, kind:kind, index:index)
proc exportSec*(eentries:varargs[ExportEntry]):ExportSection =
  ExportSection(entries: @eentries)
proc codeSec*(fbodies:varargs[FunctionBody]):CodeSection =
  CodeSection( entries: @fbodies )

proc module*(magic=0x6d736100, version= 0x00000001):Module=
  new result
  result.magic = magic
  result.version = version
