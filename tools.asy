private import three;

void odot(picture pic=currentpicture, triple v, material p=currentpen,
         light light=nolight, string name="", render render=defaultrender)
{
  pen q=(pen) p;
  pen fillpen = light.background;  
  if (invisible(fillpen)) fillpen = currentlight.background;
  if (invisible(fillpen)) fillpen = white;
  
  real size=0.5*linewidth(dotsize(q)+q);
  pic.add(new void(frame f, transform3 t, picture pic, projection P) {
      triple V=t*v;
      assert(!is3D(), "odot() not supported unless settings.prc == false and settings.render != 0");
      if(pic != null)
        dot(pic,project(V,P.t),filltype=FillDraw(fillpen=fillpen, drawpen=q));
    },true);
  triple R=size*(1,1,1);
  pic.addBox(v,v,-R,R);
}

void odot(picture pic=currentpicture, Label L, triple v, align align=NoAlign,
             string format=defaultformat, material p=currentpen,
             light light=nolight, string name="", render render=defaultrender)
{
  Label L=L.copy();
  if(L.s == "") {
    if(format == "") format=defaultformat;
    L.s="("+format(format,v.x)+","+format(format,v.y)+","+
      format(format,v.z)+")";
  }
  L.align(align,E);
  L.p((pen) p);
  odot(pic,v,p,light,name,render);
  label(pic,L,v,render);
}


void showCoordinate() {
  odot(" ", O, N);
  odot("$X$", X, NW);
  odot("$Y$", Y, N);
  odot("$Z$", Z, E);
}