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

## exact ground state energy

$$
E = \sum_{i=1}^{N/2}
\sqrt{\left(h-\frac12J\cos \left(\frac{2i-1}{N}\right)\right)^2+\frac{J^2}{4}\sin^2 \left(\frac{2i-1}{N}\right)}
=\sum_{i=1}^{N/2}\sqrt{h^2-hJ\cos\left(\frac{2i-1}{N}\right)+\frac{J^2}{4}}
$$

Here, the number of spins $N$ should be even.

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

```
Ground state energy (DMRG) = -3.830648787056722
Ground state energy (analytical) = -3.8306487877701936

Energy error = 7.134715040990613e-10
```
