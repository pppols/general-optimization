# general-optimization

**general-optimization** is a self-contained framework for mathematical optimization written fully in lua, intended to be used for solving arbitrary optimization and optimal control problems.

the framework is intended to provide the necessary components to easily set up and solve such problems without needing to worry about underlying mechanisms, with instead having *optional* parameters to interface with if required.


## features

the **general-optimization** framework intends to provide:

- an easy mechanism to define optimization problem wrappers
- various algorithms to solve optimization problems, depending on their properties
- simple definitions for common dynamical constraints, such as centroidal dynamics
- an automatic differentiation system for simple problems


## usage

todo


## todo

sooner:

- rewrite `components` (rename to \library)
- finish `minimization problem` definitions
- implement simple krylov subspace methods
- implement newton rhapson on method of lagrange multipliers

later:

- finish readme
- include alternative optimization formulations
- implement mentioned automatic differentiation
- implement common dynamical systems
- implement more general nonlinear solvers