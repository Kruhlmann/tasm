require "tasm/operations/operation"

class ArgOperation < Operation
  def initialize(argument)
    raise "No argument for #{self.class.name}" if argument.nil?
    @argument = argument
  end

  def comment
    ";; #{self.class.name}<#{@argument}>"
  end
end
