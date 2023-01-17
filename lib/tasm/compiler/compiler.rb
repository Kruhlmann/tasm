require 'tasm/lexer/lexer'

class Compiler
  def compile(_source, _output_file, _memory_size, _context = 'anonymous')
    raise '`compile` not implemented'
  end

  def load_instructions(source, context)
    combined_source = process_includes(source)
    Lexer.new.lex(combined_source, context)
  end

  def process_includes(str)
    included_files = []
    str.lines.map do |line|
      if line.start_with?('include')
        package = line.split(' ')[1]
        path = "./#{package.gsub('.', '/')}"
        if File.directory?(path)
          files = Dir["#{path}/*.tasm"]
          if files.empty?
            raise "No .tasm files found in directory #{path}"
          else
            files.each do |file|
              if included_files.include?(file)
                # ignoring file that has already been included
              else
                included_files << file
                File.read(file)
              end
            end
          end
        elsif File.file?(path + '.tasm')
          if included_files.include?(path + '.tasm')
            # ignoring file that has already been included
          else
            included_files << path + '.tasm'
            process_includes(File.read(path + '.tasm'))
          end
        else
          raise "Error: #{path} is neither a file nor a directory"
        end
      else
        line.start_with?('include') ? '' : line
      end
    end.join
  end
end
