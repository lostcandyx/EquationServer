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



#endif