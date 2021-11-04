require_relative "./case"

class StringLiteralTestCase < TestCase
  def self.source
    <<~EOS
      "Hello, World!\\n" 1 1 syscall3
      "Hello, World! " 1 1 syscall3
      "Hello, World!\\n" 1 1 syscall3
    EOS
  end

  def self.expected
    <<~EOS
      Hello, World!
      Hello, World! Hello, World!
    EOS
  end
end

StringLiteralTestCase.execute
