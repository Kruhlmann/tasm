require_relative "./case"

class SyscallTestCase < TestCase
  def self.source
    <<~EOS
      mem 0 + 97 write
      mem 1 + 98 write
      mem 2 + 99 write
      3 mem 1 1 syscall3
      44 put

      80 60 syscall1
    EOS
  end

  def self.expected
    <<~EOS
      abc44
    EOS
  end

  def self.expected_exit_code
    80
  end
end

SyscallTestCase.execute
