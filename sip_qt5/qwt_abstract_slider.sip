/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtAbstractSlider: QwtAbstractScale
{
%TypeHeaderCode
#include <qwt_abstract_slider.h>
%End
/*    Q_OBJECT

    Q_PROPERTY( double value READ value WRITE setValue )

    Q_PROPERTY( uint totalSteps READ totalSteps WRITE setTotalSteps )
    Q_PROPERTY( uint singleSteps READ singleSteps WRITE setSingleSteps )
    Q_PROPERTY( uint pageSteps READ pageSteps WRITE setPageSteps )
    Q_PROPERTY( bool stepAlignment READ stepAlignment WRITE setStepAlignment )

    Q_PROPERTY( bool readOnly READ isReadOnly WRITE setReadOnly )
    Q_PROPERTY( bool tracking READ isTracking WRITE setTracking )
    Q_PROPERTY( bool wrapping READ wrapping WRITE setWrapping )

    Q_PROPERTY( bool invertedControls READ invertedControls WRITE setInvertedControls )*/

public:
    explicit QwtAbstractSlider( QWidget *parent /TransferThis/ = NULL );
    virtual ~QwtAbstractSlider();

    void setValid( bool );
    bool isValid() const;

    double value() const;

    void setWrapping( bool );
    bool wrapping() const;

    void setTotalSteps( uint );
    uint totalSteps() const;

    void setSingleSteps( uint );
    uint singleSteps() const;

    void setPageSteps( uint );
    uint pageSteps() const;

    void setStepAlignment( bool ); 
    bool stepAlignment() const;

    void setTracking( bool );
    bool isTracking() const;

    void setReadOnly( bool );
    bool isReadOnly() const;

    void setInvertedControls( bool );
    bool invertedControls() const;

public Q_SLOTS:
    void setValue( double val );

Q_SIGNALS:
    void valueChanged( double value );
    void sliderPressed();
    void sliderReleased();
    void sliderMoved( double value );

protected:
    virtual void mousePressEvent( QMouseEvent *);
    virtual void mouseReleaseEvent( QMouseEvent *);
    virtual void mouseMoveEvent( QMouseEvent *);
    virtual void keyPressEvent( QKeyEvent *);
    virtual void wheelEvent( QWheelEvent *);
    virtual bool isScrollPosition( const QPoint &pos ) const = 0;
    virtual double scrolledTo( const QPoint &pos ) const = 0;
    void incrementValue( int numSteps );
    virtual void scaleChange();

protected:
    virtual void sliderChange();
    double incrementedValue( double value, int stepCount ) const;

private:
    double alignedValue( double ) const;
    double boundedValue( double ) const;

/*    class PrivateData;
    PrivateData *d_data;*/
};
