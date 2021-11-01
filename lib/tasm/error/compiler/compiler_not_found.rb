require "tasm/error/compiler/compiler"

class CompilerNotFoundError < CompilerError
  def initialize(name)
    super("no such compiler '#{name}'")
  end
end
