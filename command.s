#Vivek
#worked with ayub 
.file "command.s"
.section        .rodata
print: .string "%s \n"
.global main
.type main, @function
.data
.align 8
.text
main:
pushq %rbp
movq %rsp,%rbp  #Initiate Stack

pushq %r13
pushq %r14
pushq %r15 #push all the callee saved registers

movq %rdi, %r15 #move the argc into r15
movq $0, %r14 # intiate the counter
movq %rsi, %r13 # it will hoeld the argv

loop:
   cmpq %r14, %r15 # Make sure i<argc
je exit

movq %r13,%rsi #movw argv value into rsi  
movq (%rsi), %rsi # derefer 
xor %rax,%rax
movq $print,%rdi #format register
call printf
incq %r14 #i++
addq $8, %r13
jmp loop
exit:
popq %r15
popq %r14
popq %r13

leave
ret
.size main,.-main
