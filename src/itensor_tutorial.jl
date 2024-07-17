module itensor_tutorial
export main
using ITensors, ITensorMPS

function main()
  # model parameters
  N = 12 # lattice size
  J = -1.0 # SzSz coupling strength
  h = 0.5 # Sx fielf strengh
  periodic = true # boundary conditions
  # calc mode
  calc_dmrg = true 
  #calc_dmrg = false 
  analytic = true

  #local dofs
  if calc_dmrg
    sites = siteinds("S=1/2", N)

    # Operator Sum (transverse field Ising model with open boundary conditions)
    os = OpSum()
    for j = 1:N-1
      os += J, "Sz", j, "Sz", j + 1
      os += h, "Sx", j
    end
    if periodic
      os += J, "Sz", N, "Sz", 1
      os += h, "Sx", N
    end
    # Creating the Hamiltonian from the Operator Sum
    H = MPO(os, sites)

    # calculation parameters
    nsweeps = 25 # number of sweeps is 5
    maxdim = [10, 10, 10, 10, 20, 40, 100, 100, 200, 200, 400] # gradually increase states kept
    cutoff = [1E-10] # desired truncation error

    # initial stat preparation (all spins up (ferromagnetic state))
    psi0 = MPS(sites, "Up")

    # DMRG calculation
    energy, psi = dmrg(H, psi0; nsweeps, maxdim, cutoff)
    println("Ground state energy (DMRG) = ", energy)
  end
  if analytic
    # calculate the exact ground state energy
    exact_ene = 0.0
    !periodic && @warn("The open boundary condition is applied. The output of the exact ground state energy is invalid.")
    for i in 1:N
      q = isodd(N) ? 2pi / N * i : 2pi / N * (i - 0.5) 
      exact_ene += 0.5*sqrt(h^2 + 0.25J^2 - h * J * cos(q))
    end
    println("Ground state energy (analytical) = ", -exact_ene)
  end
  if calc_dmrg && analytic
    println()
    println("Energy error = ", abs(energy + exact_ene))
  end
end

if abspath(PROGRAM_FILE) == @__FILE__
  main()
end
end
