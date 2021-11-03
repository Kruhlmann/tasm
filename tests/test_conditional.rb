require_relative "./case"

class ConditionalTestCase < TestCase
  def self.source
    <<~EOS
      1 if 1 put endif
      0 if 2 put endif
      1 unless 3 put endif
      0 unless 4 put endif
    EOS
  end

  def self.expected
    <<~EOS
      1
      4
    EOS
  end
end

ConditionalTestCase.execute
