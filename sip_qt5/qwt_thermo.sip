/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtThermo: QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_thermo.h>
%End
/*    Q_OBJECT

    Q_ENUMS( ScalePosition )
    Q_ENUMS( OriginMode )

    Q_PROPERTY( Qt::Orientation orientation
        READ orientation WRITE setOrientation )
    Q_PROPERTY( ScalePosition scalePosition 
        READ scalePosition WRITE setScalePosition )
    Q_PROPERTY( OriginMode originMode READ originMode WRITE setOriginMode )

    Q_PROPERTY( bool alarmEnabled READ alarmEnabled WRITE setAlarmEnabled )
    Q_PROPERTY( double alarmLevel READ alarmLevel WRITE setAlarmLevel )
    Q_PROPERTY( double origin READ origin WRITE setOrigin )
    Q_PROPERTY( int spacing READ spacing WRITE setSpacing )
    Q_PROPERTY( int borderWidth READ borderWidth WRITE setBorderWidth )
    Q_PROPERTY( int pipeWidth READ pipeWidth WRITE setPipeWidth )
    Q_PROPERTY( double value READ value WRITE setValue )*/

public:

    enum ScalePosition
    {
        NoScale,
        LeadingScale,
        TrailingScale
    };

    enum OriginMode
    {
        OriginMinimum,
        OriginMaximum,
        OriginCustom
    };

    explicit QwtThermo( QWidget *parent /TransferThis/ = NULL );
    virtual ~QwtThermo();

    void setOrientation( Qt::Orientation );
    Qt::Orientation orientation() const;

    void setScalePosition( ScalePosition );
    ScalePosition scalePosition() const;

    void setSpacing( int );
    int spacing() const;

    void setBorderWidth( int w );
    int borderWidth() const;

    void setOriginMode( OriginMode );
    OriginMode originMode() const;

    void setOrigin( double );
    double origin() const;

    void setFillBrush( const QBrush &b );
    QBrush fillBrush() const;

    void setAlarmBrush( const QBrush &b );
    QBrush alarmBrush() const;

    void setAlarmLevel( double v );
    double alarmLevel() const;

    void setAlarmEnabled( bool tf );
    bool alarmEnabled() const;

    void setColorMap( QwtColorMap * /Transfer/);
    QwtColorMap *colorMap();
    //const QwtColorMap *colorMap() const;

    void setPipeWidth( int w );
    int pipeWidth() const;

    void setRangeFlags( QwtInterval::BorderFlags );
    QwtInterval::BorderFlags rangeFlags() const;

    double value() const;

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    void setScaleDraw( QwtScaleDraw * /Transfer/);
    //const QwtScaleDraw *scaleDraw() const;

public Q_SLOTS:
    virtual void setValue( double val );

protected:
    virtual void drawLiquid( QPainter * /Transfer/, const QRect & ) const;
    virtual void scaleChange();

    virtual void paintEvent( QPaintEvent *);
    virtual void resizeEvent( QResizeEvent *);
    virtual void changeEvent( QEvent *);

    QwtScaleDraw *scaleDraw();

    QRect pipeRect() const;
    QRect fillRect( const QRect & ) const;
    QRect alarmRect( const QRect & ) const;

/*private:
    void layoutThermo( bool );

    class PrivateData;
    PrivateData *d_data;*/
};
