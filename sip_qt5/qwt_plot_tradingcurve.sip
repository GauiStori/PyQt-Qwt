/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief QwtPlotTradingCurve illustrates movements in the price of a
         financial instrument over time.

  QwtPlotTradingCurve supports candlestick or bar ( OHLC ) charts
  that are used in the domain of technical analysis.

  While the length ( height or width depending on orientation() )
  of each symbol depends on the corresponding OHLC sample the size
  of the other dimension can be controlled using:

  - setSymbolExtent()
  - setSymbolMinWidth()
  - setSymbolMaxWidth()

  The extent is a size in scale coordinates, so that the symbol width
  is increasing when the plot is zoomed in. Minimum/Maximum width
  is in widget coordinates independent from the zoom level.
  When setting the minimum and maximum to the same value, the width of
  the symbol is fixed.
*/

%If(- Qwt_6_2_0)
class QwtPlotTradingCurve: public QwtPlotSeriesItem, public QwtSeriesStoreQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_plot_tradingcurve.h>
typedef QwtSeriesStore<QwtOHLCSample> QwtSeriesStoreQwtOHLCSample;
%End

public:
    /*!
        \brief Symbol styles.

        The default setting is QwtPlotSeriesItem::CandleStick.
        \sa setSymbolStyle(), symbolStyle()
    */
    enum SymbolStyle
    {
        //! Nothing is displayed
        NoSymbol = -1,

        /*!
          A line on the chart shows the price range (the highest and lowest
          prices) over one unit of time, e.g. one day or one hour.
          Tick marks project from each side of the line indicating the
          opening and closing price.
         */
        Bar,

        /*!
          The range between opening/closing price are displayed as
          a filled box. The fill brush depends on the direction of the
          price movement. The box is connected to the highest/lowest
          values by lines.
        */
        CandleStick,

        /*!
          SymbolTypes >= UserSymbol are displayed by drawUserSymbol(),
          that needs to be overloaded and implemented in derived
          curve classes.

          \sa drawUserSymbol()
        */
        UserSymbol = 100
    };

    /*!
        \brief Direction of a price movement
     */
    enum Direction
    {
        //! The closing price is higher than the opening price
       Increasing,

        //! The closing price is lower than the opening price
        Decreasing
    };

    /*!
        Attributes to modify the drawing algorithm.
        \sa setPaintAttribute(), testPaintAttribute()
    */
    enum PaintAttribute
    {
        //! Check if a symbol is on the plot canvas before painting it.
        ClipSymbols   = 0x01
    };

    //! Paint attributes
    //typedef QFlags<PaintAttribute> PaintAttributes;

    explicit QwtPlotTradingCurve( const QString &title = QString() );
    explicit QwtPlotTradingCurve( const QwtText &title );

    virtual ~QwtPlotTradingCurve();

    virtual int rtti() const;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    void setSamples( const QVector<QwtOHLCSample> & );
    void setSamples( QwtSeriesDataQwtOHLCSample * );

    void setSymbolStyle( SymbolStyle style );
    SymbolStyle symbolStyle() const;

    void setSymbolPen( const QColor &,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setSymbolPen( const QPen & );
    QPen symbolPen() const;

    void setSymbolBrush( Direction, const QBrush & );
    QBrush symbolBrush( Direction ) const;

    void setSymbolExtent( double );
    double symbolExtent() const;

    void setMinSymbolWidth( double );
    double minSymbolWidth() const;

    void setMaxSymbolWidth( double );
    double maxSymbolWidth() const;

    virtual void drawSeries( QPainter *painter,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual QRectF boundingRect() const;

    virtual QwtGraphic legendIcon( int index, const QSizeF & ) const;

protected:

    void init();

    virtual void drawSymbols( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect, int from, int to ) const;

    virtual void drawUserSymbol( QPainter *,
        SymbolStyle, const QwtOHLCSample &,
        Qt::Orientation, bool inverted, double symbolWidth ) const;

    void drawBar( QPainter *painter, const QwtOHLCSample &,
        Qt::Orientation, bool inverted, double width ) const;

    void drawCandleStick( QPainter *, const QwtOHLCSample &,
        Qt::Orientation, double width ) const;

    virtual double scaledSymbolWidth(
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect ) const;
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotTradingCurve
    : QwtPlotSeriesItem
    , QwtSeriesStoreQwtOHLCSample /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_tradingcurve.h>
typedef QwtSeriesStore<QwtOHLCSample> QwtSeriesStoreQwtOHLCSample;
%End
  public:
    enum SymbolStyle
    {
        NoSymbol = -1,
        Bar,
        CandleStick,
        UserSymbol = 100
    };
    enum Direction
    {
        Increasing,
        Decreasing
    };

    enum PaintAttribute
    {
        ClipSymbols   = 0x01
    };

    //Q_DECLARE_FLAGS( PaintAttributes, PaintAttribute )

    explicit QwtPlotTradingCurve( const QString& title = QString() );
    explicit QwtPlotTradingCurve( const QwtText& title );

    virtual ~QwtPlotTradingCurve();

    virtual int rtti() const;// QWT_OVERRIDE;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    void setSamples( const QVector< QwtOHLCSample >& );
    //void setSamples( QwtSeriesData< QwtOHLCSample >* ); FIXME

    void setSymbolStyle( SymbolStyle style );
    SymbolStyle symbolStyle() const;

    void setSymbolPen( const QColor&,
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setSymbolPen( const QPen& );
    QPen symbolPen() const;

    void setSymbolBrush( Direction, const QBrush& );
    QBrush symbolBrush( Direction ) const;

    void setSymbolExtent( double );
    double symbolExtent() const;

    void setMinSymbolWidth( double );
    double minSymbolWidth() const;

    void setMaxSymbolWidth( double );
    double maxSymbolWidth() const;

    virtual void drawSeries( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;// QWT_OVERRIDE;

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;

    virtual QwtGraphic legendIcon( int index, const QSizeF& ) const;// QWT_OVERRIDE;

  protected:

    void init();

    virtual void drawSymbols( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect, int from, int to ) const;

    virtual void drawUserSymbol( QPainter*,
        SymbolStyle, const QwtOHLCSample&,
        Qt::Orientation, bool inverted, double symbolWidth ) const;

    void drawBar( QPainter*, const QwtOHLCSample&,
        Qt::Orientation, bool inverted, double width ) const;

    void drawCandleStick( QPainter*, const QwtOHLCSample&,
        Qt::Orientation, double width ) const;

    virtual double scaledSymbolWidth(
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect ) const;
};
%End // (Qwt_6_2_0 -)
