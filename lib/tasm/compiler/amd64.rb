require 'tasm/compiler/compiler'
require 'tasm/cross_referencer'

class AMD64Compiler < Compiler
  def compile(source, output_file, memory_size, context = 'anonymous')
    instructions = load_instructions(source, context)
    asm_source = translate_amd64(instructions, memory_size)
    write_asm_source(asm_source, instructions, output_file)
    invoke_nasm_compilation(output_file)
  end

  def translate_amd64(instructions, memory_size)
    output_model = File.open('.model', 'w')
    output_model.write(instructions.map(&:to_s).join("\n"))
    output_model.close
    xref_instructions = CrossReferencer.new.cross_reference_instructions(instructions)
    output_model_ref = File.open('.refmodel', 'w')
    output_model_ref.write(instructions.map(&:to_s).join("\n"))
    output_model_ref.close

    literals = []
    instructions_source = xref_instructions.each_with_index.map do |operation, operation_index|
      operation.asm_instruction(operation_index, literals)
    end.join('')
    literals_source = literals.each_with_index.map do |literal, literal_index|
      "lit_#{literal_index}: db #{literal.bytes.map { |b| "0x#{b.to_s(16)}" }.join(', ')}"
    end.join("\n")
    <<~EOS
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
      #{instructions_source}
      _start:
      call usr_main
      mov rax, 60
      mov rdi, 0
      syscall
      segment .data
      #{literals_source}
      segment .bss
      mem: resb #{memory_size}
    EOS
  end

  def write_asm_source(asm_source, _instructions, output_file)
    output = File.open("#{output_file}.asm", 'w')
    output.write(asm_source)
    output.close
  end

  def invoke_nasm_compilation(filename)
    [
      "nasm -felf64 #{filename}.asm",
      "ld -o #{filename} #{filename}.o || exit 1",
      "chmod u+x #{filename} || exit 1"
    ].each do |instruction|
      `#{instruction} || exit 1`
    end
  end
end
