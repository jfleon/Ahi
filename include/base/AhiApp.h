#ifndef AHIAPP_H
#define AHIAPP_H

#include "MooseApp.h"

class AhiApp;

template<>
InputParameters validParams<AhiApp>();

class AhiApp : public MooseApp
{
public:
  AhiApp(const std::string & name, InputParameters parameters);
  virtual ~AhiApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* AHIAPP_H */
