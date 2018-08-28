/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotMultiBarChart: QwtPlotAbstractBarChart, QwtSeriesStoreQwtSetSample
{
%TypeHeaderCode
#include <qwt_plot_multi_barchart.h>
typedef QwtSeriesStore<QwtSetSample> QwtSeriesStoreQwtSetSample;
%End
public:
    enum ChartStyle
    {
        Grouped,
        Stacked
    };

    explicit QwtPlotMultiBarChart( const QString &title = QString::null );
    explicit QwtPlotMultiBarChart( const QwtText &title );

    virtual ~QwtPlotMultiBarChart();

    virtual int rtti() const;

    void setBarTitles( const QList<QwtText> & );
    QList<QwtText> barTitles() const;

    //void setSamples( const QVector<QwtSetSample> & ); //FIXME. Don't know if this is needed.
    void setSamples( const QVector< QVector<double> > & );
    void setSamples( QwtSeriesDataQwtSetSample * /Transfer/);

    void setStyle( ChartStyle style );
    ChartStyle style() const;

    void setSymbol( int barIndex, QwtColumnSymbol *symbol /Transfer/);
    //const QwtColumnSymbol *symbol( int barIndex ) const;

    void resetSymbolMap();

    virtual void drawSeries( QPainter *painter /Transfer/,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QRectF boundingRect() const;

    virtual QList<QwtLegendData> legendData() const;

    virtual QwtGraphic legendIcon( int index, const QSizeF & ) const;

protected:
    QwtColumnSymbol *symbol( int barIndex );

    virtual QwtColumnSymbol *specialSymbol( 
        int sampleIndex, int valueIndex ) const;

    virtual void drawSample( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, const QwtInterval &boundingInterval,
        int index, const QwtSetSample& sample ) const;

    virtual void drawBar( QPainter *, int sampleIndex,
        int barIndex, const QwtColumnRect & ) const;

    void drawStackedBars( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int index,
        double sampleWidth, const QwtSetSample& sample ) const;

    void drawGroupedBars( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int index,
        double sampleWidth, const QwtSetSample& sample ) const;

/*private:
    void init();

    class PrivateData;
    PrivateData *d_data;*/
};
