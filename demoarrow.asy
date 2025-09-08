import globalsetting;

import three;
import tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};



unitsize(2.5cm);




var defaultArrow = Arrow3(DefaultHead2);

draw(O--4X, arrow=defaultArrow, blue); //x-axis
draw(O--3Y, arrow=defaultArrow, green); //y-axis
draw(O--3Z, arrow=defaultArrow, red); //z-axis

triple P = (2,1.5,2);
triple Pnd = (P.x, 0, 0);


var m1 = (Pnd.x, -0.5, 0),
    m2 = (0,    -0.5, 0);

path3 messung = m1 -- m2;

label(Label("$2x$",  align=NW), midpoint(messung) );
draw(messung, p=gray, arrow = Arrows3(HookHead2(normal=Z), emissive(gray)) );
//draw(messung, p=gray, arrow = Arrows3(DefaultHead2(normal=Z), emissive(gray)) );
//draw(messung, p=gray, arrow = Arrows3(TeXHead2(normal=Z), emissive(gray)) );

var firstMark = interp(O, m2, 1.25);
draw(O -- firstMark, gray);
var secondMark = interp(Pnd, m1, 1.25);
draw(Pnd -- secondMark, gray);

draw(O -- (1,1,1), arrow=Arrow3(DefaultHead2(normal=Z)), p=gray, light=currentlight);



showCoordinate();



