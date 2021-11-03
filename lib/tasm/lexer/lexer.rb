require "tasm/operations/atomic/push_int"
require "tasm/error/lexer/unknown_symbol"
require "tasm/lexer/lookup_table"
require "tasm/lexer/line_buffer"

class Lexer
  def operation_from_symbol(symbol, context, line_number, current_column)
    lookup_result = LexerOperationLookupTable.lookup(symbol)
    if !lookup_result.nil?
      return lookup_result.new
    elsif symbol.to_i.to_s == symbol
      return PushOperation.new(symbol.to_i)
    end
    raise UnknownSymbolError.new(symbol, context, line_number + 1, current_column)
  end

  def operation_from_symbol_buffer(symbol_buffer, context, line_number)
    lookup_result = LexerOperationLookupTable.lookup(symbol_buffer.read)
    if !lookup_result.nil?
      return lookup_result.new
    elsif symbol_buffer.read.to_i.to_s == symbol_buffer.read
      return PushIntOperation.new(symbol_buffer.read.to_i)
    end
    raise UnknownSymbolError.new(symbol_buffer.read, context, line_number + 1, symbol_buffer.column + 1)
  end

  def lex_line_into_program(line, line_number, context, program)
    char_ptr = 0
    buffer = LineBuffer.new
    buffers = []
    line = line.strip

    while char_ptr < line.length
      if buffer.empty?
        if line[char_ptr].strip.empty?
          char_ptr += 1
          next
        end
        buffer.set_col(char_ptr)

        if line[char_ptr] == '"'
          char_ptr += 1
          while char_ptr < line.length
            if line[char_ptr] == '"'
              break
            end
            buffer.push(line[char_ptr])
            char_ptr += 1
          end

          buffers.append(buffer.dup)
          buffer.reset
          next
        end

        buffer.push(line[char_ptr])
        char_ptr += 1

        if char_ptr >= line.length
          buffers.append(buffer.dup)
          buffer.reset
          break
        end
      end

      if char_ptr >= line.length
        buffers.append(buffer.dup)
        buffer.reset
        break
      end

      if line[char_ptr].strip.empty?
        buffers.append(buffer.dup)
        buffer.reset
      else
        buffer.push(line[char_ptr])
      end

      char_ptr += 1
    end

    buffers.append(buffer) unless buffer.read.empty?

    buffers.each do |symbol_buffer|
      operation = operation_from_symbol_buffer(symbol_buffer, context, line_number)
      program.append(operation)
    end
  end

  def lex(source, context = "anonymous")
    program = []
    lines = source.split('\n')
    lines.each_with_index do |line, line_number|
      lex_line_into_program(line, line_number, context, program)
    end
    program
  end
end
