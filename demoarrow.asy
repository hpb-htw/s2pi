settings.tex="pdflatex";
settings.outformat="pdf";
settings.prc = false;
settings.render = 0;

import geometry;
import three;
//currentprojection = orthographic((4, 1.5, 1));
currentprojection = obliqueX;
texpreamble("\input{shortcut.tex}");

import tools;

unitsize(2.5cm);

pen bpp=linewidth(bp);

var defaultArrow = Arrow3(DefaultHead2);

draw(O--4X, arrow=defaultArrow, blue); //x-axis
draw(O--3Y, arrow=defaultArrow, green); //y-axis
draw(O--3Z, arrow=defaultArrow, red); //z-axis

triple P = (2,1.5,2);
triple Pnd = (P.x, 0, 0);


var m1 = (Pnd.x, -0.5, 0),
    m2 = (0,    -0.5, 0);

draw(m1 -- m2, L = Label("$x$",  align=NW), arrow = Arrows3(DefaultHead2(normal=Z), emissive(black)) );
//draw(m1 -- m2, L = Label("$x$",  align=NW), arrow = Arrows3(TeXHead2(normal=Z), emissive(black)) );

var firstMark = interp(O, m2, 1.25);
draw(O -- firstMark, gray);
var secondMark = interp(Pnd, m1, 1.25);
draw(Pnd -- secondMark, gray);

draw(O -- (1,1,1), arrow=Arrow3(DefaultHead2(normal=Z)), p=gray(0.6), light=currentlight);

showCoordinate();


