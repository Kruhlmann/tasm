require "tasm/compiler/amd64"

class TestCase
  def self.execute
    execute_source
    compare_result
  end

  def self.execute_source
    AMD64Compiler.new.compile(self.source, output_binary, 640_000, "#{self.name}")
    %x[#{capture_exit_code_script} #{output_binary} #{output_result} #{output_exit_code}]
  end

  def self.compare_result
    compare_output
    compare_exit_code
    puts "test case #{self.name} passed"
  end

  def self.compare_output
    result = File.open(self.output_result, "r").read
    if expected != result
      puts "Expected:\n#{expected}"
      puts "Actual:\n#{result}"
      raise "test case #{self.name} failed"
    end
  end

  def self.compare_exit_code
    result = File.open(self.output_exit_code, "r").read
    if expected_exit_code.to_s != result.strip
      puts "Expected exit code:\n#{expected_exit_code}"
      puts "Actual exit code:\n#{result}"
      raise "test case #{self.name} failed"
    end
  end

  def self.expected_exit_code
    0
  end

  def self.output_binary
    "/tmp/tasm_output_#{self.name}"
  end

  def self.output_result
    "/tmp/tasm_result_#{self.name}"
  end

  def self.output_exit_code
    "/tmp/tasm_exit_code_#{self.name}"
  end

  def self.capture_exit_code_script
    "./scripts/capture_exit_code"
  end

  def self.source
    raise "test case #{self.name} has no source"
  end

  def self.expected
    raise "test case #{self.name} has no expected"
  end
end
