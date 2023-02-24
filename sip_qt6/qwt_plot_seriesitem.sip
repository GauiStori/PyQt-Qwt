/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
%If(- Qwt_6_2_0)
class QwtPlotSeriesItem: QwtPlotItem, QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_plot_seriesitem.h>
%End
public:
    explicit QwtPlotSeriesItem( const QString &title = QString() );
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
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotSeriesItem : QwtPlotItem, QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_plot_seriesitem.h>
%End
  public:
    explicit QwtPlotSeriesItem( const QString& title = QString() );
    //explicit QwtPlotSeriesItem( const QwtText& title ); FIXME

    virtual ~QwtPlotSeriesItem();

    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation() const;

    virtual void draw( QPainter* /Transfer/,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect ) const;// QWT_OVERRIDE;
    virtual void drawSeries( QPainter* painter /Transfer/,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const = 0;

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;

    virtual void updateScaleDiv(
        const QwtScaleDiv&, const QwtScaleDiv& );// QWT_OVERRIDE;

  protected:
    virtual void dataChanged();// QWT_OVERRIDE;
private:
    QwtPlotSeriesItem(const QwtPlotSeriesItem&);
    QwtPlotSeriesItem& operator=(const QwtPlotSeriesItem&);
};
%End // (- Qwt_6_2_0)
