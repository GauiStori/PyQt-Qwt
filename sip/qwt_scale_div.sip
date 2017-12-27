/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
class QwtScaleDiv
{
%TypeHeaderCode
#include <qwt_scale_div.h>
%End
public:
    //! Scale tick types
    enum TickType
    {
        //! No ticks
        NoTick = -1,

        //! Minor ticks
        MinorTick,

        //! Medium ticks
        MediumTick,

        //! Major ticks
        MajorTick,

        //! Number of valid tick types
        NTickTypes
    };

    explicit QwtScaleDiv( double lowerBound = 0.0, 
        double upperBound = 0.0 );

    //explicit QwtScaleDiv( const QwtInterval &, QList<double>[NTickTypes] );

    /*explicit QwtScaleDiv( double lowerBound, double upperBound,
        QList<double>[NTickTypes] );*/

    explicit QwtScaleDiv( double lowerBound, double upperBound, 
        const QList<double> &minorTicks, const QList<double> &mediumTicks,
        const QList<double> &majorTicks );

    bool operator==( const QwtScaleDiv & ) const;
    bool operator!=( const QwtScaleDiv & ) const;

    void setInterval( double lowerBound, double upperBound );
    void setInterval( const QwtInterval & );
    QwtInterval interval() const;

    void setLowerBound( double );
    double lowerBound() const;

    void setUpperBound( double );
    double upperBound() const;

    double range() const;

    bool contains( double value ) const;

    void setTicks( int tickType, const QList<double> & );
    QList<double> ticks( int tickType ) const;

    bool isEmpty() const;
    bool isIncreasing() const;

    void invert();
    QwtScaleDiv inverted() const;

    QwtScaleDiv bounded( double lowerBound, double upperBound ) const;

/*private:
    double d_lowerBound;
    double d_upperBound;
    QList<double> d_ticks[NTickTypes];*/
};
