/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%If(- Qwt_6_1_6)
class QwtPlotGrid: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_grid.h>
%End
public:
    explicit QwtPlotGrid();
    virtual ~QwtPlotGrid();

    virtual int rtti() const;

    void enableX( bool tf );
    bool xEnabled() const;

    void enableY( bool tf );
    bool yEnabled() const;

    void enableXMin( bool tf );
    bool xMinEnabled() const;

    void enableYMin( bool tf );
    bool yMinEnabled() const;

    void setXDiv( const QwtScaleDiv &sx );
    const QwtScaleDiv &xScaleDiv() const;

    void setYDiv( const QwtScaleDiv &sy );
    const QwtScaleDiv &yScaleDiv() const;

    void setPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setPen( const QPen & );

    void setMajorPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setMajorPen( const QPen & );
    const QPen& majorPen() const;

    void setMinorPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setMinorPen( const QPen &p );
    const QPen& minorPen() const;

    virtual void draw( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &rect ) const;

    virtual void updateScaleDiv( 
        const QwtScaleDiv &xMap, const QwtScaleDiv &yMap );

/*private:
    void drawLines( QPainter *painter, const QRectF &,
        Qt::Orientation orientation, const QwtScaleMap &,
        const QList<double> & ) const;

    class PrivateData;
    PrivateData *d_data;*/
};
%End // (- Qwt_6_1_6)

%If(Qwt_6_2_0 -)
class QwtPlotGrid : QwtPlotItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_grid.h>
%End
  public:
    explicit QwtPlotGrid();
    virtual ~QwtPlotGrid();

    virtual int rtti() const;// QWT_OVERRIDE;

    void enableX( bool );
    bool xEnabled() const;

    void enableY( bool );
    bool yEnabled() const;

    void enableXMin( bool );
    bool xMinEnabled() const;

    void enableYMin( bool );
    bool yMinEnabled() const;

    void setXDiv( const QwtScaleDiv& );
    const QwtScaleDiv& xScaleDiv() const;

    void setYDiv( const QwtScaleDiv& );
    const QwtScaleDiv& yScaleDiv() const;

    void setPen( const QColor&,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );

    void setPen( const QPen& );

    void setMajorPen( const QColor&,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );

    void setMajorPen( const QPen& );
    const QPen& majorPen() const;

    void setMinorPen( const QColor&, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setMinorPen( const QPen& );
    const QPen& minorPen() const;

    virtual void draw( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect ) const;// QWT_OVERRIDE;

    virtual void updateScaleDiv(
        const QwtScaleDiv& xScaleDiv, const QwtScaleDiv& yScaleDiv );// QWT_OVERRIDE;

/*  private:
    void drawLines( QPainter*, const QRectF&,
        Qt::Orientation, const QwtScaleMap&,
        const QList< double >& ) const;

    class PrivateData;
    PrivateData* m_data;*/
};
%End // (- Qwt_6_2_0)
