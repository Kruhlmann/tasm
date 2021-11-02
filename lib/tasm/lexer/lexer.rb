require "tasm/error/lexer/unknown_symbol"
require "tasm/lexer/lookup_table"
require "tasm/operations/atomic/write"

class Lexer
  def operation_from_symbol(symbol, context, line_number, current_column)
    lookup_result = LexerOperationLookupTable.lookup(symbol)
    if !lookup_result.nil?
        return lookup_result.new
    elsif symbol.to_i.to_s == symbol
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
