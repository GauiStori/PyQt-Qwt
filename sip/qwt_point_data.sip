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
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End

public:
    QwtPointArrayData( const QVector<double> &x, const QVector<double> &y );
    
      	
    QwtPointArrayData(QVector<double> &,QVector<double> &)[( const double *x, const double *y, size_t size )];
    
    %MethodCode
         //QVector<double> d_x;
         //QVector<double> d_y;
         //size_t size;
         //const double*x;
	//const double*y;
	//d_x.resize( size );
    	//::memcpy( d_x.data(), x, size * sizeof( double ) );

    	//d_y.resize( size );
    	//::memcpy( d_y.data(), y, size * sizeof( double ) );
    %End
     
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
class QwtCPointerData: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_point_data.h>
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End

public:
    QwtCPointerData(SIP_PYLIST,SIP_PYLIST,size_t size)[( const double *x, const double *y, size_t size )];
    %MethodCode
    //const double *d_x;
    //const double *d_y;
    //size_t d_size;
    //size_t size;
    //const double*x;
    //const double*y;
    //d_x = x ;
    //d_y = y ;
    //d_size =  size ;	
    %End 
    
    
    virtual QRectF boundingRect() const;
    virtual size_t size() const;
    virtual QPointF sample( size_t i ) const;

    //const double *xData() const;
    //const double *yData() const;

    const SIP_PYLIST xData() const;
     %MethodCode
	//const double *d_x;
	//return d_x;	
    %End
     const SIP_PYLIST yData() const;	
      %MethodCode
	//const double *d_y;
	//return d_y;	
    %End
	


/*private:
    const double *d_x;
    const double *d_y;
    size_t d_size;*/
};

class QwtSyntheticPointData: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_point_data.h>
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
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




