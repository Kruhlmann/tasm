require_relative './case'

class SubTestCase < TestCase
  def self.source
    <<~EOS
      sub do_print
        1 1 syscall3
      marine

      sub my_number 14 marine

      my_number do_print
    EOS
  end

  def self.expected
    <<~EOS
      14
    EOS
  end
end

SubTestCase.execute
