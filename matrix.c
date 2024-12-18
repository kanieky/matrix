// #include <stdio.h>
// #include <string.h>
// #include <stdlib.h>

// typedef struct Matrix {
// 	int row;					//Number of rows
// 	int column;				//Number of columns
// 	int* data;	//Address of matrix data
// }Matrix;

// int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2){
//     if (source1->column == 0|| source1->row ==0 || source2->column == 0|| source2->row == 0)
//     {
//         /* code */
//         return 1;
//     }
    
//     if (source1->column != source2->row)
//     {
//         return 1;
//     }
    
//     for (int i = 0; i < source1->row; i++)
//     {
//         for (int j = 0; j < source2->column; j++)
//         {
//             /* code */
//             int sum = 0;
//             for (int k = 0; k < source1->column; k++){
//                 sum += source1->data[i * source1->column + k] * source2->data[k * source2->column + j];
//             }
//             results->data[i * results->column + j] = sum;
//         }
//     }  

//     return 0;
// }