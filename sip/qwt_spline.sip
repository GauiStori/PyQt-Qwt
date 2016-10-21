/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtSpline
{
%TypeHeaderCode
#include <qwt_spline.h>
%End

public:
    //! Spline type
    enum SplineType
    {
        //! A natural spline
        Natural,

        //! A periodic spline
        Periodic
    };

    QwtSpline();
    QwtSpline( const QwtSpline & );

    ~QwtSpline();

    //QwtSpline &operator=( const QwtSpline & );

    void setSplineType( SplineType );
    SplineType splineType() const;

    bool setPoints( const QPolygonF& points );
    QPolygonF points() const;

    void reset();

    bool isValid() const;
    double value( double x ) const;

    const QVector<double> &coefficientsA() const;
    const QVector<double> &coefficientsB() const;
    const QVector<double> &coefficientsC() const;

protected:
    bool buildNaturalSpline( const QPolygonF & );
    bool buildPeriodicSpline( const QPolygonF & );

};
