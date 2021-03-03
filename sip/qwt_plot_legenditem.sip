/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief A class which draws a legend inside the plot canvas

  QwtPlotLegendItem can be used to draw a inside the plot canvas.
  It can be used together with a QwtLegend or instead of it
  to have more space for the plot canvas.

  In opposite to QwtLegend the legend item is not interactive.
  To identify mouse clicks on a legend item an event filter
  needs to be installed catching mouse events ob the plot canvas.
  The geometries of the legend items are available using
  legendGeometries().

  The legend item is aligned to plot canvas according to
  its alignment() flags. It might have a background for the
  complete legend ( usually semi transparent ) or for
  each legend item.

  \note An external QwtLegend with a transparent background
        on top the plot canvas might be another option
        with a similar effect.
*/


class QwtPlotLegendItem: public QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_legenditem.h>
typedef QList<const QwtPlotItem *> QwtPlotItemList;
%End
	
public:
    /*!
      \brief Background mode

      Depending on the mode the complete legend or each item
      might have an background.

      The default setting is LegendBackground.

       \sa setBackgroundMode(), setBackgroundBrush(), drawBackground()
     */
    enum BackgroundMode
    {
        //! The legend has a background
        LegendBackground,

        //! Each item has a background
        ItemBackground
    };

    explicit QwtPlotLegendItem();
    virtual ~QwtPlotLegendItem();

    virtual int rtti() const;

    void setAlignment( Qt::Alignment );
    Qt::Alignment alignment() const;

    void setMaxColumns( uint );
    uint maxColumns() const;

    void setMargin( int );
    int margin() const;

    void setSpacing( int );
    int spacing() const;

    void setItemMargin( int );
    int itemMargin() const;

    void setItemSpacing( int );
    int itemSpacing() const;

    void setFont( const QFont& );
    QFont font() const;

    void setBorderDistance( int );
    int borderDistance() const;

    void setBorderRadius( double );
    double borderRadius() const;

    void setBorderPen( const QPen & );
    QPen borderPen() const;

    void setBackgroundBrush( const QBrush & );
    QBrush backgroundBrush() const;

    void setBackgroundMode( BackgroundMode );
    BackgroundMode backgroundMode() const;

    void setTextPen( const QPen & );
    QPen textPen() const;

    virtual void draw( QPainter *,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect ) const;

    void clearLegend();

    virtual void updateLegend( const QwtPlotItem *,
        const QList<QwtLegendData> & );

    virtual QRect geometry( const QRectF &canvasRect ) const;

    virtual QSize minimumSize( const QwtLegendData & ) const;
    virtual int heightForWidth( const QwtLegendData &, int width ) const;

    QwtPlotItemList plotItems() const;
    
    QList< QRect > legendGeometries( const QwtPlotItem * ) const;

protected:
    virtual void drawLegendData( QPainter *painter,
        const QwtPlotItem *, const QwtLegendData &, const QRectF & ) const;

    virtual void drawBackground( QPainter *, const QRectF &rect ) const;

/*
private:
    class PrivateData;
    PrivateData *d_data;
    */
};

