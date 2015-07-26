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

#ifndef RADIATIONBC_H
#define RADIATIONBC_H

#include "IntegratedBC.h"

//Forward Declarations
class RadiationBC;

template<>
InputParameters validParams<RadiationBC>();

/**
 * Implements a BBT flux condition based upon CoupledNeumann BC in example 4
one parameter is emissivity
 */
class RadiationBC : public IntegratedBC
{
public:

  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
 RadiationBC(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpResidual();

private:
  /**
   * Multiplier on the boundary.
   */
  Real _emissivity;

  /**
   * Holds the values at the quadrature points
   * of a coupled variable.
   */
  VariableValue & _some_var_val;
};

#endif //RADIATIONBC_H
