require "tasm/compiler/amd64"

class TestCase
  def self.execute
    execute_source
    compare_result
  end

  def self.execute_source
    AMD64Compiler.new.compile(self.source, "/tmp/tasm_output", 640_000, "#{self.class.name}")
    %x[/tmp/tasm_output > /tmp/tasm_result]
  end

  def self.compare_result
    result = File.open("/tmp/tasm_result", "r").read
    if expected != result
      puts "Expected:\n#{expected}"
      puts "Actual:\n#{result}"
      raise "test case #{self.name} failed"
    end
    puts "test case #{self.name} passed"
  end

  def self.source
    raise "test case #{self.name} has no source" 
  end

  def self.expected
    raise "test case #{self.class.name} has no expected" 
  end
end
