require "tasm/compiler"
require "tasm/interpreter"
require "tasm/lexer"

def interpret_program(input_file)
  source = File.open(input_file, "r").read
  interpreter = Interpreter.new
  interpreter.run(source, input_file)
end

def compile_program(input_file, output_file)
  source = File.open(input_file, "r").read
  compiler = Compiler.new
  compiler.compile(source, output_file, input_file)
end
