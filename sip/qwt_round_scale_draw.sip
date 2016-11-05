/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtRoundScaleDraw: QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_round_scale_draw.h>
%End
public:
    QwtRoundScaleDraw();
    virtual ~QwtRoundScaleDraw();

    void setRadius( double radius );
    double radius() const;

    void moveCenter( double x, double y );
    void moveCenter( const QPointF & );
    QPointF center() const;

    void setAngleRange( double angle1, double angle2 );

    virtual double extent( const QFont & ) const;

protected:
    virtual void drawTick( QPainter *, double val, double len ) const;
    virtual void drawBackbone( QPainter * ) const;
    virtual void drawLabel( QPainter *, double val ) const;

private:
    QwtRoundScaleDraw( const QwtRoundScaleDraw & );
    /*QwtRoundScaleDraw &operator=( const QwtRoundScaleDraw &other );

    class PrivateData;
    PrivateData *d_data;*/
};
