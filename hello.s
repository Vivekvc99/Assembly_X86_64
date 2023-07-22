.file "hello.s"
.section    .rodata
ask:
    .string "Please enter your name\n"
inputformat:
    .string "%s"
name:
    .string "Hello %s !\n"

.data
pointer:
    .quad 0

.globl main
    .type main, @function

.text
main: 
    pushq %rbp 
    movq %rsp, %rbp   

    #Print enter your name
    movq $ask, %rdi         
    movq $0, %rax  
    call printf

    #Scan for name
    movq $pointer, %rsi         # pointer to 2nd param   
    movq $inputformat, %rdi      # pointer to 1st param   
    movq $0, %rax 
    call scanf                  # aquire the input name
    
    #Print Hello name
    movq $pointer, %rsi     # get the pointer for the start of input name (2nd param)
    movq $name, %rdi      # pointer to 1st param         
    movq $0, %rax
    call printf

    leave 
    ret 
.size main,.-main
