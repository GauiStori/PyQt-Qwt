/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtIntervalSample
{
%TypeHeaderCode
#include <qwt_samples.h>
%End
public:
    QwtIntervalSample();
    QwtIntervalSample( double, const QwtInterval & );
    QwtIntervalSample( double value, double min, double max );

    bool operator==( const QwtIntervalSample & ) const;
    bool operator!=( const QwtIntervalSample & ) const;

    //! Value
    double value;

    //! Interval
    QwtInterval interval;
};

class QwtSetSample
{
%TypeHeaderCode
#include <qwt_samples.h>
%End
public:
    QwtSetSample();
    QwtSetSample( double, const QVector<double> & = QVector<double>() );

    bool operator==( const QwtSetSample &other ) const;
    bool operator!=( const QwtSetSample &other ) const;

    double added() const;
    double value;
    QVector<double> set;
};

class QwtOHLCSample
{
%TypeHeaderCode
#include <qwt_samples.h>
%End
public:
    
    QwtOHLCSample( double time = 0.0,
        double open = 0.0, double high = 0.0,
        double low = 0.0, double close = 0.0 );

    QwtInterval boundingInterval() const;

    bool isValid() const;
    double time;

    //! Opening price
    double open;

    //! Highest price
    double high;

    //! Lowest price
    double low;

    //! Closing price
    double close;
};

