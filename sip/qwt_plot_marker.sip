/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotMarker: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_marker.h>
%End

public:

    /*!
        Line styles.
        \sa setLineStyle(), lineStyle()
    */
    enum LineStyle
    {
        //! No line
        NoLine,

        //! A horizontal line
        HLine,

        //! A vertical line
        VLine,

        //! A crosshair
        Cross
    };

    explicit QwtPlotMarker( const QString &title = QString::null );
    explicit QwtPlotMarker( const QwtText &title );

    virtual ~QwtPlotMarker();

    virtual int rtti() const;

    double xValue() const;
    double yValue() const;
    QPointF value() const;

    void setXValue( double );
    void setYValue( double );
    void setValue( double, double );
    void setValue( const QPointF & );

    void setLineStyle( LineStyle st );
    LineStyle lineStyle() const;

    void setLinePen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setLinePen( const QPen &p );
    const QPen &linePen() const;

    void setSymbol( const QwtSymbol * /Transfer/);
    const QwtSymbol *symbol() const;

    void setLabel( const QwtText& );
    QwtText label() const;

    void setLabelAlignment( Qt::Alignment );
    Qt::Alignment labelAlignment() const;

    void setLabelOrientation( Qt::Orientation );
    Qt::Orientation labelOrientation() const;

    void setSpacing( int );
    int spacing() const;

    virtual void draw( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF & ) const;

    virtual QRectF boundingRect() const;

    //virtual QwtGraphic legendIcon( int index, const QSizeF & ) const; FIXME

protected:
    virtual void drawLines( QPainter *, 
        const QRectF &, const QPointF & ) const;

    virtual void drawLabel( QPainter *, 
        const QRectF &, const QPointF & ) const;

/*private:

    class PrivateData;
    PrivateData *d_data;*/
};
