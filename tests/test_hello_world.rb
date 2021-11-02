require_relative "./case"

class HelloWorldTestCase < TestCase
  def self.source
    <<~EOS
      mem clone 72 write
      1 + clone 101 write
      1 + clone 108 write
      1 + clone 108 write
      1 + clone 111 write
      1 + clone 44 write
      1 + clone 32 write
      1 + clone 87 write
      1 + clone 111 write
      1 + clone 114 write
      1 + clone 108 write
      1 + clone 100 write
      1 + clone 10 write
      1 + mem - 
      mem 1 1 syscall3
    EOS
  end

  def self.expected
    <<~EOS
      Hello, World
    EOS
  end
end

HelloWorldTestCase.execute
