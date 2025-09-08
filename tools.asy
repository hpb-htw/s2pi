private import three;

/** big point*/
pen bpp=linewidth(bp);


/* common pens */
pen measureLine = linewidth(0.2mm) + gray;
pen measureLabel = black;

pen coordinateAxes = linewidth(0.4mm);

/* common routines */
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
      //assert(!is3D(), "odot() not supported unless settings.prc == false and settings.render != 0");
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


/**
 * 
 */
struct ThreeDistance {
    /** start point */
    triple startPoint;
    /** end point */
    triple stopPoint;
    
    /** normal vector */
    triple normal;
    /** distence from measurement line to line startPoint -- stopPoint */
    real distance;
    
    /** 
    * factor of distance from measure line to (startPoint -- stopPoint), 
    * used to calculate the length of measure Lateral 
    */
    real extend;
    
    /** label */
    Label l;
    /** label position along the measurement line (from 0 to 1) */
    real labelPosition;
    
    // derivate members
    triple direction;
    /**
    * m1 and m2 are two endpoints of the measure arrow; (m1 -- m2) is paralle to (startPoint -- stopPoint).
    * Both (startPoint -- m1) and (stopPoint -- m2) are perpendicular to (startPoint -- stopPoint);
    * 
    */
    triple m1;
    triple m2;
    /**
    * extension of (startPoint -- m1).
    */
    triple firstMark;
    /**
    * extension of (endPoint -- m2).
    */
    triple secondMark;
    
    /** internal constructor, DONOT use this. use `newThreeDistance()` */
    void operator init(
            triple startPoint, 
            triple stopPoint, 
            real distance, 
            real extend, 
            triple normal = Z, 
            Label l, 
            real labelPosition = 0.5
    ) {
        this.startPoint = startPoint;
        this.stopPoint = stopPoint;
        this.normal = normal;
        this.distance = distance;
        this.extend = extend;
        this.l = l;
        this.labelPosition = labelPosition;
        // calculate Derivate Points
        this.direction = this.distance * unit( cross( this.stopPoint - this.startPoint, this.normal ) );
        this.m1 = this.startPoint + direction;
        this.m2 = this.stopPoint + direction;    
        triple extend = this.extend * direction;
        this.firstMark = this.startPoint + extend;
        this.secondMark = this.stopPoint + extend;    
    }
    
    void draw(pen linep = measureLine, pen labelp = currentpen){
        path3 messung = this.m1 -- this.m2;
        triple labelP = interp(this.m2, this.m1, this.labelPosition);        
        label( this.l, labelP );
        
        draw(messung, p=linep, arrow = Arrows3(HookHead2(normal=this.normal), emissive(linep)) );
        draw(this.startPoint -- this.firstMark, p=linep);
        draw(this.stopPoint -- this.secondMark, p=linep);
    }
    
}





























