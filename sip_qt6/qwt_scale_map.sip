/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtScaleMap
{
%TypeHeaderCode
#include <qwt_scale_map.h>
%End
public:
    QwtScaleMap();
    QwtScaleMap( const QwtScaleMap& );

    ~QwtScaleMap();

    //QwtScaleMap &operator=( const QwtScaleMap & );

    //void setTransformation( QwtTransform * );
    //const QwtTransform *transformation() const;

    void setPaintInterval( double p1, double p2 );
    void setScaleInterval( double s1, double s2 );

    double transform( double s ) const;
    double invTransform( double p ) const;

    double p1() const;
    double p2() const;

    double s1() const;
    double s2() const;

    double pDist() const;
    double sDist() const;

    static QRectF transform( const QwtScaleMap &,
        const QwtScaleMap &, const QRectF & );
    static QRectF invTransform( const QwtScaleMap &,
        const QwtScaleMap &, const QRectF & );

    static QPointF transform( const QwtScaleMap &,
        const QwtScaleMap &, const QPointF & );
    static QPointF invTransform( const QwtScaleMap &,
        const QwtScaleMap &, const QPointF & );

    bool isInverting() const;

/*private:
    void updateFactor();

    double d_s1, d_s2;     // scale interval boundaries
    double d_p1, d_p2;     // paint device interval boundaries

    double d_cnv;       // conversion factor
    double d_ts1;

    QwtTransform *d_transform;*/
};
