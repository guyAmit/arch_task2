

#include <stdlib.h>
#include <stdio.h>
#include "headers.h"

int main(int argc, char *argv[]) {
    int order;
    char name[25];
    char eq[1];
    double epsilon;

    fscanf(stdin, "%s%s%lf", name,eq, &epsilon);

    fscanf(stdin, "%s%s%i", name,eq, &order);

    complex_num** coeff =(complex_num**) malloc(sizeof(complex_num)*(order+1));

    int indx;

    for(int i=0;i<=order;i++) {
        complex_num* cn =(complex_num*) malloc(sizeof(complex_num));
        fscanf(stdin, "%s%i%s%lf%lf", name,&indx,eq, &cn->real,&cn->imaginary);
        coeff[indx] = cn;
    }

    complex_num* initial =(complex_num*) malloc(sizeof(complex_num));
    fscanf(stdin, "%s%s%lf%lf", name,eq, &initial->real,&initial->imaginary);

    printf("inputs:\n");
    print_input(order,epsilon,coeff,initial);
    printf("\n");

    while(abstract_value(initial) >= epsilon){
        initial = sub_copmplex(initial,div_copmplex(calc_f(coeff,initial),calc_f(deriv_coeff(coeff),initial)));
    }

    printf("root = ");
    print_complex(initial);

    return 0;
}


void print_input(int order, double epsilon, complex_num** coeff, complex_num* initial){
    printf("order: %i\n",order);
    printf("epsilon: %lf\n",epsilon);
    for(int i=0;i<=order;i++){
        printf("coeff[%i]: ",i);
        print_complex(coeff[i]);
        printf("\n");
    }
    printf("initial: ");
    print_complex(initial);
    printf("\n");
}

void print_complex(complex_num* num){
    printf("%lf %lf",num->real,num->imaginary);
}