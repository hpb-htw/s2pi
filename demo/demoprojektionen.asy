import globalsetting;

import three;
import "../spatium.asy" as tools;

currentprojection = orthographic((4, 1.5, 1));
texpreamble("\input{shortcut.tex}");
unitsize(2.5cm);

guide3[] curve = (0, 0, 0) -- (0, 1, 1) ^^ (1, 1, 1) -- (1, 1, 0) -- cycle ;

guide3[] curveGnd = grundrissProjektion(curve);

guide3 simple = (0,0,0) -- (0, 2, 1) .. (1, 3, 1);
guide3 xxx = grundrissProjektion(simple);

draw(simple,p=construction);
draw(xxx, p=construction);

