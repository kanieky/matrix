
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

    ; Please write your code below that will implement:
    ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
	; R0 is results,R1 is source1, R2 is source2, R3 is i, R4 is j, R5 is k,R6 is sum,R7 is R1 row,R8 is R1 col,R9 is R2 row

matrix_mul_start
	LDR R7, [R1,#4]
	LDR R8, [R2,#4]
	CMP R7, R8
	BEQ matrix_mul_exit

	MOV R3, #0
	MOV R4, #0
	MOV R5, #0

loop_i
	LDR R7, [R1]
	CMP R3, R7
	BGE matrix_mul_exit 

loop_j
	LDR R7, [R2,#4]
	CMP R4, R7
	BGE loop_i
	MOV R6, #0

loop_k
	LDR R7, [R1,#4]
	CMP R5, R7
	BGE label_j
	;resoure1[i][k]
	LDR R8, [R1,#4]
	MUL R8, R3, R8
	ADD R8, R8, R5
	ADD R8, R8, R1
	LDR R8, [R8,#8]
	;resoure2[k][j]
	LDR R9, [R2,#4]
	MUL R9, R5, R9
	ADD R9, R9, R4
	ADD R9, R9, R2
	LDR R9, [R9,#8]
	MUL R6, R8, R9
	ADD R5, #1
	LDR R9, [R1,#8]
	;mul and add
	MUL R10, R9, R8
	ADD R6, R6, R10
	B loop_k

label_j
	LDR R10, [R0,#4]
	MUL R10, R3, R10
	ADD R10, R10, R4
	ADD R10, R10, R0
	STR [R10,#8], R6
	B loop_j

matrix_mul_exit
	BX		LR
	END