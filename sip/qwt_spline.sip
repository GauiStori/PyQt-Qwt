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

    enum BoundaryType
    {
        ConditionalBoundaries,
        PeriodicPolygon,
        ClosedPolygon
    };

    enum BoundaryPosition
    {
        AtBeginning,
        AtEnd
    };

    enum BoundaryCondition
    {
        Clamped1,
        Clamped2,
        Clamped3,
        LinearRunout
    };

    QwtSpline();
    virtual ~QwtSpline();

    void setParametrization( int type );
    //void setParametrization( QwtSplineParametrization* );
    //const QwtSplineParametrization* parametrization() const;

    void setBoundaryType( BoundaryType );
    BoundaryType boundaryType() const;

    void setBoundaryValue( BoundaryPosition, double value );
    double boundaryValue( BoundaryPosition ) const;

    void setBoundaryCondition( BoundaryPosition, int condition );
    int boundaryCondition( BoundaryPosition ) const;

    void setBoundaryConditions( int condition,
        double valueBegin = 0.0, double valueEnd = 0.0 );

    virtual QPolygonF polygon( const QPolygonF&, double tolerance ) const;
    virtual QPainterPath painterPath( const QPolygonF& ) const = 0;

    virtual uint locality() const;

private:
    QwtSpline( const QwtSpline & );
};
