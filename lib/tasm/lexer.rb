require "tasm/error/lexer/unknown_symbol"
require "tasm/operations/atomic/add"
require "tasm/operations/atomic/subtract"
require "tasm/operations/atomic/dump"
require "tasm/operations/atomic/push"
require "tasm/operations/atomic/equality"
require "tasm/operations/atomic/if"
require "tasm/operations/atomic/gt"
require "tasm/operations/atomic/lt"
require "tasm/operations/atomic/endif"
require "tasm/operations/atomic/else"
require "tasm/operations/atomic/while"
require "tasm/operations/atomic/clone"
require "tasm/operations/unreferenced/do"
require "tasm/operations/unreferenced/wend"
require "tasm/operations/unreferenced/if"
require "tasm/operations/unreferenced/else"

class Lexer
  def operation_from_symbol(symbol, context, line_number, current_column)
    if symbol == "+"
      return AddOperation.new
    end
    if symbol == "-"
      return SubtractOperation.new
    end
    if symbol == "clone"
      return CloneOperation.new
    end
    if symbol == "="
      return EqualityOperation.new
    end
    if symbol == "<"
      return LessThanOperation.new
    end
    if symbol == ">"
      return GreaterThanOperation.new
    end
    if symbol == "while"
      return WhileOperation.new
    end
    if symbol == "if"
      return UnreferencedIfOperation.new
    end
    if symbol == "wend"
      return UnreferencedEndWhileOperation.new
    end
    if symbol == "do"
      return UnreferencedDoOperation.new
    end
    if symbol == "else"
      return UnreferencedElseOperation.new
    end
    if symbol == "endif"
      return EndIfOperation.new
    end
    if symbol == "wend"
      return EndWhileOperation.new
    end
    if symbol == "dump"
      return DumpOperation.new
    end
    if symbol.to_i.to_s == symbol
      return PushOperation.new(symbol.to_i)
    end
    raise UnknownSymbolError.new(symbol, context, line_number + 1, current_column)
  end

  def lex_line_into_program(line, line_number, context, program)
    symbols = line.split
    current_column = 1

    symbols.each do |symbol|
      program.append(operation_from_symbol(symbol, context, line_number, current_column))
      current_column += symbol.length + 1
    end
  end

  def lex_lines_into_program_or_print_error(program, lines, context)
    begin
      lines.each_with_index do |line, line_number|
        lex_line_into_program(line, line_number, context, program)
      end
      program
    rescue LexerError => e
      puts(e.to_s)
      []
    end
  end

  def lex(source, context = "anonymous")
    program = []
    lines = source.split('\n')
    lex_lines_into_program_or_print_error(program, lines, context)
  end
end
