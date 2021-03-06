[Mesh]
  file = square.e
[]

[Variables]
  [./diffused]
    order = FIRST
    family = LAGRANGE
  [../]

  [./forced]
    order = FIRST
    family = LAGRANGE
  [../]
[]

# The Preconditioning block
[Preconditioning]
  [./PBP]
    type = PBP
    solve_order = 'diffused forced'
    preconditioner  = 'LU LU'
    off_diag_row    = 'forced'
    off_diag_column = 'diffused'
  [../]
[]

[Kernels]
  [./diff_diffused]
    type = Diffusion
    variable = diffused
  [../]

  [./conv_forced]
    type = CoupledForce
    variable = forced
    v = diffused
  [../]

  [./diff_forced]
    type = Diffusion
    variable = forced
  [../]
[]

[BCs]
  #Note we have active on and neglect the right_forced BC
  active = 'left_diffused right_diffused left_forced'

  [./left_diffused]
    type = DirichletBC
    variable = diffused
    boundary = 'left'
    value = 0
  [../]

  [./right_diffused]
    type = DirichletBC
    variable = diffused
    boundary = 'right'
    value = 100
  [../]

  [./left_forced]
    type = DirichletBC
    variable = forced
    boundary = 'left'
    value = 0
  [../]

  [./right_forced]
    type = DirichletBC
    variable = forced
    boundary = 'right'
    value = 0
  [../]
[]

[Executioner]
  type = Steady
[]

[Outputs]
  exodus = true
[]
