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
class QwtPlotZoomer: QwtPlotPicker
{
%TypeHeaderCode
#include <qwt_plot_zoomer.h>
%End
public:
    explicit QwtPlotZoomer( QWidget * /TransferThis/, bool doReplot = true );
    explicit QwtPlotZoomer( int xAxis, int yAxis, QWidget * /TransferThis/, bool doReplot = true );

    virtual ~QwtPlotZoomer();

    virtual void setZoomBase( bool doReplot = true );
    virtual void setZoomBase( const QRectF & );

    QRectF zoomBase() const;
    QRectF zoomRect() const;

    virtual void setAxis( int xAxis, int yAxis );

    void setMaxStackDepth( int );
    int maxStackDepth() const;

    const QStack<QRectF> &zoomStack() const;
    void setZoomStack( const QStack<QRectF> &, int zoomRectIndex = -1 );

    uint zoomRectIndex() const;

public Q_SLOTS:
    void moveBy( double x, double y );
    virtual void moveTo( const QPointF & );

    virtual void zoom( const QRectF & );
    virtual void zoom( int up );

Q_SIGNALS:
    /*!
      A signal emitting the zoomRect(), when the plot has been
      zoomed in or out.

      \param rect Current zoom rectangle.
    */

    void zoomed( const QRectF &rect );

protected:
    virtual void rescale();

    virtual QSizeF minZoomSize() const;

    virtual void widgetMouseReleaseEvent( QMouseEvent * );
    virtual void widgetKeyPressEvent( QKeyEvent * );

    virtual void begin();
    virtual bool end( bool ok = true );
    virtual bool accept( QPolygon & ) const;

//private:
    //void init( bool doReplot );

    //class PrivateData;
    //PrivateData *d_data;
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotZoomer : QwtPlotPicker
{
%TypeHeaderCode
#include <qwt_plot_zoomer.h>
%End
  public:
    //typedef int QwtAxisId;

    explicit QwtPlotZoomer( QWidget*, bool doReplot = true );
    //explicit QwtPlotZoomer( QwtAxisId xAxis, QwtAxisId yAxis,
    explicit QwtPlotZoomer( int xAxis, int yAxis,
        QWidget* /TransferThis/, bool doReplot = true );

    virtual ~QwtPlotZoomer();

    virtual void setZoomBase( bool doReplot = true );
    virtual void setZoomBase( const QRectF& );

    QRectF zoomBase() const;
    QRectF zoomRect() const;

    //virtual void setAxes( QwtAxisId xAxis, QwtAxisId yAxis ) ; // QWT_OVERRIDE; //FIXME
    virtual void setAxes( int xAxis, int yAxis ); // QWT_OVERRIDE; //FIXME
    void setMaxStackDepth( int );
    int maxStackDepth() const;

    const QStack< QRectF >& zoomStack() const;
    void setZoomStack( const QStack< QRectF >&,
        int zoomRectIndex = -1 );

    uint zoomRectIndex() const;

  public Q_SLOTS:
    void moveBy( double dx, double dy );
    virtual void moveTo( const QPointF& );

    virtual void zoom( const QRectF& );
    virtual void zoom( int offset );

  Q_SIGNALS:
    /*!
       A signal emitting the zoomRect(), when the plot has been
       zoomed in or out.

       \param rect Current zoom rectangle.
     */

    void zoomed( const QRectF& rect );

  protected:
    virtual void rescale();

    virtual QSizeF minZoomSize() const;

    virtual void widgetMouseReleaseEvent( QMouseEvent* ) ; // QWT_OVERRIDE;
    virtual void widgetKeyPressEvent( QKeyEvent* ) ; // QWT_OVERRIDE;

    virtual void begin() ; // QWT_OVERRIDE;
    virtual bool end( bool ok = true ) ; // QWT_OVERRIDE;
    virtual bool accept( QPolygon& ) const ; // QWT_OVERRIDE;

};
%End // (Qwt_6_2_0 -)
