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
class QwtPlotBarChart: QwtPlotAbstractBarChart, QwtSeriesStoreQPointF /NoDefaultCtors/
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

    explicit QwtPlotBarChart( const QString &title = QString() );
    explicit QwtPlotBarChart( const QwtText &title );

    virtual ~QwtPlotBarChart();

    virtual int rtti() const;

    void setSamples( const QList<QPointF> & );
    void setSamples( const QList<double> & );
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
%End // (- Qwt_6_1_6)

%If(Qwt_6_2_0 -)
class QwtPlotBarChart
    : QwtPlotAbstractBarChart
    , QwtSeriesStoreQPointF /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_barchart.h>
typedef QwtSeriesStore<QPointF> QwtSeriesStoreQPointF;
%End
  public:
    enum LegendMode
    {
        LegendChartTitle,
        LegendBarTitles
    };

    explicit QwtPlotBarChart( const QString& title = QString() );
    explicit QwtPlotBarChart( const QwtText& title );

    virtual ~QwtPlotBarChart();

    virtual int rtti() const;// QWT_OVERRIDE;

    void setSamples( const QList< QPointF >& );
    void setSamples( const QList< double >& );
    void setSamples( QwtSeriesDataQPointF* );

    void setSymbol( QwtColumnSymbol* /Transfer/);
    const QwtColumnSymbol* symbol() const;

    void setLegendMode( LegendMode );
    LegendMode legendMode() const;

    virtual void drawSeries( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;// QWT_OVERRIDE;

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;

    virtual QwtColumnSymbol* specialSymbol(
        int sampleIndex, const QPointF& ) const;

    virtual QwtText barTitle( int sampleIndex ) const;

  protected:
    virtual void drawSample( QPainter* painter,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, const QwtInterval& boundingInterval,
        int index, const QPointF& sample ) const;

    virtual void drawBar( QPainter*,
        int sampleIndex, const QPointF& sample,
        const QwtColumnRect& ) const;

    QwtColumnRect columnRect(
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, const QwtInterval& boundingInterval,
        const QPointF& sample ) const;

    QList< QwtLegendData > legendData() const;// QWT_OVERRIDE;
    QwtGraphic legendIcon( int index, const QSizeF& ) const;// QWT_OVERRIDE;

/*  private:
    void init();

    class PrivateData;
    PrivateData* m_data;*/
};
%End // (Qwt_6_2_0 -)
