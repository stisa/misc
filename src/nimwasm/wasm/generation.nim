import macros
import ./enums, ../leb128
import types

#FIXME:
{. warning[ProveInit]: off .}

proc importsec*(entries: varargs[ImportEntry]):ImportSection =
  ImportSection(entries: @entries)

proc fnImportEntry*(module:string,field:string,typeindex:int):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Function, module:module, field:field, ftypeindex: typeindex)

proc tableImportEntry*(module:string,field:string,tt:TableType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Table, module:module, field:field, ttype: tt)

proc memoryImportEntry*(module:string,field:string,mt:MemoryType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Memory, module:module, field:field, mtype: mt)

proc globalImportEntry*(module:string,field:string,gt:GlobalType):ImportEntry = 
  result = ImportEntry(kind:ExternalKind.Global, module:module, field:field, gtype: gt)

proc fnType*(kind:WasmType,
            params:varargs[ValueType],
            rt:bool=false,returns:ValueType=ValueType.Pseudo): FuncType =
  # FIXME: need rt:bool to differentiate return value from varargs
  if rt:
    FuncType(
      form: kind,
      params: @params,
      returns: @[returns]
    )
  else:
    FuncType(
      form: kind,
      params: @params
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

proc add*(es: var ExportSection, ee:varargs[ExportEntry]) =
  if es == nil:
    es = exportSec(ee)
  else: es.entries.add(@ee)

proc add*(fs: var FunctionSection, typeindx:varargs[int]) =
  fs.entries.add(@typeindx)

proc add*(ts: var TypeSection, typ:varargs[FuncType]) =
  if ts == nil:
    ts = typeSec(typ)
  else: ts.entries.add(@typ)

proc add*(cs: var CodeSection, fb: varargs[FunctionBody]) =
  if cs == nil:
    cs = codeSec(fb)
  else: cs.entries.add(@fb)

proc add*[T](m: var Module, what: varargs[T]) =
  when T is ExportEntry:
    m.exports.add(what)
  elif T is int:
    m.functions.add(what)
  elif T is FuncType:
    m.types.add(what)
  elif T is FunctionBody:
    m.codes.add(what)
