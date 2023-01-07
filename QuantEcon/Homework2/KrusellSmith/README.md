# Standard incomplete markets model (Aiyagari) with aggregate shocks

The `master.m` file solves a model of incomplete markets *a la* Aiyagari with aggregate shocks by Krusell-Smith method. In this model, consumers' problem is as follows:

$$
\max_{ \left\lbrace c_t \right\rbrace } \mathbb{E} \sum_{t=0}^{\infty} \beta^t \left\( u(c_t) \right)
$$  

subject to:

$$
a_{t+1} + c_t = w_t z_t + (1+r_t) a_t
$$

$$
c_t \geq 0
$$

$$
a_t \geq - B
$$

where $c_t$ is consumption, $a_t$ are assets, $z_t$ is labor productivity, $w_t$ is the wage wage, $r_t$ is the interest rate and $B$ is the borrowing limit. On the other hand, a representative firm solves the following maximization problem:

$$
\max_{K,L} \left\lbrace Z_tK_t^{\alpha}L_t^{1-\alpha} - (r_t+\delta)K_t - w_t L_t  \right\rbrace
$$

The calibration is as follows: $\beta=0.96, \ \sigma=1.0, \ B=0, \ \alpha=0.33, \ \delta=0.05$, and the number of assets grid point is set as $n_{aa}=200$. Moreover, there are two idiosyncratic productivity levels $(z_1, z_2) = (0.1, 1.0)$ and two aggregate productivity shocks $(Z_1, Z_2) = (0.99, 1.01)$, each one with the corresponding transition matrix. Finally, utility function has a CRRA form. 

Policy functions are obtained by endogenous grid method and the model is solved by nonstochastic simulation *a la* Young. The `master.m` file also plots figures of the distribution of assets, time series of capital, productivity, and prices; and the DenHaan' test.  If you want to deactivate this option then set `p.fig=0` in the script `parameters.m`. 

## References

This code follows closely Maliar, Maliar, and Valli (2010, JEDC), but with some differences. For instance: 
- Instead of using the initial distribution of assets proposed in MMV, I use the distribution from the solution of Aiyagari's model without aggregate uncertainty.
- The grid for aggregate capital is linearly-spaced, while for assets is log-spaced. The minimum and maximum values of aggregate capital are equal to $0.5 \times \bar{K}$ and $1.5 \times \bar{K}$, where $\bar{K}$ is the mean of capital obtained in the baseline model of Aiyagari without aggregate uncertainty. 
- The number of assets grids points for getting the optimal policy functions is 200. It increases to 500 when I compute the nonstochastic simulation. 
- The initial values of $\beta$ are equal to 
$$
\beta_0=[\log(\bar{K}) \ 0 \ \log(\bar{K}) \ 0]
$$
On the other hand, I calibrate $\xi=0.3$ (updating parameter for the coefficients B in the ALM).


## Matrix of transition probabilities

$$
\Pi
= \Pi_Z \otimes \Pi_z
$$

