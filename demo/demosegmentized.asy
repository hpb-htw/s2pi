import globalsetting;

import three;
import "../spatium.asy" as tools;

currentprojection = orthographic((4, 2.5, 1));

texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};

unitsize(2.5cm);

var defaultArrow = Arrow3(DefaultHead2);

draw(O--4X, arrow=defaultArrow, blue); //x-axis
draw(O--3Y, arrow=defaultArrow, green); //y-axis
draw(O--3Z, arrow=defaultArrow, red); //z-axis

int slength = 10;
triple startPoint = (0, 0, 1);
triple stopPoint = (0, slength, 1);
pair[] segments = {
     (0.2, 0.5),
     (0.6, 0.8),
     (0.9, 1)
};

SegmentedStrahl strahl = SegmentedStrahl(startPoint, stopPoint, segments);
strahl.draw();

for(int i = 0; i <= slength; ++i) {
     dot((0, i, 1));
}

triple P = (2, 2, 3.5);
ProjektionStrahl(P, abszisse, segments).draw(arrowPosition=0.8);
