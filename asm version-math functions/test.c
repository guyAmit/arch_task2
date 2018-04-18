
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
  init[0] = 1.5;
  init[1]  = 0.0;

  double* deriv = deriv_coeff(coeff,2);

  double* initial_in_f = eval_f(coeff,2,init);
  double epsilon=1.0e-11;
  do{
    double * initial_in_deriv =eval_f(deriv,1,init);
    double* div_result = div_complex(initial_in_f,initial_in_deriv);
    cumulative_sub(init,div_result);
    free(div_result);
    free(initial_in_f);
    free(initial_in_deriv);
    initial_in_f=eval_f(coeff,2,init);
  }while(absulut_value(initial_in_f)>epsilon);

  printf("%.16e %.16e \n",init[0], init[1]);
  free(num1);
  free(num2);
  free(num3);
  free(init);
  free(coeff);
  free(deriv);
  free(initial_in_f);
  return 0;
}

/*
epsilon = 6.234564
order = 3
coeff 1 = 1 2
coeff 2 = 3 4
coeff 3 = 5 6
coeff 0 = 7 8
initial = 9 -10
*/
