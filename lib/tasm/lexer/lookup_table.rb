require 'tasm/operations/atomic/add'
require 'tasm/operations/atomic/subtract'
require 'tasm/operations/atomic/put'
require 'tasm/operations/atomic/equality'
require 'tasm/operations/atomic/if'
require 'tasm/operations/atomic/unless'
require 'tasm/operations/atomic/gt'
require 'tasm/operations/atomic/lt'
require 'tasm/operations/atomic/endif'
require 'tasm/operations/atomic/else'
require 'tasm/operations/atomic/while'
require 'tasm/operations/atomic/mem'
require 'tasm/operations/atomic/drop'
require 'tasm/operations/atomic/clone'
require 'tasm/operations/atomic/clone2'
require 'tasm/operations/atomic/write'
require 'tasm/operations/atomic/load'
require 'tasm/operations/atomic/lshift'
require 'tasm/operations/atomic/marine'
require 'tasm/operations/atomic/rshift'
require 'tasm/operations/atomic/increment'
require 'tasm/operations/atomic/decrement'
require 'tasm/operations/atomic/bwand'
require 'tasm/operations/atomic/bwor'
require 'tasm/operations/atomic/swap'
require 'tasm/operations/atomic/over'
require 'tasm/operations/atomic/rev3'
require 'tasm/operations/atomic/rev4'
require 'tasm/operations/atomic/syscall3'
require 'tasm/operations/atomic/syscall1'
require 'tasm/operations/unreferenced/do'
require 'tasm/operations/unreferenced/wend'
require 'tasm/operations/unreferenced/if'
require 'tasm/operations/unreferenced/unless'
require 'tasm/operations/unreferenced/else'
require 'tasm/operations/unreferenced/sub'

class LexerOperationLookupTable
  @operations = {
    '+' => AddOperation,
    '-' => SubtractOperation,
    '=' => EqualityOperation,
    '<' => LessThanOperation,
    '>' => GreaterThanOperation,
    '--' => DecrementOperation,
    '++' => IncrementOperation,
    '>>' => RightBinaryShiftOperation,
    '<<' => LeftBinaryShiftOperation,
    '&' => BitwiseAndOperation,
    '|' => BitwiseOrOperation,
    'swap' => SwapOperation,
    'clone' => CloneOperation,
    '2clone' => Clone2Operation,
    'drop' => DropOperation,
    'over' => OverOperation,
    'if' => UnreferencedIfOperation,
    'sub' => UnreferencedSubOperation,
    'marine' => MarineOperation,
    'unless' => UnreferencedUnlessOperation,
    'else' => UnreferencedElseOperation,
    'endif' => EndIfOperation,
    'while' => WhileOperation,
    'do' => UnreferencedDoOperation,
    'wend' => UnreferencedEndWhileOperation,
    'put' => PutOperation,
    'mem' => MemOperation,
    'load' => LoadOperation,
    'rev3' => Rev3Operation,
    'rev4' => Rev4Operation,
    'write' => WriteOperation,
    'syscall1' => Syscall1Operation,
    'syscall3' => Syscall3Operation
  }

  def self.lookup(operation_name)
    return @operations[operation_name] if @operations.has_key? operation_name
  end
end
