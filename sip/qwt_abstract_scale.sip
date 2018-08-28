/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtAbstractScale: QWidget
{
%TypeHeaderCode
#include <qwt_abstract_scale.h>
%End
/*    Q_OBJECT

    Q_PROPERTY( double lowerBound READ lowerBound WRITE setLowerBound )
    Q_PROPERTY( double upperBound READ upperBound WRITE setUpperBound )

    Q_PROPERTY( int scaleMaxMajor READ scaleMaxMajor WRITE setScaleMaxMajor )
    Q_PROPERTY( int scaleMaxMinor READ scaleMaxMinor WRITE setScaleMaxMinor )

    Q_PROPERTY( double scaleStepSize READ scaleStepSize WRITE setScaleStepSize )
*/
public:
    QwtAbstractScale( QWidget *parent /TransferThis/ = NULL );
    virtual ~QwtAbstractScale();

    void setScale( double lowerBound, double upperBound );
    void setScale( const QwtInterval & );
    void setScale( const QwtScaleDiv & );

    const QwtScaleDiv& scaleDiv() const;

    void setLowerBound( double value );
    double lowerBound() const;

    void setUpperBound( double value );
    double upperBound() const;

    void setScaleStepSize( double stepSize );
    double scaleStepSize() const;

    void setScaleMaxMajor( int ticks );
    int scaleMaxMinor() const;

    void setScaleMaxMinor( int ticks );
    int scaleMaxMajor() const;

    void setScaleEngine( QwtScaleEngine * /Transfer/ );

    //const QwtScaleEngine *scaleEngine() const;
    QwtScaleEngine *scaleEngine();

    int transform( double ) const;
    double invTransform( int ) const;

    bool isInverted() const;

    double minimum() const;
    double maximum() const;

    const QwtScaleMap &scaleMap() const;

protected:
    void rescale( double lowerBound, double upperBound, double stepSize );

    void setAbstractScaleDraw( QwtAbstractScaleDraw * /Transfer/ );

    //const QwtAbstractScaleDraw *abstractScaleDraw() const;
    QwtAbstractScaleDraw *abstractScaleDraw();

    virtual void scaleChange();

/*private:
    void updateScaleDraw();

    class PrivateData;
    PrivateData *d_data;*/
};
