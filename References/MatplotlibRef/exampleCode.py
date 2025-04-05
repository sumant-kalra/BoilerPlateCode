#!/usr/bin/python3

# Solve e^x numerically for different values of x

import math 
import numpy as np 
from matplotlib import pyplot as plt

# ----------------------------------------------------------- #
# e^x = 1 + x/1 + x^2/2! + x^3/3! +....
# CSA+O for all the values of x
def exponentAnalysis( x, nIterations):
    result = 0.0 
    term = 1.0

    nIterResult2DArray = np.empty((nIterations, 2))

    if x < 0:
        return 1/exponentAnalysis(-1*x, nIterations, nIterResult2DArray)

    for i in range(nIterations):
        result += term
        term = term*x/(i+1)
        nIterResult2DArray[i][0] = i+1
        nIterResult2DArray[i][1] = result

    return result, nIterResult2DArray

# ----------------------------------------------------------- #
# Final optimized implementation
def exponent( x, relErrorMax, nMaxIterations):
    result = 0.0 
    term = 1.0

    nIterResult2DArray = np.empty((nMaxIterations, 2))

    if x < 0:
        return 1/exponent(-1*x, relErrorMax, nMaxIterations)

    relError = 1.0
    i = 0
    while i < nMaxIterations and relError > relErrorMax:
        result += term
        term = term*x/(i+1)
        relError = math.fabs(term)/result
        nIterResult2DArray[i][0] = i+1
        nIterResult2DArray[i][1] = result
        i = i+1

    nIterResult2DArray = nIterResult2DArray[:i, :]
    return result, nIterResult2DArray

# ----------------------------------------------------------- #
if __name__ == '__main__':

    # Inputs
    x = 5 
    nIterations = 50
    maxRelError = 1e-8
    
    # Solution:
    #expX, nIterResult2DArray = exponentAnalysis(x, nIterations)
    expX, nIterResult2DArray = exponent(x, maxRelError, nIterations)
    print(f'e^{x}: ', expX)

    # ----------------------------------------------------------- #
    fig, ax = plt.subplots(1,2)
    # 1. Convergence; 2. Stability, x=x+0.1 
    ax[0].scatter(nIterResult2DArray[:, 0], nIterResult2DArray[:,1], c = 'blue', label = 'e^x')
    ax[0].legend()
    ax[0].set_xlabel('nIterations')
    ax[0].set_ylabel('e^x') 

    # 3. Accuracy
    print('Residual:' , x-math.log(expX))
    actualValue = expX 

    def caclRelError(row):
        iter, value = row
        return iter,math.fabs(value-actualValue)/actualValue 

    nIterRelerror2DArray = np.array([caclRelError(row) for row in nIterResult2DArray])

    ax[1].scatter(nIterRelerror2DArray[:,0], nIterRelerror2DArray[:,1], c = 'red', label = 'RelError')
    ax[1].legend()
    ax[1].set_xlabel('nIterations')
    ax[1].set_ylabel('relError') 
    
    plt.show()
