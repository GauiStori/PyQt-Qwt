/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief QwtPlotIntervalCurve represents a series of samples, where each value
         is associated with an interval ( \f$[y1,y2] = f(x)\f$ ).

  The representation depends on the style() and an optional symbol()
  that is displayed for each interval. QwtPlotIntervalCurve might be used
  to display error bars or the area between 2 curves.
*/
%If(- Qwt_6_2_0)
class QwtPlotIntervalCurve: QwtPlotSeriesItem, QwtSeriesStoreQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_plot_intervalcurve.h>
typedef QwtSeriesStore<QwtIntervalSample> QwtSeriesStoreQwtIntervalSample;
%End
public:
    /*!
        \brief Curve styles.
        The default setting is QwtPlotIntervalCurve::Tube.

        \sa setStyle(), style()
    */
    enum CurveStyle
    {
        /*!
           Don't draw a curve. Note: This doesn't affect the symbols.
         */
        NoCurve,

        /*!
           Build 2 curves from the upper and lower limits of the intervals
           and draw them with the pen(). The area between the curves is
           filled with the brush().
         */
        Tube,

        /*!
           Styles >= QwtPlotIntervalCurve::UserCurve are reserved for derived
           classes that overload drawSeries() with
           additional application specific curve types.
         */
        UserCurve = 100
    };

    /*!
        Attributes to modify the drawing algorithm.
        \sa setPaintAttribute(), testPaintAttribute()
    */
    enum PaintAttribute
    {
        /*!
          Clip polygons before painting them. In situations, where points
          are far outside the visible area (f.e when zooming deep) this
          might be a substantial improvement for the painting performance.
         */
        ClipPolygons = 0x01,

        //! Check if a symbol is on the plot canvas before painting it.
        ClipSymbol   = 0x02
    };

    //! Paint attributes
    //typedef QFlags<PaintAttribute> PaintAttributes;

    explicit QwtPlotIntervalCurve( const QString &title = QString() );
    explicit QwtPlotIntervalCurve( const QwtText &title );

    virtual ~QwtPlotIntervalCurve();

    virtual int rtti() const;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    void setSamples( const QList<QwtIntervalSample> & );
    void setSamples( QwtSeriesDataQwtIntervalSample * );

    void setPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setPen( const QPen & );
    const QPen &pen() const;

    void setBrush( const QBrush & );
    const QBrush &brush() const;

    void setStyle( CurveStyle style );
    CurveStyle style() const;

    void setSymbol( const QwtIntervalSymbol * /Transfer/);
    const QwtIntervalSymbol *symbol() const;

    virtual void drawSeries( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QRectF boundingRect() const;

    virtual QwtGraphic legendIcon( int index, const QSizeF & ) const;

protected:

    void init();

    virtual void drawTube( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawSymbols( QPainter *, const QwtIntervalSymbol &,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

/*
private:
    class PrivateData;
    PrivateData *d_data;*/
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotIntervalCurve
    : QwtPlotSeriesItem
    , QwtSeriesStoreQwtIntervalSample /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_intervalcurve.h>
typedef QwtSeriesStore<QwtIntervalSample> QwtSeriesStoreQwtIntervalSample;
%End
  public:
    /*!
        \brief Curve styles.
        The default setting is QwtPlotIntervalCurve::Tube.

        \sa setStyle(), style()
     */
    enum CurveStyle
    {
        /*!
           Don't draw a curve. Note: This doesn't affect the symbols.
         */
        NoCurve,

        /*!
           Build 2 curves from the upper and lower limits of the intervals
           and draw them with the pen(). The area between the curves is
           filled with the brush().
         */
        Tube,

        /*!
           Styles >= QwtPlotIntervalCurve::UserCurve are reserved for derived
           classes that overload drawSeries() with
           additional application specific curve types.
         */
        UserCurve = 100
    };

    /*!
        Attributes to modify the drawing algorithm.
        \sa setPaintAttribute(), testPaintAttribute()
     */
    enum PaintAttribute
    {
        /*!
           Clip polygons before painting them. In situations, where points
           are far outside the visible area (f.e when zooming deep) this
           might be a substantial improvement for the painting performance.
         */
        ClipPolygons = 0x01,

        //! Check if a symbol is on the plot canvas before painting it.
        ClipSymbol   = 0x02
    };

    //Q_DECLARE_FLAGS( PaintAttributes, PaintAttribute )

    explicit QwtPlotIntervalCurve( const QString& title = QString() );
    explicit QwtPlotIntervalCurve( const QwtText& title );

    virtual ~QwtPlotIntervalCurve();

    virtual int rtti() const;// QWT_OVERRIDE;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    void setSamples( const QList< QwtIntervalSample >& );
    //void setSamples( QwtSeriesData< QwtIntervalSample >* );

    void setPen( const QColor&,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );

    void setPen( const QPen& );
    const QPen& pen() const;

    void setBrush( const QBrush& );
    const QBrush& brush() const;

    void setStyle( CurveStyle style );
    CurveStyle style() const;

    void setSymbol( const QwtIntervalSymbol* );
    const QwtIntervalSymbol* symbol() const;

    virtual void drawSeries( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;// QWT_OVERRIDE;

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;

    virtual QwtGraphic legendIcon(
        int index, const QSizeF& ) const;// QWT_OVERRIDE;

  protected:

    void init();

    virtual void drawTube( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;

    virtual void drawSymbols( QPainter*, const QwtIntervalSymbol&,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;
};
%End // (Qwt_6_2_0 -)
