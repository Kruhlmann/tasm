require "tasm/operations/atomic/add"
require "tasm/operations/atomic/subtract"
require "tasm/operations/atomic/put"
require "tasm/operations/atomic/push"
require "tasm/operations/atomic/equality"
require "tasm/operations/atomic/if"
require "tasm/operations/atomic/gt"
require "tasm/operations/atomic/lt"
require "tasm/operations/atomic/endif"
require "tasm/operations/atomic/else"
require "tasm/operations/atomic/while"
require "tasm/operations/atomic/mem"
require "tasm/operations/atomic/drop"
require "tasm/operations/atomic/clone"
require "tasm/operations/atomic/clone2"
require "tasm/operations/atomic/write"
require "tasm/operations/atomic/load"
require "tasm/operations/atomic/lshift"
require "tasm/operations/atomic/rshift"
require "tasm/operations/atomic/bwand"
require "tasm/operations/atomic/bwor"
require "tasm/operations/atomic/syscall3"
require "tasm/operations/atomic/syscall1"
require "tasm/operations/unreferenced/do"
require "tasm/operations/unreferenced/wend"
require "tasm/operations/unreferenced/if"
require "tasm/operations/unreferenced/else"

class LexerOperationLookupTable
  @operations = {
    "+" => AddOperation,
    "-" => SubtractOperation,
    "=" => EqualityOperation,
    "<" => LessThanOperation,
    ">" => GreaterThanOperation,
    ">>" => RightBinaryShiftOperation,
    "<<" => LeftBinaryShiftOperation,
    "&" => BitwiseAndOperation,
    "|" => BitwiseOrOperation,
    "clone" => CloneOperation,
    "2clone" => Clone2Operation,
    "drop" => DropOperation,
    "if" => UnreferencedIfOperation,
    "else" => UnreferencedElseOperation,
    "endif" => EndIfOperation,
    "while" => WhileOperation,
    "do" => UnreferencedDoOperation,
    "wend" => UnreferencedEndWhileOperation,
    "put" => PutOperation,
    "mem" => MemOperation,
    "load" => LoadOperation,
    "write" => WriteOperation,
    "syscall1" => Syscall1Operation,
    "syscall3" => Syscall3Operation,
  }

  def self.lookup(operation_name)
    if @operations.has_key? operation_name
      return @operations[operation_name]
    end
  end
end
