/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotBarChart: QwtPlotAbstractBarChart, QwtSeriesStoreQPointF
{
%TypeHeaderCode
#include <qwt_plot_barchart.h>
typedef QwtSeriesStore<QPointF> QwtSeriesStoreQPointF;
%End
public:
    /*!
      \brief Legend modes.

      The default setting is QwtPlotBarChart::LegendChartTitle.
      \sa setLegendMode(), legendMode()
    */
    enum LegendMode
    {
        /*! 
          One entry on the legend showing the default symbol
          and the title() of the chart

          \sa QwtPlotItem::title()
         */
        LegendChartTitle,

        /*!
          One entry for each value showing the individual symbol
          of the corresponding bar and the bar title.

          \sa specialSymbol(), barTitle()
         */
        LegendBarTitles
    };

    explicit QwtPlotBarChart( const QString &title = QString::null );
    explicit QwtPlotBarChart( const QwtText &title );

    virtual ~QwtPlotBarChart();

    virtual int rtti() const;

    void setSamples( const QVector<QPointF> & );
    void setSamples( const QVector<double> & );
    void setSamples( QwtSeriesDataQPointF *series );

    void setSymbol( QwtColumnSymbol * /Transfer/);
    const QwtColumnSymbol *symbol() const;

    void setLegendMode( QwtPlotBarChart::LegendMode );
    QwtPlotBarChart::LegendMode legendMode() const;

    virtual void drawSeries( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QRectF boundingRect() const;

    virtual QwtColumnSymbol *specialSymbol( 
        int sampleIndex, const QPointF& ) const;

    virtual QwtText barTitle( int sampleIndex ) const;

protected:
    virtual void drawSample( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, const QwtInterval &boundingInterval,
        int index, const QPointF& sample ) const;

    virtual void drawBar( QPainter *,
        int sampleIndex, const QPointF& point, 
        const QwtColumnRect & ) const;

    QList<QwtLegendData> legendData() const;
    QwtGraphic legendIcon( int index, const QSizeF & ) const;

/*private:
    void init();

    class PrivateData;
    PrivateData *d_data;*/
};

