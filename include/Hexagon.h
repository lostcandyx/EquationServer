#include "Point.h"

class Hexagon
{
private:
    Point3D Center;
    Point3D Vertex[6];
    double Radius;
    double Angle;
public:
    Hexagon(Point3D center,double a,double r);
    Hexagon(double x,double y,double z,double a,double r);
    ~Hexagon();

    void ComputeVertex();
};


