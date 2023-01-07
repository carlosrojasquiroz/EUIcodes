# Standard incomplete markets model with discrete choices

The `master.m` file computes the policy functions (assets, consumption and labor) in a model of incomplete markets with discrete choices. 
Consumer decides each period whether she participates in the labor market or not. To obtain "smooth" policy functions, I also include extreme value taste shocks, following Iskhakov et al. (2017).
Consumer problem is as follows:

$$
\max_{ \left\lbrace c_t,n_t \right\rbrace } \mathbb{E} \sum_{t=0}^{\infty} \beta^t \left\( u(c_t) - \phi n_t + \sigma_{\epsilon} \epsilon (n_t) \right)
$$  

subject to:

$$
a_{t+1} + c_t = n_t w z + (1+r) a_t
$$

$$
c_t \geq 0
$$

$$
a_t \geq - B
$$

$$
n_t \in \left\lbrace 0,1 \right\rbrace
$$

where $c_t$ is consumption, $a_t$ are assets, $z$ is labor productivity, $w$ is the wage wage, $r$ is the interest rate and $B$ is the borrowing limit. Moreover, $n_t$ is the labor supply and $\epsilon(n_t)$ is the (extreme value) taste shock. Note that $\phi$ measures the disutility of labor and $\sigma_{\epsilon}$ is the scalar factor of the shock. 
The calibration is as follows: $\beta=0.96, \ \sigma=1.0, \ B=0, \ \phi=0.75, \ r=0.03, \ w=1, \ z=1$, and the number of assets grid point is set as $n_{aa}=1000$. Finally, utility function is a CRRA form. 

Policy functions are obtained by value function iteration. The `master.m` file also plots figures of the value and policy functions. If you want to deactivate this option then set `p.fig=0` in the file `parameters.m`.

This code works with external functions `logsumexp.m` and `softmax.m`, written by Nick Highman (see [here](https://it.mathworks.com/matlabcentral/fileexchange/84892-logsumexp-softmax)). 

## Details

- I used as a reference the slides from Bence Bardoczy. You can find it in the folder PDFs. 
- **Important!** I used a grid for assets with 5000 points (five times the number proposed in the homework) in order to find finer policy functions.

## Code

Note that we can run three different models with the same code according with the calibration in the file `parameters.m`:

- If we set `p.phi=0` and `p.evind=0`, then we obtain policy functions from the standard incomplete markets model
- If we set `p.phi>0` and `p.evind=0`, then we work with a model with incomplete markets and discrete choice on labor supply
- If we set `p.phi>0` and `p.evind=1`, then we add extreme value (taste) shocks to the previous problem

## Solution

The algorithm took:

- 19.6714 seconds to obtain policy functions (after 45 iterations) for the standard incomplete markets model
- 108.8429 seconds to obtain policy functions (after 264 iterations) for the model with incomplete markets and discrete choice on labor supply
- 106.2008 seconds  to obtain policy functions (after 264 iterations) for the model with extreme value (taste) shocks 

Solutions are saved in the object `DChoicesolution.mat`. You can find a presentation with main results in the file `Homework2_CRQ.pdf` in the previous folder. 
