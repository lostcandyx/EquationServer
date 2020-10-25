#ifndef _EQUATIONSOLVER_H_
#define _EQUATIONSOLVER_H_

#include "Specifications.h"
#include "Hexagon.h"
#include "Matrix.h"
#include <iostream>

class EquationSolver
{
private:
    Point3D Coordinate;
    AngleSet Servo; 

    Hexagon Actuator;
    Hexagon Platform;

    bool IsActuatorReady;
    bool IsPlatformReady;

public:
    EquationSolver();
    EquationSolver(double x,double y,double z);
    EquationSolver(Point3D c);
    ~EquationSolver();

    void SetCoordinate(double x,double y,double z);
    void SetCoordinate(Point3D c);
    AngleSet GetServo();

    void SetActuator(Hexagon input);
    void SetPlatform(Hexagon input);

    Hexagon GetActuator();
    Hexagon GetPlatform();

    bool Process(); 
};



#endif