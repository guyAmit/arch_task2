

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "headers.h"

int main(int argc, char *argv[]) {
    int order;
    char name[25];
    char eq[1];
    float epsilon;

    fscanf(stdin, "%s%s%e", name,eq, &epsilon);

    fscanf(stdin, "%s%s%i", name,eq, &order);

    complex_num** coeff =(complex_num**) malloc(sizeof(complex_num)*(order+1));
    int indx;

    for(int i=0;i<=order;i++) {
        complex_num* cn =(complex_num*) malloc(sizeof(complex_num));
        fscanf(stdin, "%s%i%s%e%e", name,&indx,eq, &cn->real,&cn->imaginary);
        coeff[indx] = cn;
    }
    complex_num** deriv = deriv_coeff(coeff,order);

    complex_num* initial =(complex_num*) malloc(sizeof(complex_num));
    fscanf(stdin, "%s%s%e%e", name,eq, &initial->real,&initial->imaginary);

    printf("inputs:\n");
    print_input(order,epsilon,coeff,initial);
    printf("\n");

    while(abstract_value(calc_f(coeff,order,initial)) >= epsilon){
        initial = sub_copmplex(initial,div_copmplex(calc_f(coeff,order,initial),calc_f(deriv,order-1,initial)));
    }

    printf("root = ");
    print_complex(initial);


    return 0;
}


void print_input(int order, float epsilon, complex_num** coeff, complex_num* initial){
    printf("order: %i\n",order);
    printf("epsilon: %e\n",epsilon);
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
    printf("%e %e",num->real,num->imaginary);
}

complex_num* pow_copmplex( complex_num* num1, int power){
    float radius = pow(sqrt( pow(num1->imaginary,2) +pow(num1->real,2)),power);
    float theta = power*atan(num1->imaginary/num1->real);
    complex_num* result = (complex_num*)malloc(sizeof(complex_num));
    result->real=radius*cos(theta);
    result->imaginary=radius*sin(theta);
    return result;
}

complex_num* div_copmplex( complex_num* num1, complex_num* num2){
    complex_num* result =(complex_num*) malloc(sizeof(complex_num));
    result->real = ((num1->real*num2->real + num1->imaginary*num2->imaginary) / (num2->real*num2->real + num2->imaginary*num2->imaginary));
    result->imaginary = ((num1->imaginary*num2->real - num1->real*num2->imaginary) / (num2->real*num2->real + num2->imaginary*num2->imaginary));

    return result;
}

complex_num** deriv_coeff(complex_num** coeff,int order){
    complex_num** deriv_coeff;
    if(order==0) {
        deriv_coeff = (complex_num **) malloc(sizeof(complex_num));
        deriv_coeff[0] = (complex_num *) malloc(sizeof(complex_num));
        deriv_coeff[0]->imaginary = 0;
        deriv_coeff[0]->real = 0;
    }
    else if(order==1){
        deriv_coeff = (complex_num **) malloc(sizeof(complex_num));
        deriv_coeff[0] = (complex_num *) malloc(sizeof(complex_num));
        deriv_coeff[0]->imaginary = coeff[1]->imaginary;
        deriv_coeff[0]->real = coeff[1]->real;
    }
    else {
        deriv_coeff = (complex_num **) malloc(sizeof(complex_num) * (order - 1));
        for (int i = 0; i <= order - 1; i++) {
            deriv_coeff[i] = (complex_num *) malloc(sizeof(complex_num));
            deriv_coeff[i]->real = coeff[i + 1]->real * (i + 1);
            deriv_coeff[i]->imaginary = coeff[i + 1]->imaginary * (i + 1);

        }
    }
    return deriv_coeff;
}

complex_num* add_copmplex( complex_num* num1, complex_num* num2){
    complex_num * result = (complex_num*)malloc(sizeof(complex_num));
    result->real=num1->real+num2->real;
    result->imaginary=num1->imaginary+num2->imaginary;
    return result;
}

complex_num* sub_copmplex( complex_num* num1, complex_num* num2){
    complex_num * result = (complex_num*)malloc(sizeof(complex_num));
    result->real=num1->real-num2->real;
    result->imaginary=num1->imaginary-num2->imaginary;
    return result;
}

complex_num* cumaltive_sum( complex_num* num1, complex_num* num2){
    num1->real=num1->real+num2->real;
    num1->imaginary=num1->imaginary+num2->imaginary;
    return num1;
}

complex_num *cumaltive_mul(complex_num* num1, complex_num* num2){
    float tempReal=num1->real;
    float  tempImg=num1->imaginary;
    num1->real=(tempReal*num2->real - tempImg*num2->imaginary);
    num1->imaginary=(tempReal*num2->imaginary+tempImg*num2->real);
    return num1;
}

complex_num* calc_f(complex_num** coeff,int order, complex_num* initial){
    complex_num * result = (complex_num*)malloc(sizeof(complex_num));
    complex_num * temp;
    result=coeff[0];
    for (int i = 1; i <=order ; i++) {
        temp=pow_copmplex(initial,i);
        temp=cumaltive_mul(temp,coeff[i]);
        cumaltive_sum(result,temp);
        free(temp);
    }
    return result;
}

float abstract_value(complex_num * num){
    double result=sqrt(pow(num->real,2)+pow(num->imaginary,2));
    return result;
}