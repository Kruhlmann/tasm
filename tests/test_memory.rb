require_relative "./case"

class MemoryTestCase < TestCase
  def self.source
    <<~EOS
      mem 0 + 97 write
      mem 1 + 98 write
      mem 2 + 99 write
      mem 0 + clone load 1 + write
      mem 1 + clone load 1 + write
      mem 2 + clone load 1 + write
      mem 0 + clone load put
      mem 1 + clone load put
      mem 2 + clone load put
    EOS
  end

  def self.expected
    <<~EOS
      98
      99
      100
    EOS
  end
end

MemoryTestCase.execute
