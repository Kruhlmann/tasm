require "tasm/lexer"
require "tasm/program"

class Compiler
  def compile(source, output_file, context = "anonymouse")
    lexer = Lexer.new
    program = Program.new
    instructions = lexer.lex(source, context)
    program.set_instructions(instructions)
    asm_source = program.compile
    write_asm_source(asm_source, output_file)
    invoke_nasm_compilation(output_file)
  end

  def write_asm_source(asm_source, output_file)
    output = File.open("#{output_file}.asm", "w")
    output.write(asm_source)
    output.close
  end

  def invoke_nasm_compilation(filename)
    %x[nasm -felf64 #{filename}.asm]
    %x[ld -o #{filename} #{filename}.o]
  end
end
