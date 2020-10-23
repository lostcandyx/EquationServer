#include "Hexagon.h"

Hexagon::Hexagon(double x, double y, double z, double a, double r)
{
    Center.X = x;
    Center.Y = y;
    Center.Z = z;
    Radius = r;
    Angle = a;

    ComputeVertex();
}

Hexagon::Hexagon(Point3D x, double a, double r)
{
    Center = x;
    Radius = r;
    Angle = a;

    ComputeVertex();
}

Hexagon::Hexagon()
{
    Center.X = 0;
    Center.Y = 0;
    Center.Z = 0;
    Radius = 0;
    Angle = 0;

    ComputeVertex();
}

Hexagon::~Hexagon()
{
}

void Hexagon::ComputeVertex()
{
    Vertex[0] = Center;
}