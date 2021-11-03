require "tasm/lexer/tokenizer"

class Lexer
  def lex_line_into_program(line, line_number, context, program)
    symbols = line.split
    current_column = 0

    symbols.each do |symbol|
      token = Tokenizer.tokenize_symbol(symbol, context, line_number + 1, current_column + 1)
      program.append(token.operation)
      current_column += token.length + 1
    end
  end

  def lex_lines_into_program(program, lines, context)
    lines.each_with_index do |line, line_number|
      lex_line_into_program(line, line_number, context, program)
    end
    program
  end

  def lex(source, context = "anonymous")
    program = []
    lines = source.split('\n')
    lex_lines_into_program(program, lines, context)
  end
end
