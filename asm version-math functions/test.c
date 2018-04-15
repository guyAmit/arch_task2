
#include <stdlib.h>
#include <stdio.h>

typedef struct complex_num{
  double real;
  double img;
}complex_num;


extern void cumulative_sum(complex_num*,complex_num*);
extern void cumulative_mul(complex_num*,complex_num*);
extern void cumulative_sub(complex_num*,complex_num*);
extern double absulut_value(complex_num*);
extern complex_num* pow_complex(complex_num*,int);
extern complex_num* div_complex(complex_num*,complex_num*);

int main(int argc, char const *argv[]) {
  complex_num * num1 =(complex_num*)malloc(sizeof(complex_num));
  num1->real = 7.0;
  num1->img  = 2.0;
  complex_num * num2 =(complex_num*)malloc(sizeof(complex_num));
  num2->real = 6.0;
  num2->img  = 5.0;
  complex_num* result = div_complex(num1,num2);
  printf("%lf %lf \n",result->real, result->img);
  free(num1);
  return 0;
}
