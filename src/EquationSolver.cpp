#include "EquationSolver.h"

EquationSolver::EquationSolver()
{
    Coordinate.X = 0;
    Coordinate.Y = 0;
    Coordinate.Z = 0;
}

EquationSolver::EquationSolver(double x,double y,double z)
{
    Coordinate.X = x;
    Coordinate.Y = y;
    Coordinate.Z = z;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

EquationSolver::EquationSolver(Point3D c)
{
    Coordinate = c;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

EquationSolver::~EquationSolver()
{

}

void EquationSolver::DataInput(double x,double y,double z)
{
    Coordinate.X = x;
    Coordinate.Y = y;
    Coordinate.Z = z;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

void EquationSolver::DataInput(Point3D c)
{
    Coordinate = c;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

AngleSet EquationSolver::DataOutput()
{
    return Angle;
}

bool EquationSolver::Process()
{
    
}