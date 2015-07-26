[Mesh]
 file=m5_scaled.e
# units are SI
[]

[Variables]
  [./temp]
    initial_condition = 300 # Start at room temperature
  [../]
[]

[Kernels]
  [./heat_conduction]
    type = HeatConduction
    variable = temp
  [../]
  [./heat_conduction_time_derivative]
    type = HeatConductionTimeDerivative
    variable = temp
  [../]
[]

[BCs]
  active = 'heater top bottom'

  [./heater]
    type = NeumannBC
    variable = temp
    boundary = 'heater'
    value = 1e5 #W/m^2
  [../]

  [./top]
    type = DirichletBC
    variable = temp
    boundary = 'top'
    value = 300
  [../]
  [./bottom]
    type = DirichletBC
    variable = temp
    boundary = 'bottom'
    value = 300
  [../]
[]

[Materials]
  [./steel]
    type = GenericConstantMaterial
    block = '4'
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '18 0.466 8000' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
 [./fake_mat]
    type = GenericConstantMaterial
    block = '1 2 3'
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '1.8 0.466 2000' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
[]

[Executioner]
  type = Transient

  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
  dt=60  
  num_steps = 100
  start_time=0
  end_time=6000
  dtmax=60
  dtmin=1
l_max_its = 100
l_tol = 1e-2
nl_max_its = 100
nl_rel_tol = 1e-8
nl_abs_tol = 1e-12
[]

[Outputs]
  output_initial = true
  exodus = true
  print_perf_log = true
  print_linear_residuals = true
[]
