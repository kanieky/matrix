
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

    ; Please write your code below that will implement:
    ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
	; R0 is results,R1 is source1, R2 is source2, R3 is i, R4 is j, R5 is k,R6 is sum

matrix_mul_start

	;check if source1 and source2 are valid
	CMP R1, #0
	BEQ matrix_mul_error
	CMP R2, #0
	BEQ matrix_mul_error
	;check if results is valid
	CMP R0, #0
	BEQ matrix_mul_error

	;check if source1's and source2's data are valid
	LDR R7, [R1]
	CMP R7, #0
	BEQ matrix_mul_error
	LDR R7, [R1,#4]
	CMP R7, #0
	BEQ matrix_mul_error
	LDR R7, [R1,#8]
	CMP R7, #0
	BEQ matrix_mul_error
	LDR R7, [R2]
	CMP R7, #0
	BEQ matrix_mul_error
	LDR R7, [R2,#4]
	CMP R7, #0
	BEQ matrix_mul_error
	LDR R7, [R2,#8]
	CMP R7, #0
	BEQ matrix_mul_error

	;check if source0's data is valid
	LDR R7, [R0,#8]
	CMP R7, #0
	BEQ matrix_mul_error

	;compare row of source1 and column of source2,if not equal,return 1
	LDR R7, [R1,#4]
	LDR R8, [R2]
	CMP R7, R8	
	BNE matrix_mul_error
	MOV R3, #0

loop_i
	LDR R7, [R1]
	CMP R3, R7
	BGE matrix_mul_right
	MOV R4, #0

loop_j
	LDR R7, [R2,#4]
	CMP R4, R7
	BGE label_i
	MOV R6, #0
	MOV R5, #0

loop_k
	LDR R7, [R1,#4]
	CMP R5, R7
	BGE label_j
	;resoure1[i][k]
	LDR R8, [R1,#4]
	MUL R8, R3, R8
	ADD R8, R8, R5
	LDR R10, [R1,#8]
	MOV R7, #4
	MUL R8, R8, R7
	LDR R8, [R10,R8]
	;resoure2[k][j]
	LDR R9, [R2,#4]
	MUL R9, R5, R9
	ADD R9, R9, R4
	LDR R10, [R2,#8]
	MUL R9, R9, R7
	LDR R9, [R10,R9]
	;mul and add
	MUL R10, R9, R8
	ADD R6, R6, R10
	ADD R5, #1
	B loop_k

	;store sum to results[i][j]
label_j  
	LDR R8, [R0,#4]
	MUL R8, R3, R8
	ADD R8, R8, R4
	LDR R10, [R0,#8]
	MOV R7, #4
	MUL R8, R8, R7
	STR R6, [R10,R8]
	ADD R4, #1
	B loop_j

	;i++
label_i
	ADD R3, #1
	B loop_i

	;return 1 if error, 0 if success
matrix_mul_error
	MOV R0, #1
	B matrix_mul_exit

matrix_mul_right
	MOV R0, #0

matrix_mul_exit
	BX		LR
	END