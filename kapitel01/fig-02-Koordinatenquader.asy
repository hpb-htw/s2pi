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



draw(O -- 4X,   L=Label("$x$",position=EndPoint,align=SE), arrow=defaultArrow, p = coordinateAxes + blue); //x-axis
draw(-Y -- 3Y,   L=Label("$y$",position=EndPoint,align=NW), arrow=defaultArrow, p = coordinateAxes + green); //y-axis
draw(O -- 3Z, L=Label("$y$",position=EndPoint,align=SE), arrow=defaultArrow, p = coordinateAxes + red); //z-axis



triple P = (2, 1.5, 2);
triple Pgnd = (P.x, P.y, 0);
triple Pauf = (0  , P.y, P.z);
triple Pstn = (P.x, 0  , P.z);
triple P1 = (P.x, 0,  0);
triple P2 = (0,  P.y, 0);
triple P3 = (0,  0  , P.z);

// Bemassung

ThreeDistance xDistance = ThreeDistance(O, P1, 0.5, 1.1, Label("$x$", align=N), 0.6 );
xDistance.draw();
label("$y$", interp(P1,Pgnd,0.5), S);
label("$y$", interp(P3,Pauf,0.5), N);
label("$z$", interp(P, Pgnd,0.5), E);


guide3 backside = O -- P3 -- Pauf -- P2 -- cycle;
ContourCurve backCurve = ContourCurve(backside);
backCurve.draw();

guide3[] roundSide1 = O -- P1 ^^ P3 -- Pstn ^^ Pauf -- P ^^ P2 -- Pgnd;
for(guide3 p : roundSide1){
    ContourCurve sideCurve = ContourCurve(p);
    sideCurve.draw();
}

guide3 frontside = P1 -- Pstn -- P -- Pgnd -- cycle;
pair[] offset = { 
       (0.1, 0.5)
     , (1.3, 1.8)
     , (2.1, 2.9)
     , (3.5, 3.9) 
};
ContourCurve frontCurve = ContourCurve(frontside, offset , width=4);
frontCurve.drawFront();

label("$P_1$",  P1,   align=S);
label("$P_2$",  P2,   align=S);
label("$P_3$",  P3,   align=NE);

odot("$\lgnd{P}$", Pgnd, align=S);
odot("$\lauf{P}$", Pauf, align=NE);
odot("$\lstn{P}$", Pstn, align=NW);

dot("$P$", P, N);


showCoordinate(origin="", o= NW, x=S, y=NE, z=NE);




