#include "demo.h"

int main(int argc, char const *argv[])
{
    Point3D Origin(0,0,0);
    Hexagon *Actuator = new Hexagon(Origin,PI/6,10);
    
    for (int i = 0;i < 6;i++)
    {
        Actuator->GetVertexPoint(i).Print();
    }
    return 0;

    Matrix3D A,B;
    A.SetOnlyMove(Point3D(10,0,0));
    A.Print();
    B.SetOnlyRotate(Point3D(0,0,PI/6));
    B.Print();
    (A*B).Print();
}

/*
g++ -o demo ./src/demo.cpp -I ".\include\" -I ".\src\"
*/