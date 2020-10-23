classdef Hexagon
    properties
        angle;
        radius;
        P;
        O;
        color;
    end
    
    methods
        function self = Hexagon(O,angle,radius,color)
            self.angle = angle;
            self.radius = radius;
            self.color = color;
            self.O = O;
             
            P1 = (self.O)*Rot(0,0,self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            P2 = (self.O)*Rot(0,0,-self.angle)*Trans(self.radius,0,0)*Rot(0,0,self.angle);
            P3 = (self.O)*Rot(0,0,-pi*2/3+self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            P4= (self.O)*Rot(0,0,-pi*2/3-self.angle)*Trans(self.radius,0,0)*Rot(0,0,self.angle);
            P5 = (self.O)*Rot(0,0,pi*2/3+self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            P6 = (self.O)*Rot(0,0,pi*2/3-self.angle)*Trans(self.radius,0,0)*Rot(0,0,+self.angle);
            
            self.P = {P1;P2;P3;P4;P5;P6};
        end
        
        function self = set.O(self,New)
            self.O = New;
            
            self.P{1} = (self.O)*Rot(0,0,self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            self.P{2} = (self.O)*Rot(0,0,-self.angle)*Trans(self.radius,0,0)*Rot(0,0,self.angle);
            self.P{3} = (self.O)*Rot(0,0,-pi*2/3+self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            self.P{4} = (self.O)*Rot(0,0,-pi*2/3-self.angle)*Trans(self.radius,0,0)*Rot(0,0,self.angle);
            self.P{5} = (self.O)*Rot(0,0,pi*2/3+self.angle)*Trans(self.radius,0,0)*Rot(0,0,-self.angle);
            self.P{6} = (self.O)*Rot(0,0,pi*2/3-self.angle)*Trans(self.radius,0,0)*Rot(0,0,self.angle);
        end
        
        function result=get.P(self)
            result=self.P;
        end
            
        function self = set.P(self,New)
            self.P = New;
        end
        
    end
end