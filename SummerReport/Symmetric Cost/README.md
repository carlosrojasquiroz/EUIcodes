# Symmetric default cost

In this folder I saved files and scripts to estimate default cost parameters under the assumption they are the same across sectors. `Master.m` is the main file and is called from the file with the same name (don't get confused) in the subfolder **Asymmetric Cost**. To a broader description of structures, files and functions go to README file in that subfolder. As there, I estimate default cost parameters using Indirect Inference (`p.moment=0`) and Simulated Method of Moments (`p.moment=1`) by a two-step procedure:
  1. I run a grid search over reasonable values of parameters with `gridsearch.m`. In that function, I use the structures `p`, `v`, and `d` and obtain parameters that minimize the criterion objective in an interval given by `p.LowBoundT` (`p.LowBoundN`) and `p.UpBoundT`(`p.UpBoundT`) for the case of tradable (non tradable) GDP. To do so, I use the function `inference.m`. The model is solved by value function iteration.
  2. I use a Matlab solver (`fminsearch`) taken previous results as initial points. See the function `solversearch.m`.
Results from both methodologies are saved in the self-explained structures `smm0`and `ii0`. 

Then I get the standard errors using those results and other structures by the function `standarderrors.m`.
