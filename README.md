# itensor_tutorial

[![Build Status](https://github.com/ultimatile/itensor_tutorial.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ultimatile/itensor_tutorial.jl/actions/workflows/CI.yml?query=branch%3Amain)

## target model: $S=1/2$ transverse field Ising chain

Hamiltonian:

$$
H=\sum_{i=1}^N\left(JS^z_i S^z_{i+1} + h S^x_i\right)
$$

When `periodic=true`, the periodic boundary condition is applied: $S^z_{N+1}=S^z_1$.
When `periodic=false`, the open boundary condition is applied; the maximum of the summation index $i$ changes as $N\to N-1$.
The default value is `periodic=true`.

## exact ground state energy for periodic boundary condition

$$
E = -\frac12\sum_{i=1}^{N}
\sqrt{\left(h-\frac{J}{2}\cos q_i\right)^2+\frac{J^2}{4}\sin^2q_i}
=-\frac12\sum_{i=1}^{N}\sqrt{h^2-hJ\cos q_i+\frac{J^2}{4}}
$$

Here, $q_i=\frac{2\pi}{N}(i-\frac12)$ if $N$ is even, and $q_i=\frac{2\pi}{N}i$ if $N$ is odd.
The periodic boundary condition is assumed.

## how to run

After executing Julia REPL, activate the environment and run the script:

```sh:
Pkg> activate .
using itensor_tutorial
main()
```

Alternatively, you can run the script directly with your Julia environment:

```sh:
julia src/itensor_tutorial.jl
```

## expected output
`J = -1.0`, `h = 0.5`, and `periodic = true` are used.

### $N=12$

```
Ground state energy (DMRG) = -3.830648787056722
Ground state energy (analytical) = -3.8306487877701936

Energy error = 7.134715040990613e-10
```

### $N=13$

```
Ground state energy (DMRG) = -4.148114903976182
Ground state energy (analytical) = -4.148114905279376

Energy error = 1.303193997159724e-9
```
