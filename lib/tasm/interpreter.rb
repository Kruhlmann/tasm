require "tasm/lexer"

class Interpreter
  def run(source, filename)
    stack = []
    lexer = Lexer.new
    program = Program.new
    instructions = lexer.lex(source, filename)
    program.set_instructions(instructions)
    program.run
  end
end
