#include "EquationSolver.h"

EquationSolver::EquationSolver()
{
    Coordinate.X = 0;
    Coordinate.Y = 0;
    Coordinate.Z = 0;

    bool IsActuatorReady = false;
    bool IsPlatformReady = false;
}

EquationSolver::EquationSolver(double x,double y,double z)
{
    Coordinate.X = x;
    Coordinate.Y = y;
    Coordinate.Z = z;

    bool IsActuatorReady = false;
    bool IsPlatformReady = false;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

EquationSolver::EquationSolver(Point3D c)
{
    Coordinate = c;

    bool IsActuatorReady = false;
    bool IsPlatformReady = false;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

EquationSolver::~EquationSolver()
{

}

void EquationSolver::SetCoordinate(double x,double y,double z)
{
    Coordinate.X = x;
    Coordinate.Y = y;
    Coordinate.Z = z;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

void EquationSolver::SetCoordinate(Point3D c)
{
    Coordinate = c;

    if (Process())
        std::cout<<"Compute Error"<<std::endl;
}

AngleSet EquationSolver::GetServo()
{
    return Servo;
}

bool EquationSolver::Process()
{
    double L1 = ROD_A_LENGTH;
    double L2 = ROD_B_LENGTH;
    double P_11,P_12,P_13,P_14,P_21,P_22,P_23,P_24;
    double P_31,P_32,P_33,P_34;
    double P3_1,P3_2,P3_3;

    for (int i = 0;i< 6;i++)
    {
        Matrix3D P1 = (Platform.GetVertex(i)); 
        Matrix3D P3 = (Actuator.GetVertex(i)); 

        P_11 = P1.m[Matrix3D::m00];P_12 = P1.m[Matrix3D::m01];
        P_13 = P1.m[Matrix3D::m02];P_14 = P1.m[Matrix3D::m03];
        P_21 = P1.m[Matrix3D::m10];P_22 = P1.m[Matrix3D::m11];
        P_23 = P1.m[Matrix3D::m12];P_24 = P1.m[Matrix3D::m13];
        P_31 = P1.m[Matrix3D::m20];P_32 = P1.m[Matrix3D::m21];
        P_33 = P1.m[Matrix3D::m22];P_34 = P1.m[Matrix3D::m23];
        P3_1 = P3.m[Matrix3D::m03];P3_2 = P3.m[Matrix3D::m13];P3_3 = P3.m[Matrix3D::m23];
    }
    
    return true;
}

void EquationSolver::SetActuator(Hexagon input)
{
    Actuator = input;
    IsActuatorReady = true;
}
    
void EquationSolver::SetPlatform(Hexagon input)
{
    Platform = input;
    IsPlatformReady = true;
}

Hexagon EquationSolver::GetActuator()
{
    return Actuator;
}
    
Hexagon EquationSolver::GetPlatform()
{
    return Platform;
}