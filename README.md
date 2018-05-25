# Caspl task2 - complex polynomial roots calculator


homework 3 in the caspl course at ben Gurion university. in this project
we will build :
  1) asm-nasm polynomial roots calculator
  2) c polynomial roots calculator

the purpose of this project is to get fmilier with the x87-subsystem

## Getting Started

for running the asm calculator go to asm-version-math functions and use
```
make run or for running with input:  ./root <input_file.sic
```
for running the c version
```
  make run - from the original folder
```

## polynomial representation
in order to use the calculators one need to write his input in a specific form.
first insert the order by :
```
order = <number>
```
then start typing coefficients in the following form:
```
coeff  <index> = <real val> <img val>
```
then choose the amount of accuracy of the root by :
```
epsilon = <some small number number>
```

## Currently Supporting

* **both the ASM and the c versions-project is completed**


## Prerequisites

This project was built on Linux operating system only.
and it will support only Linux operating systems.

## Versioning

current version : 1.0.0

## Authors

* **Guy Amit** - [guyAmit](https://github.com/guyAmit)
* **Omri Eitan** -[omrieitan](https://github.com/omrieitan)

## License
M.I.T License in separate file
