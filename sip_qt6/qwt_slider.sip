/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


//class QwtScaleDraw;

/*!
  \brief The Slider Widget

  QwtSlider is a slider widget which operates on an interval
  of type double. Its position is related to a scale showing
  the current value.

  The slider can be customized by having a through, a groove - or both.

  \image html sliders.png
*/

class QwtSlider: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_slider.h>
%End

public:

    /*!
      Position of the scale
      \sa QwtSlider(), setScalePosition(), setOrientation()
     */
    enum ScalePosition
    {
        //! The slider has no scale
        NoScale,

        //! The scale is right of a vertical or below a horizontal slider
        LeadingScale,

        //! The scale is left of a vertical or above a horizontal slider
        TrailingScale
    };

    explicit QwtSlider( QWidget *parent /TransferThis/ = NULL );
    explicit QwtSlider( Qt::Orientation, QWidget *parent /TransferThis/ = NULL );

    virtual ~QwtSlider();

    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation() const;

    void setScalePosition( ScalePosition );
    ScalePosition scalePosition() const;

    void setTrough( bool );
    bool hasTrough() const;

    void setGroove( bool );
    bool hasGroove() const;

    void setHandleSize( const QSize & );
    QSize handleSize() const;

    void setBorderWidth( int bw );
    int borderWidth() const;

    void setSpacing( int );
    int spacing() const;

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    void setScaleDraw( QwtScaleDraw * );
    const QwtScaleDraw *scaleDraw() const;

    void setUpdateInterval( int );
    int updateInterval() const;

protected:
    virtual double scrolledTo( const QPoint & ) const;
    virtual bool isScrollPosition( const QPoint & ) const;

    virtual void drawSlider ( QPainter *, const QRect & ) const;
    virtual void drawHandle( QPainter *, const QRect &, int pos ) const;

    virtual void mousePressEvent( QMouseEvent * );
    virtual void mouseReleaseEvent( QMouseEvent * );
    virtual void resizeEvent( QResizeEvent * );
    virtual void paintEvent ( QPaintEvent * );
    virtual void changeEvent( QEvent * );
    virtual void timerEvent( QTimerEvent * );

    virtual void scaleChange();

    QRect sliderRect() const;
    QRect handleRect() const;

};

