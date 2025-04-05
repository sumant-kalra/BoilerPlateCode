#!/usr/bin/python3

# Plot the data from the file "Data.txt"

import pandas as pd
import pathlib

from matplotlib import pyplot as plt 

def plotData():
    filePath = pathlib.Path(r"/Users/sumantkalra/dev/Projects/Computations/build/DataOut.txt")
    df = pd.read_csv(filePath)
    print(df.columns)

    fig, ax = plt.subplots(1,2)
    ax[0].scatter(df['nIteration'], df['Value'], color='blue', label = "e^x")
    ax[0].set_xlabel('nIterations')
    ax[0].set_ylabel('e^x')
    ax[0].legend()
    ax[1].scatter(df['nIteration'], df['relError'], color='red', label = "relError")
    ax[1].set_xlabel('nIterations')
    ax[1].set_ylabel('relError')
    ax[1].legend()
    plt.show()

if __name__ == '__main__':
    plotData()
