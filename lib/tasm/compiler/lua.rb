require "tasm/compiler/compiler"

class LuaCompiler < Compiler
  def compile(source, output_file, memory_size, context = "anonymous")
    instructions = load_instructions(source, context)
    lua_source = translate_lua(instructions)
    write_lua_source(lua_source, output_file)
  end

  def translate_lua(instructions)
    xref_instructions = CrossReferencer.new.cross_reference_instructions(instructions)
    source = xref_instructions.each_with_index.map { |operation, operation_index| operation.lua_instruction(operation_index) }.join("")
    return <<~eos
             local stack = {};
             #{source}
           eos
  end

  def write_lua_source(lua_source, output_file)
    output = File.open("#{output_file}.lua", "w")
    output.write(lua_source)
    output.close
  end
end
