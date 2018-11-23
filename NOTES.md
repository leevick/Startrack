# 23 November, 2018

Let $(x_i^j,y_i^j,I_i^j)$ denotes the loacation of start $j$ in the $i$-th image of a consecutive image sequence. $N_i$ is the total number of starts discovered.


$$\vec{X}_i = (x_i^{1},...,x_i^{N_i})^T$$ (1)
$$\vec{Y}_i = (y_i^{1},...,y_i^{N_i})^T$$ (2)
$$\mathbf{P}_i = [\vec{x_i},\vec{y_i}]^T$$ (3)


Neglecting the precision of position recover. The relationship be between stars location of image $i$ and $j$ could be formulated as shown in Eq.(4),

$$\mathbf{P}_j = \mathbf{R}_{ij}\mathbf{P}_i\mathbf{M}_{ij}$$ (4)

where $\mathbf{R}_{ij}$ is the matrix of rotation transform (as shown in detail in Eq.), and $\mathbf{M}_{ij}$ is the star matching matrix.

The algorithm consists of the following stages:

1. Find a coarse estimation of the rotational matrix, denoted as $\hat{\mathbf{R}_{ij}}$.

2. Optimize the following problem to find the matching matrix

$$\text{min}_{\mathbf{M}_{ij}} ||\mathbf{P}_j - \hat{\mathbf{R}_{ij}}\mathbf{P}_i\mathbf{M}_{ij}||_2 $$ (5)





# 26 October, 2018

* An individual star in image is described by $(x,y,I)$, where $I$ is the intensity.
* A set of stars (or stellar), is abstracted to a rigid body.
* The position of a stellar in images is hearby represented the centroid location.
* The attitude of a stallar is represented by the moment of inertia of this abstract rigid body.