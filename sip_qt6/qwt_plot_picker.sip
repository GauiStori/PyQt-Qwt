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
class QwtPlotPicker: QwtPicker
{
%TypeHeaderCode
#include <qwt_plot_picker.h>
%End
    //Q_OBJECT

public:
    explicit QwtPlotPicker( QWidget *canvas /TransferThis/ );
    virtual ~QwtPlotPicker();

    explicit QwtPlotPicker( int xAxis, int yAxis, QWidget * /TransferThis/);

    explicit QwtPlotPicker( int xAxis, int yAxis,
        RubberBand rubberBand, DisplayMode trackerMode, QWidget * /TransferThis/ );

    virtual void setAxis( int xAxis, int yAxis );

    int xAxis() const;
    int yAxis() const;

    QwtPlot *plot();
    //const QwtPlot *plot() const; FIXME

    QWidget *canvas();
    //const QWidget *canvas() const; FIXME

Q_SIGNALS:

    /*!
      A signal emitted in case of QwtPickerMachine::PointSelection.
      \param pos Selected point
    */
    void selected( const QPointF &pos );

    /*!
      A signal emitted in case of QwtPickerMachine::RectSelection.
      \param rect Selected rectangle
    */
    void selected( const QRectF &rect );

    /*!
      A signal emitting the selected points,
      at the end of a selection.

      \param pa Selected points
    */
    void selected( const QList<QPointF> &pa );

    /*!
      A signal emitted when a point has been appended to the selection

      \param pos Position of the appended point.
      \sa append(). moved()
    */
    void appended( const QPointF &pos );

    /*!
      A signal emitted whenever the last appended point of the
      selection has been moved.

      \param pos Position of the moved last point of the selection.
      \sa move(), appended()
    */
    void moved( const QPointF &pos );

protected:
    //QRectF scaleRect() const;

    QRectF invTransform( const QRect & ) const;
    QRect transform( const QRectF & ) const;

    QPointF invTransform( const QPoint & ) const;
    QPoint transform( const QPointF & ) const;

    //virtual QwtText trackerText( const QPoint & ) const;FIXME
    //virtual QwtText trackerTextF( const QPointF & ) const; FIXME

    virtual void move( const QPoint & );
    virtual void append( const QPoint & );
    virtual bool end( bool ok = true );

//private:
//    int d_xAxis;
//    int d_yAxis;
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtPlotPicker :  QwtPicker
{
%TypeHeaderCode
#include <qwt_plot_picker.h>
%End
  public:
    explicit QwtPlotPicker( QWidget* canvas  /TransferThis/);
    virtual ~QwtPlotPicker();

    //explicit QwtPlotPicker( QwtAxisId xAxisId, QwtAxisId yAxisId, QWidget* );
    //explicit QwtPlotPicker( QwtAxisId xAxisId, QwtAxisId yAxisId,
    //    RubberBand rubberBand, DisplayMode trackerMode, QWidget* );
    explicit QwtPlotPicker( int xAxisId, int yAxisId, QWidget* /TransferThis/);
    explicit QwtPlotPicker( int xAxisId, int yAxisId,
        RubberBand rubberBand, DisplayMode trackerMode, QWidget* /TransferThis/);

    virtual void setAxes( int xAxisId, int yAxisId );

    int xAxis() const;
    int yAxis() const;

    QwtPlot* plot();
    //const QwtPlot* plot() const;

    QWidget* canvas();
    //const QWidget* canvas() const;

  Q_SIGNALS:

    void selected( const QPointF& pos );
    void selected( const QRectF& rect );
    void selected( const QList< QPointF >& pa );
    void appended( const QPointF& pos );
    void moved( const QPointF& pos );

  protected:
    QRectF scaleRect() const;

    QRectF invTransform( const QRect& ) const;
    QRect transform( const QRectF& ) const;

    QPointF invTransform( const QPoint& ) const;
    QPoint transform( const QPointF& ) const;

    virtual QwtText trackerText( const QPoint& ) const;// QWT_OVERRIDE;
    virtual QwtText trackerTextF( const QPointF& ) const;

    virtual void move( const QPoint& );// QWT_OVERRIDE;
    virtual void append( const QPoint& );// QWT_OVERRIDE;
    virtual bool end( bool ok = true );// QWT_OVERRIDE;

};
%End // (Qwt_6_2_0 -)
