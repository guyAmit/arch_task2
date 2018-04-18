
#include <stdlib.h>
#include <stdio.h>

extern void cumulative_sum(double*,double*);
extern void cumulative_mul(double*,double*);
extern void cumulative_sub(double*,double*);
extern double absulut_value(double*);
extern double* pow_complex(double*,int);
extern double* div_complex(double*,double*);
extern double* deriv_coeff(double*,int order);
extern double* eval_f(double*,int,double*);

int main(int argc, char const *argv[]) {

  double * num1 =(double*)malloc(sizeof(double)*2);
  num1[0] = 1.0;
  num1[1]  = 0.0;
  double * num2 =(double*)malloc(sizeof(double)*2);
  num2[0] = 2.0;
  num2[1]  = 0.0;
  double * num3 =(double*)malloc(sizeof(double)*2);
  num3[0] = 1.0;
  num3[1]  = 0.0;
  double * coeff = (double*)malloc(sizeof(double)*6);
  coeff[0]=num1[0];
  coeff[1]=num1[1];
  coeff[2]=num2[0];
  coeff[3]=num2[1];
  coeff[4]=num3[0];
  coeff[5]=num3[1];
  double * init =(double*)malloc(sizeof(double)*2);
  init[0] = 2.0;
  init[1]  = 0.0;

  double* result = eval_f(coeff,2,init);

  printf("%lf %lf \n",result[0], result[1]);

  free(num1);
  free(num2);
  free(num3);
  free(coeff);
  free(result);
  return 0;
}
