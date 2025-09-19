/**
 * @file
 */


import geometry;

/**
 * bildet ein Zeichenbrett mit 3 Ebene Grundriss, Ordnungsriss, Seitenriss ab.
 *
 */
struct Plana {

    coorsys gnd;
    coorsys auf;
    coorsys stn;

    /**
     * @param vdistance vetikale Distanz zwischen Grundriss und Aufriss
     * @param hdistance Horizontal distance ziwschen Setenriss und Aufriss
     */
    void init(real vdistance=1, real hdistance=vdistance) {
        this.auf = cartesiansystem(
            (0, 0), i = (1, 0), j = (0, 1)
        );
        this.gnd = cartesiansystem(
            (0, -vdistance), i = (0, 1), j = (1, 0)
        );
    }

    void plotEbene() {
        show(auf);
        show(gnd);
    }

};
