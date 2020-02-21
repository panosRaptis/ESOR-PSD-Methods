# Numerical Solution of Big Pentadiagonal Linear Systems (by using ESOR and PSD Iterative Methods)

On this project, we want to solve a linear system Ax = b, by using ESOR (Extrapolated Successive Overrelaxation) and PSD (Preconditioned Simultaneous Displacement) numerical methods. Thats because we assume that A is an pentadiagonal matrix and as a result it is an sparse matrix. So, it is clear that classic numerical methods for solving linear systems are not useful. On the other hand, we have to take advantage of the special matrix's structure and its sparcity. For that reason we represent these two numerical methods, which belong to the family of the best iterative methods for solving linear systems. Especially for PSD's case, we use the Niethammer scheme in order to somehow reduce the high computational cost of the method.

Our purpose is to find the best values of tau and omega. Best translates to minimum number of interations. For that reason, we solve the linear system for tau = 0.1:0.1:1.9 and omega = 0.1:0.1:1.9 and select the best values for tau and omega. In both ESOR and PSD method, we choice as x(0) = b and tol = 0.5 * 10^(-6). Additionally, the user has the following opportunities:
 - creating a pentadiagonal matrix with parameters k, l, d, r, s (Code: 1)
 - running specific applications (Code: 2)
 - taking a matrix from a txt file (Code: 3)
 - creating a random strict diagonally dominant matrix (Code: 4)
 - terminate program/exit (Code: 5)
