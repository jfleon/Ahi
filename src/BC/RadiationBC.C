/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#include "RadiationBC.h"

template<>
InputParameters validParams<RadiationBC>()
{
  InputParameters params = validParams<IntegratedBC>();

  // Here we are adding a parameter that will be extracted from the input file by the Parser
  params.addParam<Real>("emissivity", 1.0, "Value multiplied by the coupled value on the boundary");
  params.addRequiredCoupledVar("some_var", "Flux Value at the Boundary");
  return params;
}

RadiationBC::RadiationBC(const InputParameters & parameters) :
    IntegratedBC(parameters),
    _emissivity(getParam<Real>("emissivity")),
    _some_var_val(coupledValue("some_var"))
{}

Real
RadiationBC::computeQpResidual()
{
  return 5.670373e-8*_test[_i][_qp]*_emissivity*std::pow((_some_var_val[_qp]-300),4);
}
