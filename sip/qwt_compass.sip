/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2018   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

//class QwtCompassRose;

/*!
  \brief A special scale draw made for QwtCompass

  QwtCompassScaleDraw maps values to strings using
  a special map, that can be modified by the application

  The default map consists of the labels N, NE, E, SE, S, SW, W, NW.

  \sa QwtCompass
*/


class QwtCompassScaleDraw: QwtRoundScaleDraw
{
%TypeHeaderCode
#include <qwt_compass.h>
%End
public:
    explicit QwtCompassScaleDraw();
    explicit QwtCompassScaleDraw( const QMap<double, QString> &map );

    void setLabelMap( const QMap<double, QString> &map );
    QMap<double, QString> labelMap() const;

    virtual QwtText label( double value ) const;

//private:
//    QMap<double, QString> d_labelMap;
};

/*!
  \brief A Compass Widget

  QwtCompass is a widget to display and enter directions. It consists
  of a scale, an optional needle and rose.

  \image html dials1.png

  \note The examples/dials example shows how to use QwtCompass.
*/

class QwtCompass: QwtDial
{
%TypeHeaderCode
#include <qwt_compass.h>
%End
public:
    explicit QwtCompass( QWidget* parent /TransferThis/ = NULL );
    virtual ~QwtCompass();

    void setRose( QwtCompassRose *rose /Transfer/);
    //const QwtCompassRose *rose() const;
    QwtCompassRose *rose();

protected:
    virtual void drawRose( QPainter *, const QPointF &center,
        double radius, double north, QPalette::ColorGroup ) const;

    virtual void drawScaleContents( QPainter *,
        const QPointF &center, double radius ) const;

    virtual void keyPressEvent( QKeyEvent * );

//private:
//    class PrivateData;
//    PrivateData *d_data;
};
