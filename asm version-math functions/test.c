
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


  double * coeff = (double*)malloc(sizeof(double)*16);
  coeff[0]=5040.0;
  coeff[1]=0.0;
  coeff[2]=13068.0;
  coeff[3]=0;
  coeff[4]=13132.0;
  coeff[5]=0;
  coeff[6]=6769.0;
  coeff[7]=0.0;
  coeff[8]=1960.0;
  coeff[9]=0;
  coeff[10]=322.0;
  coeff[11]=0.0;
  coeff[12]=28.0;
  coeff[13]=0.0;
  coeff[14]=1.0;
  coeff[15]=0.0;




  double * init =(double*)malloc(sizeof(double)*2);
  init[0] = 1.5;
  init[1]  = 0.0;

  double* deriv = deriv_coeff(coeff,7);

 double* initial_in_f = eval_f(coeff,7,init);
 double epsilon=1.0e-11;
  do{
    double * initial_in_deriv =eval_f(deriv,6,init);
    double* div_result = div_complex(initial_in_f,initial_in_deriv);
    cumulative_sub(init,div_result);
    free(div_result);
    free(initial_in_f);
    free(initial_in_deriv);
    initial_in_f=eval_f(coeff,7,init);
  }while(absulut_value(initial_in_f)>epsilon);

  printf("%e %e \n",initial_in_f[0],initial_in_f[1]);

  free(init);
  free(coeff);
  free(deriv);
  free(initial_in_f);
  return 0;
}

/*
epsilon = 6.234564
order = 8
coeff 8 = 1 2
coeff 7 = 1 2
coeff 6 = 1 2
coeff 5 = 1 2
coeff 4 = 1 2
coeff 1 = 1 2
coeff 2 = 3 4
coeff 3 = 5 6
coeff 0 = 7 8
initial = 1 1
*/
