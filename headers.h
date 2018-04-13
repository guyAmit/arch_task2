typedef struct complex_num{
    float real;
    float imaginary;
}complex_num;

void print_input(int order, float epsilon, complex_num** coeff, complex_num* initial);
void print_complex(complex_num* num);

complex_num** deriv_coeff(complex_num** coeff, int order);

complex_num* calc_f(complex_num** coeff,int order, complex_num* initial);

complex_num* add_copmplex( complex_num* num1, complex_num* num2);

complex_num* sub_copmplex( complex_num* num1, complex_num* num2);

complex_num* div_copmplex( complex_num* num1, complex_num* num2);

complex_num* pow_copmplex( complex_num* num1, int n);

complex_num* cumaltive_sum( complex_num* num1, complex_num* num2);

complex_num* cumaltive_mul( complex_num* num1, complex_num* num2);

float abstract_value(complex_num * num);
