require "tasm/lexer/lexer"
require "tasm/cross_referencer"

class Interpreter
  def run(source, filename)
    lexer = Lexer.new
    cross_referencer = CrossReferencer.new

    instructions = lexer.lex(source, filename)
    instructions = cross_referencer.cross_reference_instructions(instructions)

    stack = []
    instruction_ptr = 0

    while ! instruction_ptr.nil? && instruction_ptr < instructions.length do
      instruction = instructions[instruction_ptr]
      instruction_ptr = instruction.execute(stack, instruction_ptr)
    end
  end
end
