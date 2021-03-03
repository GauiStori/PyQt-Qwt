/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief A plot item, which displays a zone

  A horizontal zone highlights an interval of the y axis - a vertical
  zone an interval of the x axis - and is unbounded in the opposite direction.
  It is filled with a brush and its border lines are optionally displayed with a pen.

  \note For displaying an area that is bounded for x and y coordinates
        use QwtPlotShapeItem
*/

class QwtPlotZoneItem:
    public QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_zoneitem.h>
%End
public:
    explicit QwtPlotZoneItem();
    virtual ~QwtPlotZoneItem();

    virtual int rtti() const;

    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation();

    void setInterval( double min, double max );
    void setInterval( const QwtInterval & );
    QwtInterval interval() const;

    void setPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setPen( const QPen & );
    const QPen &pen() const;

    void setBrush( const QBrush & );
    const QBrush &brush() const;

    virtual void draw( QPainter *,
        const QwtScaleMap &, const QwtScaleMap &,
        const QRectF &) const;

    virtual QRectF boundingRect() const;

/*
private:
    class PrivateData;
    PrivateData *d_data;
    */
};


