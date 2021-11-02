require "tasm/compiler/amd64"
require_relative "./assertion_error"

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
    puts "\e[42mPASS\e[0m #{self.name} #{__FILE__}"
  end

  def self.compare_output
    result = File.open(self.output_result, "r").read
    assert(expected, result)
  end

  def self.assert(expected, actual)
    if expected != actual
      raise AssertionError.new("\e[41mFAIL\e[0m #{self.name} #{__FILE__}", expected, actual)
    end
  end

  def self.compare_exit_code
    result = File.open(self.output_exit_code, "r").read
    assert(expected_exit_code.to_s, result.strip)
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
    raise "test case #{self.name} #{__FILE__} has no `source`"
  end

  def self.expected
    raise "test case #{self.name} #{__FILE__} has no `expected`"
  end
end
