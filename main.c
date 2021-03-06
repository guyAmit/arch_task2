

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "headers.h"

int main(int argc, char *argv[]) {

    printf("%d",stdout);
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
    complex_num** deriv = deriv_coeff(coeff,order);

    complex_num* initial =(complex_num*) malloc(sizeof(complex_num));
    fscanf(stdin, "%s%s%lf%lf", name,eq, &initial->real,&initial->imaginary);

    complex_num * div_result;
    complex_num * initial_in_f =calc_f(coeff,order,initial);
    do{
        complex_num * initial_in_deriv = calc_f(deriv,order-1,initial);
        div_result= div_copmplex(initial_in_f,initial_in_deriv);
        cumulative_sub(initial,div_result);
        free(div_result);
        free(initial_in_deriv);
        free(initial_in_f);
        initial_in_f=calc_f(coeff,order,initial);
    }while(abstract_value(initial_in_f) > epsilon);

    free(initial_in_f);
    printf("\nroot=: ");
    print_complex(initial);
    printf("\n");
    return 0;
}


void print_input(int order, double epsilon, complex_num** coeff, complex_num* initial){
    printf("order: %i\n",order);
    printf("epsilon: %.16e\n",epsilon);
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
    printf("%.16e %.16e",num->real,num->imaginary);
}

complex_num* pow_copmplex( complex_num* num1, int power){
    complex_num * result =(complex_num*)malloc(sizeof(complex_num));
    result->real=num1->real;
    result->imaginary=num1->imaginary;
    for (int i = 0; i < power-1 ; i++) {
        cumulative_mul(result,num1);
    }
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


complex_num* cumulative_sub( complex_num* num1, complex_num* num2){
    num1->real=num1->real-num2->real;
    num1->imaginary=num1->imaginary-num2->imaginary;
    return num1;
}

complex_num* sub_copmplex( complex_num* num1, complex_num* num2){
    complex_num * result = (complex_num*) malloc(sizeof(complex_num));
    result->real=num1->real-num2->real;
    result->imaginary=num1->imaginary-num2->imaginary;
    return num1;
}

complex_num* cumulative_sum( complex_num* num1, complex_num* num2){
    num1->real=num1->real+num2->real;
    num1->imaginary=num1->imaginary+num2->imaginary;
    return num1;
}

complex_num *cumulative_mul(complex_num* num1, complex_num* num2){
    double tempReal=num1->real;
    num1->real=(tempReal*num2->real - num1->imaginary*num2->imaginary);
    num1->imaginary=(tempReal*num2->imaginary+num1->imaginary*num2->real);
    return num1;
}

complex_num* calc_f(complex_num** coeff,int order, complex_num* initial){
    complex_num * result=(complex_num*)(malloc(sizeof(complex_num)));
    complex_num * temp;
    result->real=coeff[0]->real;
    result->imaginary=coeff[0]->imaginary;
    for (int i = 1; i <=order ; i++) {
        temp=pow_copmplex(initial,i);
        cumulative_mul(temp,coeff[i]);
        cumulative_sum(result,temp);
        free(temp);
    }
    return result;
}

double abstract_value(complex_num * num){
    double result=sqrt(pow(num->real,2)+pow(num->imaginary,2));
    return result;
}