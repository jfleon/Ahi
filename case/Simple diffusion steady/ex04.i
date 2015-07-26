[Mesh]
  file = m2.e
[]

[Variables]
  active = 'diffused'

  [./diffused]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  active = 'diff'

  [./diff]
    type = Diffusion
    variable = diffused
  [../]
[]

[BCs]
  active = '4 top bottom'

  [./4]
    type = NeumannBC
    variable = diffused
    boundary = '4'
    value = 10
  [../]

  [./top]
    type = DirichletBC
    variable = diffused
    boundary = 'top'
    value = 0
  [../]
  [./bottom]
    type = DirichletBC
    variable = diffused
    boundary = 'bottom'
    value = 0
  [../]
[]

[Executioner]
  type = Steady

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'


[]

[Outputs]
  file_base = out
  exodus = true
  print_linear_residuals = true
  print_perf_log = true
[]
