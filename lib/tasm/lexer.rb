require "tasm/error/lexer/unknown_symbol"
require "tasm/operations/atomic/add"
require "tasm/operations/atomic/subtract"
require "tasm/operations/atomic/dump"
require "tasm/operations/atomic/push"
require "tasm/operations/atomic/subtract"
require "tasm/operations/atomic/equality"
require "tasm/operations/atomic/if"
require "tasm/operations/atomic/endif"
require "tasm/operations/atomic/else"
require "tasm/operations/atomic/unreferenced_if"
require "tasm/operations/atomic/unreferenced_else"

class Lexer
  def operation_from_symbol(symbol, context, line_number, current_column)
    if symbol == "+"
      return AddOperation.new
    end
    if symbol == "-"
      return SubtractOperation.new
    end
    if symbol == "-"
      return SubtractOperation.new
    end
    if symbol == "="
      return EqualityOperation.new
    end
    if symbol == "if"
      return UnreferencedIfOperation.new
    end
    if symbol == "else"
      return UnreferencedElseOperation.new
    end
    if symbol == "endif"
      return EndIfOperation.new
    end
    if symbol == "dump"
      return DumpOperation.new
    end
    if symbol.to_i.to_s == symbol
      return PushOperation.new(symbol.to_i)
    end
    raise UnknownSymbolError.new(symbol, context, line_number + 1, current_column)
  end

  def lex(source, context = "anonymous")
    program = []
    lines = source.split("\n")

    begin
      lines.each_with_index do |line, line_number|
        symbols = line.split
        current_column = 1

        symbols.each do |symbol|
          program.append(operation_from_symbol(symbol, context, line_number, current_column))
          current_column += symbol.length + 1
        end
      end

      return program
    rescue LexerError => error
      puts(error.to_s)
      return []
    end
  end
end
