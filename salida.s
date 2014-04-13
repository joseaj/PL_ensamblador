	.section	.rodata
cadena:	.string	"Resultado = %d\n"

	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	movl	$5, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$2, %eax
	pushl	%eax
	movl	$3, %eax
	movl	%eax, %ebx
	popl	%eax
	addl	%ebx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$2, %eax
	pushl	%eax
	movl	$3, %eax
	pushl	%eax
	movl	$2, %eax
	movl	%eax, %ebx
	popl	%eax
	imull	%ebx, %eax
	movl	%eax, %ebx
	popl	%eax
	addl	%ebx, %eax
	pushl	%eax
	movl	$5, %eax
	pushl	%eax
	movl	$3, %eax
	movl	%eax, %ebx
	popl	%eax
	cdq
	idivl	%ebx, %eax
	movl	%edx, %eax
	movl	%eax, %ebx
	popl	%eax
	subl	%ebx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$7, %eax
	neg	%eax
	pushl	%eax
	movl	$2, %eax
	movl	%eax, %ebx
	popl	%eax
	cdq
	idivl	%ebx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$7, %eax
	pushl	%eax
	movl	$2, %eax
	movl	%eax, %ebx
	popl	%eax
	cdq
	idivl	%ebx, %eax
	movl	%edx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$58, %eax
	neg	%eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$58, %eax
	neg	%eax
	pushl	%eax
	movl	$3, %eax
	movl	%eax, %ebx
	popl	%eax
	cdq
	idivl	%ebx, %eax
	movl	%edx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp

	movl	$58, %eax
	pushl	%eax
	movl	$3, %eax
	neg	%eax
	movl	%eax, %ebx
	popl	%eax
	cdq
	idivl	%ebx, %eax
	movl	%edx, %eax

	pushl	%eax
	pushl	$cadena
	call	printf
	addl	$8, %esp


	movl	$0, %eax
	movl	%ebp, %esp
	popl	%ebp
	ret
