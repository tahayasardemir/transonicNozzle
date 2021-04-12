axial_gridsize=1/100;
radial_gridsize=0.3338/100;
// Nozzle Wall Points
Point(1) = {0,0.3338,0,radial_gridsize};
Point(2) = {0.1,0.29,0,radial_gridsize};
Point(3) = {0.2,0.25,0,radial_gridsize};
Point(4) = {0.3,0.21,0,radial_gridsize};
Point(5) = {0.4,0.19,0,radial_gridsize};
Point(6) = {0.5,0.18,0,radial_gridsize};
Point(7) = {0.6,0.19,0,radial_gridsize};
Point(8) = {0.7,0.21,0,radial_gridsize};
Point(9) = {0.8,0.25,0,radial_gridsize};
Point(10)= {0.9,0.29,0,radial_gridsize};
Point(11)= {1,0.3338,0,radial_gridsize};
// Axis
Point(12)= {1,0,0,axial_gridsize};
Point(13)= {0,0,0,axial_gridsize};

BSpline(14)= {1,2,3,4,5,6,7,8,9,10,11}; //wall
Line(15)  = {11,12}; //outlet
Line(16)  = {12,13}; //axis
Line(17)  = {13,1}; //inlet

Line Loop(18) = {14,15,16,17};

Plane Surface(19) = {18};

Transfinite Line{14,16} = 101; // This Transfinite command makes the mesh structured
//Transfinite Line{15,17} = 101 Using Progression 1;
Transfinite Line{15} = 51 Using Progression 10/9;
Transfinite Line{17} = 51 Using Progression 0.9;
Transfinite Surface{19};
Recombine Surface{19}; // Recombine is necessary othervise mesh would still be divided into triangles

Rotate {{1,0,0},{0,0,0},2.5*Pi/180.0}
{
	Surface{19};
}

new_entities[] = Extrude {{1,0,0},{0,0,0},-5*Pi/180.0}
{
	Surface{19};
	Layers{1};
	Recombine;
};

Physical Surface("front") = {19};
Physical Surface("back")  = {new_entities[0]};
Physical Surface("wall")= {new_entities[2]};
Physical Surface("outlet")  = {new_entities[3]};
Physical Surface("inlet") = {new_entities[4]};

Physical Volume (1000) = {new_entities[1]};
