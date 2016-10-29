/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPointArrayData: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_point_data.h>
%End

public:
    QwtPointArrayData( const QVector<double> &x, const QVector<double> &y );
    //QwtPointArrayData( const double *x, const double *y, size_t size ); FIXME

    virtual QRectF boundingRect() const;

    virtual size_t size() const;
    virtual QPointF sample( size_t i ) const;

    const QVector<double> &xData() const;
    const QVector<double> &yData() const;

/*private:
    QVector<double> d_x;
    QVector<double> d_y;*/
};

/*!
  \brief Data class containing two pointers to memory blocks of doubles.
 */
/*class QwtCPointerData: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_point_data.h>
%End

public:
    //QwtCPointerData( const double *x, const double *y, size_t size ); FIXME

    virtual QRectF boundingRect() const;
    virtual size_t size() const;
    virtual QPointF sample( size_t i ) const;

    const double *xData() const;
    const double *yData() const;
*/
/*private:
    const double *d_x;
    const double *d_y;
    size_t d_size;*/
//};


/*class SinusData: QwtSyntheticPointData FIXME
{
%TypeHeaderCode
#include <qwt_point_data.h>
%End
public:
    SinusData();
    virtual double y( double x ) const;
};*/

class QwtSyntheticPointData: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_point_data.h>
%End
public:
    QwtSyntheticPointData( size_t size,
        const QwtInterval & = QwtInterval() );

    void setSize( size_t size );
    virtual size_t size() const;

    void setInterval( const QwtInterval& );
    QwtInterval interval() const;

    virtual QRectF boundingRect() const;
    virtual QPointF sample( size_t i ) const;

    virtual double y( double x ) const = 0;
    virtual double x( uint index ) const;

    virtual void setRectOfInterest( const QRectF & );
    QRectF rectOfInterest() const;

/*private:
    size_t d_size;
    QwtInterval d_interval;
    QRectF d_rectOfInterest;
    QwtInterval d_intervalOfInterest;*/
};

