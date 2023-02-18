/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtScaleDraw: public QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_scale_draw.h>
%End
public:
    /*!
        Alignment of the scale draw
        \sa setAlignment(), alignment()
     */
    enum Alignment 
    { 
        //! The scale is below
        BottomScale, 

        //! The scale is above
        TopScale, 

        //! The scale is left
        LeftScale, 

        //! The scale is right
        RightScale 
    };

    QwtScaleDraw();
    virtual ~QwtScaleDraw();

    void getBorderDistHint( const QFont &, int &start, int &end ) const;
    int minLabelDist( const QFont & ) const;

    int minLength( const QFont & ) const;
    virtual double extent( const QFont & ) const;

    void move( double x, double y );
    //void move( const QPointF & );
    void setLength( double length );

    Alignment alignment() const;
    void setAlignment( Alignment );

    Qt::Orientation orientation() const;

    QPointF pos() const;
    double length() const;

    void setLabelAlignment( Qt::Alignment );
    Qt::Alignment labelAlignment() const;

    void setLabelRotation( double rotation );
    double labelRotation() const;

    int maxLabelHeight( const QFont & ) const;
    int maxLabelWidth( const QFont & ) const;

    QPointF labelPosition( double val ) const;

    QRectF labelRect( const QFont &, double val ) const;
    QSizeF labelSize( const QFont &, double val ) const;

    QRect boundingLabelRect( const QFont &, double val ) const;

protected:
    QTransform labelTransformation( const QPointF &, const QSizeF & ) const;

    virtual void drawTick( QPainter *, double val, double len ) const;
    virtual void drawBackbone( QPainter * ) const;
    virtual void drawLabel( QPainter *, double val ) const;

private:
    QwtScaleDraw( const QwtScaleDraw & );
    //QwtScaleDraw &operator=( const QwtScaleDraw &other );

    /*void updateMap();

    class PrivateData;
    PrivateData *d_data;*/
};

