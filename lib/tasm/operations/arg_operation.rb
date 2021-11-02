require "tasm/operations/operation"

class ArgOperation < Operation
  def initialize(argument)
    raise "No argument for #{self.class.name}" if argument.nil?
    @argument = argument
  end

  def read_argument
    @argument
  end
end
