# units are SI
# this is a test case with one heat source and one tc that use all the tools we will use for the control law
#................................................................................

[Mesh]
 file=m6.e
[]

[Variables]
  [./temp]
    initial_condition = 300 # Start at room temperature
      [../]
[AuxVariables]
  [./grad_temp_x]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./grad_temp_y]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./grad_temp_z]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./heater_area]
    order = CONSTANT
    family = MONOMIAL
   [../]
[]

[Functions]
  [./fn1]
     #calculate the term source pm1 est la puissance max de la source hs1 la surface et TC1 un thermocouple
    type = ParsedFunction
    value = pm1*(tc1<1000)*pow(abs((1000-tc1)/1000),.2)/hs1
    vars = 'tc1 hs1 pm1'
    vals = 'TC1 heater_area 2000'
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
[AuxKernels]
   [./grad_temp_x_aux]
    type = VariableGradientComponent
    variable = grad_temp_x
    component = x
    gradient_variable = temp
   [../]

   [./grad_temp_y_aux]
    type = VariableGradientComponent
    variable = grad_temp_y
    component = y
    gradient_variable = temp
  [../]

  [./grad_temp_z_aux]
    type = VariableGradientComponent
    variable = grad_temp_z
    component = z
    gradient_variable = temp
  [../]
[]
[BCs]
  active = 'heater small_side bottom'
  [./small_side]
    type = DirichletBC
    variable = temp
    boundary = 'small_side'
    value = 300
  [../]
  [./bottom]
    type = RadiationBC
    variable = temp
    boundary = 'bottom'
    emissivity=0.9
    some_var=temp
   [../]
   [./heater]
     type =FunctionNeumannBC
     variable = temp
     function = fn1
     boundary = 'heater'
   [../]
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
    prop_values = '0.1 0.466 2000' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
[]
[Executioner]
  type = Transient
  scheme = 'explicit-euler'
  solve_type = 'LINEAR'

  start_time = 0.0
  num_steps = 500
  dt = .1
[]
#[Executioner]
#  type = Transient
#
#  solve_type = PJFNK
#  petsc_options_iname = '-pc_type -pc_hypre_type'
#  petsc_options_value = 'hypre boomeramg'
#  dt=1
#  num_steps = 100
#  start_time=0
#  end_time=50
#  dtmax=100
#  dtmin=1e-3
#  l_max_its = 100
#  l_tol = 1e-2
#  nl_max_its = 500
#  nl_rel_tol = 1e-8
#  nl_abs_tol = 1e-10
  #   [./TimeStepper]
  #   type = FunctionDT
  #   time_dt = '5e-3 .2 .5 1 5 20'
  #   time_t =  '0 1 10 30 50 100'
  #   [../]
[]

[Postprocessors]
   [./heater_area] # area of heat source to be used in control law.
     type = AreaPostprocessor
     boundary = heater
     execute_on = initial
   [../]

  [./max_temp]
    type = NodalMaxValue
    variable = temp
    execute_on = 'initial timestep_end'
  [../]

  [./TC1]
    type = PointValue
    variable = temp
    point = '0 0.015 0'
    execute_on = 'initial timestep_begin'
   # outputs = 'csv'
  [../]

[]

[Outputs]
  output_initial = true
  exodus = true
  print_perf_log = true
  print_linear_residuals = true
  [./csv]
    type = CSV
    interval = 1
  [../]

[]

#[./TimeStepper]
#type = IterationAdaptiveDT
#dt = 2e2
#optimal_iterations = 6
#iteration_window = 2
#linear_iteration_ratio = 100
#[../]
