import globalsetting;

import three;
import tools;

real cDistance = 3;
real cAltitute = 12; // degree
real cAzimuth = 25; // degree
real theta = (90 - cAltitute)/180 * pi;
real phi = cAzimuth/180 * pi;
triple camera = cDistance * expi(theta, phi);
currentprojection = orthographic(camera);

texpreamble("\input{shortcut.tex}");
DefaultHead.size = new real(pen p=currentpen) {return 1mm;};
HookHead.size = new real(pen p=currentpen) {return 0.5mm;};


unitsize(2.5cm);

arrowbar3 defaultArrow = Arrow3(DefaultHead2);



draw(-1.5X -- 4X,   L=Label("$x$",position=EndPoint,align=SE), arrow=defaultArrow, p = coordinateAxes + blue); //x-axis
draw(-Y -- 3Y,   L=Label("$y$",position=EndPoint,align=NW), arrow=defaultArrow, p = coordinateAxes + green); //y-axis
draw(-.5Z -- 3Z, L=Label("$y$",position=EndPoint,align=SE), arrow=defaultArrow, p = coordinateAxes + red); //z-axis



triple P = (1, 1, 1);
triple Pgnd = (P.x, P.y, 0);
triple Pauf = (0  , P.y, P.z);
triple Pstn = (P.x, 0  , P.z);

guide3 backside = O -- Z -- Pauf -- Y -- cycle;
ContourCurve backCurve = ContourCurve(backside);
backCurve.draw();

guide3[] roundSide1 = O -- X ^^ Z -- Pstn ^^ Pauf -- P ^^ Y -- Pgnd;
for(guide3 p : roundSide1){
    ContourCurve sideCurve = ContourCurve(p);
    sideCurve.draw();
}

guide3 frontside = X -- Pstn -- P -- Pgnd -- cycle;
pair[] offset = { 
       (0.1, 0.5)
     , (1.1, 1.5)
     , (2.1, 2.9)
     , (3.5, 3.9) 
};
ContourCurve frontCurve = ContourCurve(frontside, offset , width=4);
frontCurve.drawFront();

string l = "{$\scriptstyle 1$}";
label(l, position=0.65*X, align=N);
label(l, position=0.40*Y, align=S);
label(l, position=0.5*Z, align=E);

showCoordinate(origin="$O$", o= NW, x=S, y=NE, z=NE);
