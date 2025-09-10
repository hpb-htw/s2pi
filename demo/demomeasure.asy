import globalsetting;

import three;
import tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};


unitsize(2.5cm);

arrowbar3 defaultArrow = Arrow3(DefaultHead2);



draw(O--4X, arrow=defaultArrow, p = coordinateAxes + blue); //x-axis
draw(O--3Y, arrow=defaultArrow, p = coordinateAxes + green); //y-axis
draw(O--3Z, arrow=defaultArrow, p = coordinateAxes + red); //z-axis


draw(O -- (1,1,1), arrow=Arrow3(DefaultHead2(normal=Z)), p=gray, light=currentlight);


triple startAt = (0, 0, 0),
       stopAt = (1, 0, 0), 
       normal = Z;
       
real distance = 0.5,
     extend = 1.25; 
     
Label ml = Label("$x$", align=NW);

real labelPosition = 0.5;


ThreeDistance td = ThreeDistance(startAt, stopAt, distance, extend, normal=Z, Label("$x$",  align=NW), labelPosition);
td.draw();

showCoordinate();
