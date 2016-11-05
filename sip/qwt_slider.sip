/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtSlider: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_slider.h>
%End
/*    Q_OBJECT

    Q_ENUMS( ScalePosition BackgroundStyle )

    Q_PROPERTY( Qt::Orientation orientation
                READ orientation WRITE setOrientation )
    Q_PROPERTY( ScalePosition scalePosition READ scalePosition
        WRITE setScalePosition )

    Q_PROPERTY( bool trough READ hasTrough WRITE setTrough )
    Q_PROPERTY( bool groove READ hasGroove WRITE setGroove )

    Q_PROPERTY( QSize handleSize READ handleSize WRITE setHandleSize )
    Q_PROPERTY( int borderWidth READ borderWidth WRITE setBorderWidth )
    Q_PROPERTY( int spacing READ spacing WRITE setSpacing )*/

public:
    enum ScalePosition
    {
        NoScale,
        LeadingScale,
        TrailingScale
    };

    explicit QwtSlider( QWidget *parent = NULL );
    explicit QwtSlider( Qt::Orientation, QWidget *parent = NULL );

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
    //const QwtScaleDraw *scaleDraw() const;

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

/*private:
    QwtScaleDraw *scaleDraw();

    void layoutSlider( bool );
    void initSlider( Qt::Orientation );

    class PrivateData;
    PrivateData *d_data;*/
};
