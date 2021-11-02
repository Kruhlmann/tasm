require "tasm/lexer/lexer"

class Compiler
  def compile(source, output_file, memory_size, context = "anonymous")
    raise "`compile` not implemented"
  end

  def load_instructions(source, context)
    Lexer.new.lex(source, context)
  end
end
