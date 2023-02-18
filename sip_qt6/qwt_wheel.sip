/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtWheel: QWidget
{
%TypeHeaderCode
#include <qwt_wheel.h>
%End
/*    Q_OBJECT

    Q_PROPERTY( Qt::Orientation orientation
                READ orientation WRITE setOrientation )

    Q_PROPERTY( double value READ value WRITE setValue )
    Q_PROPERTY( double minimum READ minimum WRITE setMinimum )
    Q_PROPERTY( double maximum READ maximum WRITE setMaximum )

    Q_PROPERTY( double singleStep READ singleStep WRITE setSingleStep )
    Q_PROPERTY( int pageStepCount READ pageStepCount WRITE setPageStepCount )
    Q_PROPERTY( bool stepAlignment READ stepAlignment WRITE setStepAlignment )

    Q_PROPERTY( bool tracking READ isTracking WRITE setTracking )
    Q_PROPERTY( bool wrapping READ wrapping WRITE setWrapping )
    Q_PROPERTY( bool inverted READ isInverted WRITE setInverted )

    Q_PROPERTY( double mass READ mass WRITE setMass )
    Q_PROPERTY( int updateInterval READ updateInterval WRITE setUpdateInterval )

    Q_PROPERTY( double totalAngle READ totalAngle WRITE setTotalAngle )
    Q_PROPERTY( double viewAngle READ viewAngle WRITE setViewAngle )
    Q_PROPERTY( int tickCount READ tickCount WRITE setTickCount )
    Q_PROPERTY( int wheelWidth READ wheelWidth WRITE setWheelWidth )
    Q_PROPERTY( int borderWidth READ borderWidth WRITE setBorderWidth )
    Q_PROPERTY( int wheelBorderWidth READ wheelBorderWidth WRITE setWheelBorderWidth )*/

public:
    explicit QwtWheel( QWidget *parent /TransferThis/ = NULL );
    virtual ~QwtWheel();

    double value() const;

    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation() const;

    double totalAngle() const;
    double viewAngle() const;

    void setTickCount( int );
    int tickCount() const;

    void setWheelWidth( int );
    int wheelWidth() const;

    void setWheelBorderWidth( int );
    int wheelBorderWidth() const;

    void setBorderWidth( int );
    int borderWidth() const;

    void setInverted( bool tf );
    bool isInverted() const;

    void setWrapping( bool tf );
    bool wrapping() const;

    void setSingleStep( double );
    double singleStep() const;

    void setPageStepCount( int );
    int pageStepCount() const;

    void setStepAlignment( bool on );
    bool stepAlignment() const;

    void setRange( double vmin, double vmax );

    void setMinimum( double min );
    double minimum() const;

    void setMaximum( double max );
    double maximum() const;

    void setUpdateInterval( int );
    int updateInterval() const;

    void setTracking( bool enable );
    bool isTracking() const;

    double mass() const;

public Q_SLOTS:
    void setValue( double );
    void setTotalAngle ( double );
    void setViewAngle( double );
    void setMass( double );

Q_SIGNALS:

    void valueChanged( double value );
    void wheelPressed();
    void wheelReleased();
    void wheelMoved( double value );

protected:
    virtual void paintEvent( QPaintEvent *);
    virtual void mousePressEvent( QMouseEvent *);
    virtual void mouseReleaseEvent( QMouseEvent *);
    virtual void mouseMoveEvent( QMouseEvent *);
    virtual void keyPressEvent( QKeyEvent *);
    virtual void wheelEvent( QWheelEvent *);
    virtual void timerEvent( QTimerEvent *);

    void stopFlying();

    QRect wheelRect() const;

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    virtual void drawTicks( QPainter * /Transfer/, const QRectF & );
    virtual void drawWheelBackground( QPainter * /Transfer/, const QRectF & );

    virtual double valueAt( const QPoint & ) const;

/*private:
    double alignedValue( double ) const;
    double boundedValue( double ) const;

    class PrivateData;
    PrivateData *d_data;*/
};
