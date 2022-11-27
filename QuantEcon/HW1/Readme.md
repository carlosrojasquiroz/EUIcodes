# Readme

This folder contains files for solving the Homework 1 of **Computations and Quantitative Models in Macro**. 

If you want to replicate the graphs in the slides, please open first the file `Master.m`

## Master.m

In the first subsection of that file, I solve the Aiyagari's model by two methods: the value function iteration and the endogenous grid. 

Note the parameters of the model are saved in the structure "p", whilst the matrices and vectors are housed in the structure "m". 

Also, the objects from the "partial equilibrium" analysis and the Euler equation errors are included in the "m" structure. 

The "general equilibrium" solution of the model are saved in structures "vf" and "eg". 

In subsections 2 and 3 of this file, I obtained the transition paths by two methods: the extended path and the sequence space Jacobians. The latter is under revision since I've identified some typos in the code. 

## graphs.m

Once the solutions in Master.m are obtained, run the file "graphs.m" in order to obtain the same charts presented in the slides. 
