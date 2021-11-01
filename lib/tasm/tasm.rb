require "tasm/compiler/factory"
require "tasm/interpreter"
require "tasm/lexer"

def interpret_program(input_file)
  source = File.open(input_file, "r").read
  interpreter = Interpreter.new
  interpreter.run(source, input_file)
end

def compile_program(input_file, output_file, compiler)
  source = File.open(input_file, "r").read
  compiler = CompilerFactory.new.from_str(compiler)
  compiler.compile(source, output_file, input_file)
end
