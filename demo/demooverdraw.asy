import globalsetting;

import three;
import "../spatium.asy" as tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};


unitsize(2.5cm);

arrowbar3 defaultArrow = Arrow3(DefaultHead2);



draw(O--4X, arrow=defaultArrow, p = coordinateAxes + blue); //x-axis
draw(O--3Y, arrow=defaultArrow, p = coordinateAxes + green); //y-axis
draw(O--3Z, arrow=defaultArrow, p = coordinateAxes + red); //z-axis


path3 line1 = O -- (1,1,0);
draw(line1);

guide3 line2 = X -- Y;
ContourCurve c1 = ContourCurve(line2, 0.15, 0.85, width=4);
c1.drawFront();

draw(O -- (1,1,1), arrow=Arrow3(DefaultHead2(normal=Z)), p=gray, light=currentlight);

guide3 line3 = O .. (1.5, 1, 1)  .. (3, 2, 0); 
pair offset = (0.1, 1.9);
ContourCurve c3 = ContourCurve(line3, offset, width=4);

c3.drawFront(arrowPosition = 1.5);


showCoordinate();
