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
class QwtPlotHistogram: QwtPlotSeriesItem , QwtSeriesStoreQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_plot_histogram.h>
typedef QwtSeriesStore<QwtIntervalSample> QwtSeriesStoreQwtIntervalSample;
%End
public:
    enum HistogramStyle
    {
        Outline,
        Columns,
        Lines,
        UserStyle = 100
    };

    explicit QwtPlotHistogram( const QString &title = QString() );
    //explicit QwtPlotHistogram( const QwtText &title );
    virtual ~QwtPlotHistogram();

    virtual int rtti() const;

    void setPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setPen( const QPen & );
    const QPen &pen() const;

    void setBrush( const QBrush & );
    const QBrush &brush() const;

    void setSamples( const QList<QwtIntervalSample> & );
    void setSamples( QwtSeriesDataQwtIntervalSample * ); 

    void setBaseline( double reference );
    double baseline() const;

    void setStyle( HistogramStyle style );
    HistogramStyle style() const;

    void setSymbol( const QwtColumnSymbol * /Transfer/);
    const QwtColumnSymbol *symbol() const;

    virtual void drawSeries( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QRectF boundingRect() const;

    //virtual QwtGraphic legendIcon( int index, const QSizeF & ) const;

protected:
    virtual QwtColumnRect columnRect( const QwtIntervalSample &,
        const QwtScaleMap &, const QwtScaleMap & ) const;

    virtual void drawColumn( QPainter *, const QwtColumnRect &,
        const QwtIntervalSample & ) const;

    void drawColumns( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        int from, int to ) const;

    void drawOutline( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        int from, int to ) const;

    void drawLines( QPainter *,
         const QwtScaleMap &xMap, const QwtScaleMap &yMap,
         int from, int to ) const;

private:
    void init();
    void flushPolygon( QPainter *, double baseLine, QPolygonF & ) const;
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotHistogram
    : QwtPlotSeriesItem
    , QwtSeriesStoreQwtIntervalSample // /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_histogram.h>
typedef QwtSeriesStore<QwtIntervalSample> QwtSeriesStoreQwtIntervalSample;
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
  public:
    enum HistogramStyle
    {
        Outline,
        Columns,
        Lines,
        UserStyle = 100
    };

    explicit QwtPlotHistogram( const QString& title = QString() );
    //explicit QwtPlotHistogram( const QwtText& title ); FIXME
    virtual ~QwtPlotHistogram();

    virtual int rtti() const;// QWT_OVERRIDE;

    void setPen( const QColor&,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );

    void setPen( const QPen& );
    const QPen& pen() const;

    void setBrush( const QBrush& );
    const QBrush& brush() const;

    void setSamples( const QList< QwtIntervalSample >& );
    void setSamples( QwtSeriesDataQwtIntervalSample* );

    void setBaseline( double );
    double baseline() const;

    void setStyle( HistogramStyle style );
    HistogramStyle style() const;

    void setSymbol( const QwtColumnSymbol*  /Transfer/);
    const QwtColumnSymbol* symbol() const;

    virtual void drawSeries( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;// QWT_OVERRIDE;

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;

    virtual QwtGraphic legendIcon(
        int index, const QSizeF& ) const;// QWT_OVERRIDE;

  protected:
    virtual QwtColumnRect columnRect( const QwtIntervalSample&,
        const QwtScaleMap&, const QwtScaleMap& ) const;

    virtual void drawColumn( QPainter*, const QwtColumnRect&,
        const QwtIntervalSample& ) const;

    void drawColumns( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        int from, int to ) const;

    void drawOutline( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        int from, int to ) const;

    void drawLines( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        int from, int to ) const;
private:
    QwtPlotHistogram(const QwtPlotHistogram&);
    QwtPlotHistogram& operator=(const QwtPlotHistogram&);
};
%End // (Qwt_6_2_0 -)
