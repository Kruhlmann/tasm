require_relative "./case"

class PushPopTestCase < TestCase
  def self.source
    <<~EOS
    1 2 put put
    EOS
  end

  def self.expected
    <<~EOS
    2
    1
    EOS
  end
end
PushPopTestCase.execute
