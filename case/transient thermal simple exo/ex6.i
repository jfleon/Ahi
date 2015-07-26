[Mesh]
 file=m6.e
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
  active = 'heater small_side'

  [./heater]
  type = NeumannBC
    variable = temp
    boundary = 'heater'
    value = 1e4 #W/m^2
 [../]

  [./small_side]
    type = DirichletBC
    variable = temp
    boundary = 'small_side'
    value = 300
  [../]
  #[./bottom]
   # type = DirichletBC
   # variable = temp
   # boundary = 'bottom'
   # value = 300
  #[../]
[]

[Materials]
  [./steel]
    type = GenericConstantMaterial
    block = '1 2 3'
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '18 0.466 8000' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
 [./fake_mat]
    type = GenericConstantMaterial
    block = '4'
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '1.8 0.466 2000' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
[]

[Executioner]
  type = Transient

  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
  dt=100 
  num_steps = 100
  start_time=0
  end_time=200
  dtmax=100
  dtmin=1
l_max_its = 100
l_tol = 1e-2
nl_max_its = 100
nl_rel_tol = 1e-8
nl_abs_tol = 1e-12

[./TimeStepper]
    type = FunctionDT
    time_dt = '1.5 22'
    time_t =  '0 65'
  [../]
[]
 

[Outputs]
  output_initial = true
  exodus = true
  print_perf_log = true
  print_linear_residuals = true
[]
