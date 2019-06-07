/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotCurve: QwtPlotSeriesItem, QwtSeriesStoreQPointF
{
%TypeHeaderCode
#include <qwt_plot_curve.h>
typedef QwtSeriesStore<QPointF> QwtSeriesStoreQPointF;
%End

public:
    /*!
        Curve styles.
        \sa setStyle(), style()
    */
    enum CurveStyle
    {
        /*!
           Don't draw a curve. Note: This doesn't affect the symbols.
        */
        NoCurve = -1,

        /*!
           Connect the points with straight lines. The lines might
           be interpolated depending on the 'Fitted' attribute. Curve
           fitting can be configured using setCurveFitter().
        */
        Lines,

        /*!
           Draw vertical or horizontal sticks ( depending on the 
           orientation() ) from a baseline which is defined by setBaseline().
        */
        Sticks,

        /*!
           Connect the points with a step function. The step function
           is drawn from the left to the right or vice versa,
           depending on the QwtPlotCurve::Inverted attribute.
        */
        Steps,

        /*!
           Draw dots at the locations of the data points. Note:
           This is different from a dotted line (see setPen()), and faster
           as a curve in QwtPlotCurve::NoStyle style and a symbol 
           painting a point.
        */
        Dots,

        /*!
           Styles >= QwtPlotCurve::UserCurve are reserved for derived
           classes of QwtPlotCurve that overload drawCurve() with
           additional application specific curve types.
        */
        UserCurve = 100
    };

    /*!
      Attribute for drawing the curve
      \sa setCurveAttribute(), testCurveAttribute(), curveFitter()
    */
    enum CurveAttribute
    {
        /*!
           For QwtPlotCurve::Steps only. 
           Draws a step function from the right to the left.
         */
        Inverted = 0x01,

        /*!
          Only in combination with QwtPlotCurve::Lines
          A QwtCurveFitter tries to
          interpolate/smooth the curve, before it is painted.

          \note Curve fitting requires temporary memory
          for calculating coefficients and additional points.
          If painting in QwtPlotCurve::Fitted mode is slow it might be better
          to fit the points, before they are passed to QwtPlotCurve.
         */
        Fitted = 0x02
    };

    //! Curve attributes
    //typedef QFlags<CurveAttribute> CurveAttributes;

    /*!
        Attributes how to represent the curve on the legend

        \sa setLegendAttribute(), testLegendAttribute(),
            QwtPlotItem::legendData(), legendIcon()
     */

    enum LegendAttribute
    {
        /*!
          QwtPlotCurve tries to find a color representing the curve 
          and paints a rectangle with it.
         */
        LegendNoAttribute = 0x00,

        /*!
          If the style() is not QwtPlotCurve::NoCurve a line 
          is painted with the curve pen().
         */
        LegendShowLine = 0x01,

        /*!
          If the curve has a valid symbol it is painted.
         */
        LegendShowSymbol = 0x02,

        /*!
          If the curve has a brush a rectangle filled with the
          curve brush() is painted.
         */
        LegendShowBrush = 0x04
    };

    //! Legend attributes
    //typedef QFlags<LegendAttribute> LegendAttributes;

    /*!
        Attributes to modify the drawing algorithm.
        The default setting enables ClipPolygons | FilterPoints

        \sa setPaintAttribute(), testPaintAttribute()
    */
    enum PaintAttribute
    {
        /*!
          Clip polygons before painting them. In situations, where points
          are far outside the visible area (f.e when zooming deep) this
          might be a substantial improvement for the painting performance
         */
        ClipPolygons = 0x01,

        /*!
          Tries to reduce the data that has to be painted, by sorting out
          duplicates, or paintings outside the visible area. Might have a
          notable impact on curves with many close points.
          Only a couple of very basic filtering algorithms are implemented.
         */
        FilterPoints = 0x02,

        /*!
          Minimize memory usage that is temporarily needed for the 
          translated points, before they get painted.
          This might slow down the performance of painting 
         */
        MinimizeMemory = 0x04,

        /*!
          Render the points to a temporary image and paint the image.
          This is a very special optimization for Dots style, when
          having a huge amount of points. 
          With a reasonable number of points QPainter::drawPoints()
          will be faster.
         */
        ImageBuffer = 0x08
    };

    //! Paint attributes
    //typedef QFlags<PaintAttribute> PaintAttributes;

    explicit QwtPlotCurve( const QString &title = QString::null);
    explicit QwtPlotCurve( const QwtText &title );

    virtual ~QwtPlotCurve();

    virtual int rtti() const;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    void setLegendAttribute( LegendAttribute, bool on = true );
    bool testLegendAttribute( LegendAttribute ) const;

//#ifndef QWT_NO_COMPAT
    void setRawSamples( const double *xData, const double *yData, int size );
    void setSamples( const double *xData, const double *yData, int size );
    void setSamples( const QVector<double> &xData, const QVector<double> &yData );
    void setSamples( const QPolygonF & );
    void setSamples( const QVector<QPointF> & );
    void setSamples( QwtSeriesDataQPointF * );

    int closestPoint( const QPoint &pos, double *dist = NULL ) const;

    double minXValue() const;
    double maxXValue() const;
    double minYValue() const;
    double maxYValue() const;

    void setCurveAttribute( CurveAttribute, bool on = true );
    bool testCurveAttribute( CurveAttribute ) const;

    void setPen( const QColor &, qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setPen( const QPen & );
    const QPen &pen() const;

    void setBrush( const QBrush & );
    const QBrush &brush() const;

    void setBaseline( double );
    double baseline() const;

    void setStyle( CurveStyle style );
    CurveStyle style() const;

    void setSymbol( QwtSymbol * /Transfer/);
    const QwtSymbol *symbol() const;

    void setCurveFitter( QwtCurveFitter * /Transfer/);
    QwtCurveFitter *curveFitter() const;

    virtual void drawSeries( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QwtGraphic legendIcon( int index, const QSizeF & ) const;

protected:

    void init();

    virtual void drawCurve( QPainter *p, int style,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawSymbols( QPainter *p, const QwtSymbol &,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawLines( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawSticks( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawDots( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawSteps( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void fillCurve( QPainter *,
        const QwtScaleMap &, const QwtScaleMap &, 
        const QRectF &canvasRect, QPolygonF & ) const;

    void closePolyline( QPainter *,
        const QwtScaleMap &, const QwtScaleMap &, QPolygonF & ) const;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};



