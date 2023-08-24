# 📚 Repository Description

This repository contains two projects related to the Computer Architecture course (DCA0104) taught by Professor Diogo Pinheiro Fernandes Pedrosa. The projects are divided into two parts:

## Part 1: MIPS Architecture Instruction Set (integer value operations)

The first project deals with the implementation of an assembly program for the MIPS architecture. The goal is to calculate the histogram of a signal sample vector, representing the count of occurrences of each intensity present in the vector.

The program uses integer value operations and follows the following algorithm:

1. Declaration of variables and constants: Lmax (maximum number of intensities) and TAM (vector size).
2. Initialization of the H vector: sets all elements to zero.
3. Calculation of the histogram: iterates through the sample vector and increments the corresponding value in the H vector.
4. Displaying the H vector using a system call (syscall).

The program should be tested on a MIPS simulator such as MARS or QtSPIM.

## Part 2: MIPS Assembly Programming (floating-point operations)

The second project involves the application of the bisection method to find the positive root of an equation. The MIPS assembly program implements this method and calculates the approximate root.

The bisection method involves gradually reducing an interval [a, b] until a specified tolerance and testing the intermediate value to see if it is close to the desired root.

The program follows the algorithm of the bisection method and takes the following parameters as input: endpoints a and b, tolerance TOL, maximum number of iterations N.

The program's output will display the approximate solution p or the message "Root not found!" if the solution is not found within the maximum number of iterations.

In this project, the equation used is f(x) = x^3 - 10, and the positive root should be found with a tolerance of 0.1, a maximum of 10 iterations, and a search interval of [2.0, 3.0].

The program should also be tested on a MIPS simulator such as MARS or QtSPIM.

## License

This repository is licensed under the [MIT License](LICENSE).
