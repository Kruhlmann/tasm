class LineBuffer
  def initialize
    reset
  end

  def push(char)
    @buffer += char
  end

  def empty?
    @buffer.strip.empty?
  end

  def read
    @buffer
  end

  def set_buffer_content(content)
    @buffer = content
  end

  def reset
    @buffer = ""
    @column = -1
  end

  def set_col(column)
    @column = column
  end

  def column
    @column
  end

  def dup
    symbol_buffer = LineBuffer.new
    symbol_buffer.set_col(@column)
    symbol_buffer.set_buffer_content(@buffer)
    symbol_buffer
  end
end
