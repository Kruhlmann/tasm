require "tasm/lexer"
require "tasm/program"
require "tasm/compiler/compiler"

class AMD64Compiler < Compiler
  def compile(source, output_file, context = "anonymous")
    instructions = load_instructions(source, context)
    asm_source = translate_amd64(instructions)
    write_asm_source(asm_source, output_file)
    invoke_nasm_compilation(output_file)
  end

  def translate_amd64(instructions)
    xref_instructions = CrossReferencer.new.cross_reference_instructions(instructions)
    source = xref_instructions.each_with_index.map { |operation, operation_index| operation.as_asm(operation_index) }.join("")
    return <<~EOS
             global _start
             segment .text
             print:
             mov rax, 1
             syscall
             ret
             dump:
             mov r9, -3689348814741910323
             sub rsp, 40
             mov BYTE [rsp+31], 10
             lea rcx, [rsp+30]
             .dump_loop:
             mov rax, rdi
             lea r8, [rsp+32]
             mul r9
             mov rax, rdi
             sub r8, rcx
             shr rdx, 3
             lea rsi, [rdx+rdx*4]
             add rsi, rsi
             sub rax, rsi
             add eax, 48
             mov BYTE [rcx], al
             mov rax, rdi
             mov rdi, rdx
             mov rdx, rcx
             sub rcx, 1
             cmp rax, 9
             ja  .dump_loop
             lea rax, [rsp+32]
             mov edi, 1
             sub rdx, rax
             lea rsi, [rsp+32+rdx]
             mov rdx, r8
             call print
             add  rsp, 40
             ret
             _start:
             #{source}
             mov rax, 60
             mov rdi, 0
             syscall
           EOS
  end

  def write_asm_source(asm_source, output_file)
    output = File.open("#{output_file}.asm", "w")
    output.write(asm_source)
    output.close
  end

  def invoke_nasm_compilation(filename)
    %x[nasm -felf64 #{filename}.asm]
    %x[ld -o #{filename} #{filename}.o]
  end
end
