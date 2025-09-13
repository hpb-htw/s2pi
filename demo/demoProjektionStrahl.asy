import globalsetting;

import three;
import "../tools.asy" as tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};



unitsize(2.5cm);




var defaultArrow = Arrow3(DefaultHead2);

draw(O--4X, arrow=defaultArrow, blue); //x-axis
draw(O--3Y, arrow=defaultArrow, green); //y-axis
draw(O--3Z, arrow=defaultArrow, red); //z-axis

triple P = (2, 1.5, 0);
ProjektionStrahl s1 = ProjektionStrahl(P, aufriss);
s1.draw(arrowPosition=0.8);

triple Q = (2, 1.5, 3);
ProjektionStrahl s2 = ProjektionStrahl(Q, grundriss);
s2.draw(arrowPosition=0.2);

showCoordinate();



