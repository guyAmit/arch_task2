
#include <stdlib.h>
#include <stdio.h>

typedef struct complex_num{
  double real;
  double img;
}complex_num;


extern void cumulative_sum(complex_num*,complex_num*);
extern void cumulative_mul(complex_num*,complex_num*);
extern void cumulative_sub(complex_num*,complex_num*);
extern double absolute_value(complex_num*);

int main(int argc, char const *argv[]) {
  complex_num * num1 =(complex_num*)malloc(sizeof(complex_num));
  num1->real = 1.0;
  num1->img  = 2.0;
  complex_num * num2 =(complex_num*)malloc(sizeof(complex_num));
  num2->real = 3.0;
  num2->img  = 4.0;
  double res= absolute_value(num1);
  printf("%lf \n",res);
  free(num1);
  free(num2);
  return 0;
}
