[Mesh]
  file = m1.e

[]

[Variables]
  [./temp]
  [../]
[]

[Kernels]
  [./heat_conduction]
    type = HeatConduction
    variable = temp
  [../]
  [./heat_source]
    type = HeatSource
    variable = temp
    value = 10000
  [../]
[]

[Materials]
  [./heat_conductor]
    type = HeatConductionMaterial
    thermal_conductivity = 1
    block = 'bottom_center middle_center top_center external'
  [../]
[]

[BCs]
  [./hl]
    type = DirichletBC
    variable = temp
    boundary = 'heating_low'
    value = 200
  [../]
[]

[Executioner]
  type = Steady

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'



  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
  output_on = 'initial timestep_end'
  [./console]
    type = Console
    perf_log = true
    output_on = 'timestep_end failed nonlinear linear'
  [../]
[]

[Postprocessors]
  [./peak_temp]
    type = NodalMaxValue
    variable = temp
  [../]
[]
