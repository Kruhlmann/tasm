require "tasm/cross_referencer"

class Program
  def initialize
    @instructions = []
    @stack = []
    @instruction_ptr = 0
    @cross_referencer = CrossReferencer.new
  end

  def set_instructions(instructions)
    @instructions = @cross_referencer.cross_reference_instructions(instructions)
  end

  def run()
    @instruction_ptr = 0
    instructions_executed = []

    while @instruction_ptr && @instruction_ptr < @instructions.length
      instructions_executed.append(@instruction_ptr)
      @instruction_ptr = @instructions[@instruction_ptr].execute(@stack, @instruction_ptr)
    end

    @instructions.each_with_index do |instruction, instruction_index|
      if instructions_executed.include? instruction_index
        puts "\e[34m#{@instructions[instruction_index].comment}\e[0m"
      else
        puts "\e[31m#{@instructions[instruction_index].comment}\e[0m"
      end
    end
  end

  def compile
    asm_instructions = @instructions.each_with_index.map { |operation, operation_index| operation.as_asm(operation_index) }.join("")
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
             #{asm_instructions}
             mov rax, 60
             mov rdi, 0
             syscall
           EOS
  end

  def reset_instruction_pointer
    @instruction_ptr = 0
  end
end
