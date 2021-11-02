require "tasm/lexer"
require "tasm/compiler/compiler"

class NodeJSCompiler < Compiler
  def compile(source, output_file, context = "anonymous")
    instructions = load_instructions(source, context)
    js_source = translate_nodejs(instructions)
    write_js_source(js_source, output_file)
  end

  def translate_nodejs(instructions)
    xref_instructions = CrossReferencer.new.cross_reference_instructions(instructions)
    source = xref_instructions.each_with_index.map { |operation, operation_index| operation.nodejs_instruction(operation_index) }.join("")
    return <<~eos
             let stack = [];
             #{source}
           eos
  end

  def write_js_source(js_source, output_file)
    output = File.open("#{output_file}.js", "w")
    output.write(js_source)
    output.close
  end
end
