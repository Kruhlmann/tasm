require "tasm/compiler/amd64"
require "tasm/compiler/nodejs"
require "tasm/compiler/lua"
require "tasm/error/compiler/compiler_not_found"

class CompilerFactory
  def from_str(name)
    if name == "amd64"
      return AMD64Compiler.new
    elsif name == "nodejs"
      return NodeJSCompiler.new
    elsif name == "lua"
      return LuaCompiler.new
    else
      raise CompilerNotFoundError.new(name)
    end
  end
end
