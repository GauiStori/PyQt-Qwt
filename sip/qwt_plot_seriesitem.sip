/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
class QwtPlotSeriesItem: QwtPlotItem, QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_plot_seriesitem.h>
%End
public:
    explicit QwtPlotSeriesItem( const QString &title = QString::null );
    //explicit QwtPlotSeriesItem( const QwtText &title );
    virtual ~QwtPlotSeriesItem();
    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation() const;
    virtual void draw( QPainter *p /Transfer/,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF & ) const;
    virtual void drawSeries( QPainter *painter /Transfer/,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const = 0;
    virtual QRectF boundingRect() const;
    virtual void updateScaleDiv( 
        const QwtScaleDiv &, const QwtScaleDiv & );
protected:
    virtual void dataChanged();
/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
