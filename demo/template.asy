import globalsetting;

import three;
import "../tools.asy" as tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");

unitsize(2.5cm);

pen bpp=linewidth(bp);

var defaultArrow = Arrow3(DefaultHead2);

draw(O--4X, arrow=defaultArrow, blue); //x-axis
draw(O--3Y, arrow=defaultArrow, green); //y-axis
draw(O--3Z, arrow=defaultArrow, red); //z-axis


triple P = (2,1.5,2);
var quader = three.box(O, P);

draw(quader, bpp);
dot("$P$",  P, dir(100));
label("$P_1$", (P.x, 0, 0), S);
label("$P_2$", (0, P.y, 0), S);
label("$P_3$", (0, 0, P.z), NE);

triple P1 = (P.x, P.y, 0);
odot("$P^{\pst}$", P1, SE);
odot("$P^{\pnd}$", (0, P.y, P.z), NE);
odot("$P^{\prd}$", (P.x, 0, P.z), NW);

/*
var m1 = (P1.x, -0.5, 0),
    m2 = (0,    -0.5, 0);

draw(m1 -- m2, L = Label("$x$",  align=NW), Arrows3);
*/

showCoordinate();


