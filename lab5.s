#Vivek Chauhan
.file "lab5.s"
.section .data
    input: 
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
    .quad 0   # Space for eight characters
.section .text
    .global main
    .type main, @function

# Bit shift encryption function
encrypt:
    pushq %rbp
    movq %rsp, %rbp
    movb (%rdi), %cl   # Get the character to encrypt
    shl $1, %cl        # Shift bits to left
    movb %cl, (%rdi)   # Store the result
    popq %rbp
    ret

main:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, %r12   # character count

getchar_loop:
    movl $0, %eax
    call getchar
    cmpl $-1, %eax    # Check if EOF
    je print_output    # If EOF is reached, print output and exit

    movb %al, input(%r12)  # Save char into memory at the correct index

    leaq input(%r12), %rdi
    call encrypt    # Encrypt the character

    addq $1, %r12    # increment the count

    cmpq $8, %r12    # If we have eight characters, print and reset
    jne getchar_loop

    movq $8, %r13   # Number of characters to print
    call print_chars

    movq $0, %r12   # reset the count
    jmp getchar_loop  # Continue to get more characters

print_output:
    movq %r12, %r13   # Number of characters to print
    call print_chars

exit:
    movl $0, %eax
    leave
    ret

print_chars:
    movq $0, %r12   # reset index for printing

print_loop:
    cmpq %r12, %r13  # Check if we've printed all characters
    je exit_print

    movb input(%r12), %dil   # Get character to print
    movl $0, %eax
    call putchar

    addq $1, %r12   # increment the count
    jmp print_loop

exit_print:
    ret
