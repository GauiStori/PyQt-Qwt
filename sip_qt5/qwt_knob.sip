/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtKnob: QwtAbstractSlider
{
%TypeHeaderCode
#include <qwt_knob.h>
%End
/*    Q_OBJECT

    Q_ENUMS ( KnobStyle MarkerStyle )

    Q_PROPERTY( KnobStyle knobStyle READ knobStyle WRITE setKnobStyle )
    Q_PROPERTY( int knobWidth READ knobWidth WRITE setKnobWidth )
    Q_PROPERTY( Qt::Alignment alignment READ alignment WRITE setAlignment )
    Q_PROPERTY( double totalAngle READ totalAngle WRITE setTotalAngle )
    Q_PROPERTY( int numTurns READ numTurns WRITE setNumTurns )
    Q_PROPERTY( MarkerStyle markerStyle READ markerStyle WRITE setMarkerStyle )
    Q_PROPERTY( int markerSize READ markerSize WRITE setMarkerSize )
    Q_PROPERTY( int borderWidth READ borderWidth WRITE setBorderWidth )*/

public:
    enum KnobStyle
    {
        Flat,
        Raised,
        Sunken,
        Styled
    };
    enum MarkerStyle 
    { 
        NoMarker = -1,
        Tick, 
        Triangle, 
        Dot, 
        Nub, 
        Notch 
    };

    explicit QwtKnob( QWidget* parent /TransferThis/ = NULL );
    virtual ~QwtKnob();

    void setAlignment( Qt::Alignment );
    Qt::Alignment alignment() const;

    void setKnobWidth( int );
    int knobWidth() const;

    void setNumTurns( int );
    int numTurns() const;

    void setTotalAngle ( double angle );
    double totalAngle() const;

    void setKnobStyle( KnobStyle );
    KnobStyle knobStyle() const;

    void setBorderWidth( int bw );
    int borderWidth() const;

    void setMarkerStyle( MarkerStyle );
    MarkerStyle markerStyle() const;

    void setMarkerSize( int );
    int markerSize() const;

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    void setScaleDraw( QwtRoundScaleDraw * /Transfer/);

    //const QwtRoundScaleDraw *scaleDraw() const;
    QwtRoundScaleDraw *scaleDraw();

    QRect knobRect() const;

protected:
    virtual void paintEvent( QPaintEvent *);
    virtual void changeEvent( QEvent *);

    virtual void drawKnob( QPainter * /Transfer/, const QRectF & ) const;

    virtual void drawFocusIndicator( QPainter * /Transfer/) const;

    virtual void drawMarker( QPainter * /Transfer/, 
        const QRectF &, double arc ) const;

    virtual double scrolledTo( const QPoint & ) const;
    virtual bool isScrollPosition( const QPoint & ) const;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
