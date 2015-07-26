[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
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
    block = 0
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = temp
    boundary = 'left right'
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
