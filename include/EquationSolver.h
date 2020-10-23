#ifndef _EQUATION_SOLVER_
#define _EQUATION_SOLVER_

#include "Specifications.h"
#include "Point.h"
#include "Hexagon.h"
#include <iostream>

class EquationSolver
{
private:
    Point3D Coordinate;
    AngleSet Angle; 

public:
    EquationSolver();
    EquationSolver(double x,double y,double z);
    EquationSolver(Point3D c);
    ~EquationSolver();

    void DataInput(double x,double y,double z);
    void DataInput(Point3D c);
    AngleSet DataOutput();

    bool Process(); 
};

struct Anglex6
{
    double a[6];
};
typedef Anglex6 AngleSet;

#endif