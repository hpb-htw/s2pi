/**
 * @file
 *
 * Eine Sammlung von Hilfe-Funktionen und Strukturen für die gängige Zeichnungen in Darstellende Geometrie.
 */
 
 /**
  * This file depends on the asymptote base module three, which is distribute with asymptote in texlive
  */
private import three;

/** big point*/
pen bpp=linewidth(bp);


// common pens
/** Pen for mesasure line */
pen measureLine = linewidth(0.2mm) + gray;
/** Pen for mesasure label */
pen measureLabel = black;
/** Pen for outline contour */
pen outlineContour = linewidth(0.3mm) + black;
/** Pen for construction line */
pen construction = linewidth(0.15mm);
/** Pen for coorinate Axes axes  */
pen coordinateAxes = linewidth(0.3mm);


// common routines
/**
 * draws an open dot on picture. This function is only for internal use.
 */
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

/**
 * draws an open dot at a postion on a picture.
 
 * @param pic picture which receives the drawn open dot.
 * @param L label next to point
 * @param v position of the dot
 * @param align align of the label next to the dot
 * @param format format of the label text
 * @param p used to determine the background color (=Fill coloer of the dot)
 * @param light
 * @param name
 * @param render
 * 
 * 
 */
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


/**
 * draws the label X, Y, Z of coordinate axes and the origin O.
*/
void showCoordinate(string origin = "",align o=N, align x=NW, align y=N, align z=E) {
  if (origin == "") {
    origin = " ";
  }
  odot(origin, O, o);
  odot("$X$", X, x);
  odot("$Y$", Y, y);
  odot("$Z$", Z, z);
}

/**
 * maps a triple to other triple, result should be a new triple, the original triple should not be changed.
 */
typedef triple mapNode(triple);

/**
 * map a guide3 to other guide3.
 */
typedef guide3 mapGuide(guide3);


/** 
 * maps all nodes of a guide3 using give map function.
 * @param g guide3 to be mapped
 * @param fn Mapping rule must have signature `mapNode`;
 *
 * @return new guide3
 */
private guide3 mapNodes(guide3 g, mapNode fn)
{
    guide3 img;
    for(int i = 0; i < size(g); ++i) {
        img = img -- fn(point(g,i));
    }
    if( cyclic(g) ) {
        img = img -- cycle;
    }
    return img;
}

/**
 * maps each given guide to a new guide, using the given function.
 * @param g
 * @param fn
 *
 * @return new guide3
 */
private guide3[] mapGuides(guide3[] g, mapGuide fn) 
{
    guide3[] abb;
    for(guide3 subGuide : g) {
        abb.push( fn(subGuide) );
    }
    return abb;
}


/**
 * maps all nodes of the guide3 g to their projection on xy-plane
 *
 */
guide3 grundrissProjektion(guide3 g)
{
    return mapNodes(g, new triple(triple n) {
        return (n.x, n.y, 0);
    });    
}

guide3[] grundrissProjektion(guide3[] g)
{
    return mapGuides(g, grundrissProjektion);
}

/**
 * maps all nodes of the guide3 g to their projection on yz-plane
 *
 */
guide3 aufrissProjektion(guide3 g)
{
    return mapNodes(g, new triple(triple n) {
        return (0, n.y, n.z);
    });
}

guide3[] aufrissProjektion(guide3[] g)
{
    return mapGuides(g, aufrissProjektion);
}


/**
 * maps all nodes of the guide3 g to their projection on xz-plane
 *
 */
guide3 seitenrissProjektion(guide3 g)
{
    return mapNodes(g, new triple(triple n) {
        return (n.x, 0, n.z);
    });
}

guide3[] seitenrissProjektion(guide3[] g)
{
    return mapGuides(g, seitenrissProjektion);
}

/**
 * represents distance measurement in 3D.
 */
struct ThreeDistance {

    /** 
     * start point 
     */
    triple startPoint;
    
    /**
     * end point 
     */
    triple stopPoint;
    
    /** 
     * normal vector 
     */
    triple normal;
    
    /** 
     * distence from measurement line to line `startPoint -- stopPoint`
     */
    real distance;
    
    /** 
    * factor of distance from measure line to (startPoint -- stopPoint), 
    * used to calculate the length of measure Lateral 
    */
    real extend;
    
    /** 
     * label 
     */
    Label l;
    
    /** 
     * label position along the measurement line (from 0 to 1) 
     */
    real labelPosition;
    
    /** 
     * ggggg
     */
    triple direction;
    
    /**
    * m1 and m2 are two endpoints of the measure arrow; `(m1 -- m2)` is paralle to `(startPoint -- stopPoint)`.
    * Both `(startPoint -- m1)` and `(stopPoint -- m2)` are perpendicular to `(startPoint -- stopPoint)`;
    * 
    */
    triple m1;
    
    /**
     * @see m1
     */
    triple m2;
    
    /**
    * extension of `(startPoint -- m1)`.
    */    
    triple firstMark;
    
    /**
    * extension of `(endPoint -- m2)`.
    */
    triple secondMark;
    
    /**
     * create an instance of ThreeMark, but not shows it on the drawing.
     */
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
        
        this.direction = this.distance * unit( cross( this.stopPoint - this.startPoint, this.normal ) );
        this.m1 = this.startPoint + direction;
        this.m2 = this.stopPoint + direction;    
        triple extend = this.extend * direction;
        this.firstMark = this.startPoint + extend;
        this.secondMark = this.stopPoint + extend;    
    }
    
    /**
     * draws this ThreeMark on a picture.
     */
    void draw(picture pic=currentpicture, pen linep = measureLine, pen labelp = measureLabel){
        path3 messung = this.m1 -- this.m2;
        triple labelP = interp(this.m1, this.m2, this.labelPosition);        
        label( this.l, labelP );
        
        draw(pic = pic, messung, p=linep, arrow = Arrows3(HookHead2(normal=this.normal), emissive(linep)) );
        draw(pic = pic, this.startPoint -- this.firstMark, p=linep);
        draw(pic = pic, this.stopPoint -- this.secondMark, p=linep);
    }
    
}; //




/**
 *
 * represents outlines of a figure.
 */
struct ContourCurve {

    /**
    * curve to be drawn.
    */
    guide3 curve;
    
    /**
    * fragments on the curve, which have background.
    */
    pair[] offset;
    
    /**
    * factor (>1.0) to expand the with of background cuve.
    */
    real width;

    
    /**
     * creates a curve with given offset of each segment of the curve.
     */
    void operator init(guide3 curve, pair[] offset = {}, real width=1) {
        this.curve = curve;
        this.offset = offset;
        this.width = width;
    }
    
     /**
     * creates a curve with given offset of each segment of the curve.
     */
    void operator init(guide3 curve, real offsetStart, real offsetStop, real width=1) {
        this.curve = curve;
        pair offset = (offsetStart, offsetStop);
        this.offset.push( offset );
        this.width = width;
    }
    
    /**
     * creates a curve with given offset of each segment of the curve.
     */
    void operator init(guide3 curve, pair offset, real width=1) {
        this.curve = curve;        
        this.offset.push( offset );
        this.width = width;
    }
    
    /**
     * draw the curve as regular curve
     */
    void draw(
        pen        corePen = outlineContour,
        real arrowPosition = -1
    ) {
        if (arrowPosition >= 0) {
            arrowbar3 arrow = Arrow3(DefaultHead2(normal=Z), position=arrowPosition);
            draw(this.curve, arrow=arrow, p = corePen);
        }else {
            draw(this.curve, p = corePen);
        }
    }
    
    /**
     * draws the curve as if it is over others lines
     */
    void drawFront(        
        pen         corePen = outlineContour,
        light       light   = currentlight,
        real  arrowPosition = -1
    ) {
        pen fillpen = light.background;  
        if (invisible(fillpen)) fillpen = light.background;
        if (invisible(fillpen)) fillpen = white;
        pen bg = (width * linewidth(corePen)) + fillpen;
        
        for(pair o : offset){
            guide3 overPath = subpath(this.curve, o.x, o.y);
            draw(overPath, p = bg);
        }
        
        this.draw(corePen, arrowPosition);
    }    
};



























