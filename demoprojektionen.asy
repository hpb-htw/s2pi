import globalsetting;

import three;
import tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");

import tools;

guide3[] curve = (0, 0, 0) -- (0, 1, 1) ^^ (1, 1, 1) -- (1, 1, 0) -- cycle ;

guide3[] curveGnd = grundrissProjekt(curve);

guide3 simple = (0,0,0) -- (0, 2, 1) .. (1, 3, 1);
guide3 xxx = grundrissProjekt(simple);
write(xxx);

//write( seitenRissProjekt(curve) );
//write( aufRissProjekt(curve) );
