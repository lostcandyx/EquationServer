#include "Hexagon.h"
#include "Matrix.h"

Hexagon::Hexagon(double x,double y,double z,double a,double r)
{
    Center.X = x;
    Center.Y = y;
    Center.Z = z;
    Radius = r;
    Angle = a;

    ComputeVertex();
}

Hexagon::Hexagon(Point3D x,double a,double r)
{
    Center = x;
    Radius = r;
    Angle = a;

    ComputeVertex();
}

Hexagon::~Hexagon()
{
}

void Hexagon::ComputeVertex()
{
    Vertex[0] = 
}