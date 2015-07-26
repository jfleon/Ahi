#include "AhiApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "RadiationBC.h" // specific module
#include "PostprocessorFunction.h" //from moose/test directory
#include "ScalarDirichletBC.h" //from moose exampel 18

template<>
InputParameters validParams<AhiApp>()
{
  InputParameters params = validParams<MooseApp>();

  params.set<bool>("use_legacy_uo_initialization") = false;
  params.set<bool>("use_legacy_uo_aux_computation") = false;
  return params;
}

AhiApp::AhiApp(const std::string & name, InputParameters parameters) :
    MooseApp(name, parameters)
{
  srand(processor_id());

  Moose::registerObjects(_factory);
  ModulesApp::registerObjects(_factory);
  AhiApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ModulesApp::associateSyntax(_syntax, _action_factory);
  AhiApp::associateSyntax(_syntax, _action_factory);
}

AhiApp::~AhiApp()
{
}

// External entry point for dynamic application loading
extern "C" void AhiApp__registerApps() { AhiApp::registerApps(); }
void
AhiApp::registerApps()
{
  registerApp(AhiApp);
}

// External entry point for dynamic object registration
extern "C" void AhiApp__registerObjects(Factory & factory) { AhiApp::registerObjects(factory); }
void
AhiApp::registerObjects(Factory & factory)
{
 registerBoundaryCondition(RadiationBC);
 registerFunction(PostprocessorFunction);
 registerBoundaryCondition(ScalarDirichletBC);
}

// External entry point for dynamic syntax association
extern "C" void AhiApp__associateSyntax(Syntax & syntax, ActionFactory & action_factory) { AhiApp::associateSyntax(syntax, action_factory); }
void
AhiApp::associateSyntax(Syntax & syntax, ActionFactory & action_factory)
{
}
