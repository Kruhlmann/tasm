require_relative "./case"

class Rule110TestCase < TestCase
  def self.source
    <<~EOS
      mem 28 + 1 write

      0 while clone 28 < do
         0 while clone 30 < do
            clone mem + load if
               mem 30 + 35 write
            else
               mem 30 + 32 write
            endif
            1 mem 30 + 1 1 syscall3

            1 +
         wend drop

         mem 30 + 10 write
         1 mem 30 + 1 1 syscall3

         mem     load 1 <<
         mem 1 + load
         |

         1 while clone 28 < do
            swap 1 << 7 &
            over mem + 1 + load |
            2clone 110 swap >> 1 &
            swap mem + swap write
            swap

            1 +
         wend drop drop

       1 + wend drop
    EOS
  end

  def self.expected
    "## #   ### ### ## #  ###  ##"
  end

  def self.compare_output
    file = File.open(self.output_result, "r")
    28.times { file.gets }
    result = $_.strip
    file.close
    assert(expected, result)
  end
end

Rule110TestCase.execute
