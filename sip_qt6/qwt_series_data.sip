/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

/*template <typename T>
class QwtSeriesData
{
public:
    QwtSeriesData();
    virtual ~QwtSeriesData();
    virtual size_t size() const;
    virtual T sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
protected:
    mutable QRectF d_boundingRect;
};*/

%If(- Qwt_6_2_0)
class QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End
public:
    QwtSeriesDataQPointF();
    virtual ~QwtSeriesDataQPointF();
    virtual size_t size() const;
    virtual QPointF sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQPointF &operator=( const QwtSeriesDataQPointF& );
};

class QwtSeriesDataQwtPointPolar
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtPointPolar> QwtSeriesDataQwtPointPolar;
%End
public:
    QwtSeriesDataQwtPointPolar();
    virtual ~QwtSeriesDataQwtPointPolar();
    virtual size_t size() const;
    virtual QwtPointPolar sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtPointPolar &operator=( const QwtSeriesDataQwtPointPolar& );
};




class QwtSeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
public:
    QwtSeriesDataQwtPoint3D();
    virtual ~QwtSeriesDataQwtPoint3D();
    virtual size_t size() const;
    virtual QwtPoint3D sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtPoint3D &operator=( const QwtSeriesDataQwtPoint3D& );
};

class QwtSeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End
public:
    QwtSeriesDataQwtOHLCSample();
    virtual ~QwtSeriesDataQwtOHLCSample();
    virtual size_t size() const;
    virtual QwtOHLCSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtOHLCSample &operator=( const QwtSeriesDataQwtOHLCSample& );
};



class QwtSeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
public:
    QwtSeriesDataQwtSetSample();
    virtual ~QwtSeriesDataQwtSetSample();
    virtual size_t size() const;
    virtual QwtSetSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQPointF &operator=( const QwtSeriesDataQPointF& );
};

class QwtSeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
public:
    QwtSeriesDataQwtIntervalSample();
    virtual ~QwtSeriesDataQwtIntervalSample();
    virtual size_t size() const;
    virtual QwtIntervalSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtIntervalSample &operator=( const QwtSeriesDataQwtIntervalSample& );
};






/*template <typename T>
class QwtArraySeriesData: public QwtSeriesData<T>
{
public:
    QwtArraySeriesData();
    QwtArraySeriesData( const QList<T> &samples );
    void setSamples( const QList<T> &samples );
    const QList<T> samples() const;
    virtual size_t size() const;
    virtual T sample( size_t index ) const;
protected:
    QList<T> d_samples;
};*/




class QwtArraySeriesDataQPointF: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QPointF> QwtArraySeriesDataQPointF;
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End
public:
    QwtArraySeriesDataQPointF();
    QwtArraySeriesDataQPointF( const QList<QPointF> &samples );
    void setSamples( const QList<QPointF> &samples );
    const QList<QPointF> samples() const;
    virtual size_t size() const;
    virtual QPointF sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};

class QwtArraySeriesDataQwtPoint3D: QwtSeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtPoint3D> QwtArraySeriesDataQwtPoint3D;
typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
public:
    QwtArraySeriesDataQwtPoint3D();
    QwtArraySeriesDataQwtPoint3D( const QList<QwtPoint3D> &samples );
    void setSamples( const QList<QwtPoint3D> &samples );
    const QList<QwtPoint3D> samples() const;
    virtual size_t size() const;
    virtual QwtPoint3D sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};


class QwtArraySeriesDataQwtOHLCSample: public QwtSeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtOHLCSample> QwtArraySeriesDataQwtOHLCSample;
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End
public:
    QwtArraySeriesDataQwtOHLCSample();
    QwtArraySeriesDataQwtOHLCSample( const QList<QwtOHLCSample> &samples );
    void setSamples( const QList<QwtOHLCSample> &samples );
    const QList<QwtOHLCSample> samples() const;
    virtual size_t size() const;
    virtual QwtOHLCSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};



class QwtArraySeriesDataQwtSetSample: QwtSeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtSetSample> QwtArraySeriesDataQwtSetSample;
typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
public:
    QwtArraySeriesDataQwtSetSample();
    QwtArraySeriesDataQwtSetSample( const QList<QwtSetSample> &samples );
    void setSamples( const QList<QwtSetSample> &samples );
    const QList<QwtSetSample> samples() const;
    virtual size_t size() const;
    virtual QwtSetSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};

class QwtArraySeriesDataQwtIntervalSample: QwtSeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtIntervalSample> QwtArraySeriesDataQwtIntervalSample;
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
public:
    QwtArraySeriesDataQwtIntervalSample();
    QwtArraySeriesDataQwtIntervalSample( const QList<QwtIntervalSample> &samples );
    void setSamples( const QList<QwtIntervalSample> &samples );
    const QList<QwtIntervalSample> samples() const;
    virtual size_t size() const;
    virtual QwtIntervalSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};


//! Interface for iterating over an array of points
class QwtPointSeriesData: public QwtArraySeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QPointF> QwtArraySeriesDataQPointF;
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;

%End

public:
    QwtPointSeriesData(
        const QList<QPointF> & = QList<QPointF>() );

    virtual QRectF boundingRect() const;
};

//! Interface for iterating over an array of 3D points
class QwtPoint3DSeriesData: public QwtArraySeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtPoint3D> QwtArraySeriesDataQwtPoint3D;
typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
public:
    QwtPoint3DSeriesData(
        const QList<QwtPoint3D> & = QList<QwtPoint3D>() );
    virtual QRectF boundingRect() const;
};

//! Interface for iterating over an array of intervals
class QwtIntervalSeriesData: public QwtArraySeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtIntervalSample> QwtArraySeriesDataQwtIntervalSample;
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End

public:
    QwtIntervalSeriesData(
        const QList<QwtIntervalSample> & = QList<QwtIntervalSample>() );

    virtual QRectF boundingRect() const;
};






//! Interface for iterating over an array of samples
class QwtSetSeriesData: public QwtArraySeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtSetSample> QwtArraySeriesDataQwtSetSample;
typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;

%End

public:
    QwtSetSeriesData(
        const QList<QwtSetSample> & = QList<QwtSetSample>() );

    virtual QRectF boundingRect() const;
};


/*!
    Interface for iterating over an array of OHLC samples
*/


class QwtTradingChartData: public QwtArraySeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtOHLCSample> QwtArraySeriesDataQwtOHLCSample;
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End

public:
    QwtTradingChartData(
        const QList<QwtOHLCSample> & = QList<QwtOHLCSample>() );

    virtual QRectF boundingRect() const;
};

QRectF qwtBoundingRect(const QwtSeriesDataQPointF &, int from = 0, int to = -1 );
QRectF qwtBoundingRect(const QwtSeriesDataQwtPoint3D &, int from = 0, int to = -1 );

QRectF qwtBoundingRect(const QwtSeriesDataQwtPointPolar &, int from = 0, int to = -1 );

QRectF qwtBoundingRect(const QwtSeriesDataQwtIntervalSample &, int from = 0, int to = -1 );

QRectF qwtBoundingRect(const QwtSeriesDataQwtSetSample &, int from = 0, int to = -1 );

QRectF qwtBoundingRect(const QwtSeriesDataQwtOHLCSample &, int from = 0, int to = -1 );

%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End
public:
    QwtSeriesDataQPointF();
    virtual ~QwtSeriesDataQPointF();
    virtual size_t size() const;
    virtual QPointF sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
private:
    QwtSeriesDataQPointF& operator=( const QwtSeriesDataQPointF& );
};

class QwtSeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
public:
    QwtSeriesDataQwtPoint3D();
    virtual ~QwtSeriesDataQwtPoint3D();
    virtual size_t size() const;
    virtual QwtPoint3D sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtPoint3D &operator=( const QwtSeriesDataQwtPoint3D& );
};

class QwtSeriesDataQwtPointPolar
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtPointPolar> QwtSeriesDataQwtPointPolar;
%End
public:
    QwtSeriesDataQwtPointPolar();
    virtual ~QwtSeriesDataQwtPointPolar();
    virtual size_t size() const;
    virtual QwtPointPolar sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtPointPolar &operator=( const QwtSeriesDataQwtPointPolar& );
};

class QwtSeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
public:
    QwtSeriesDataQwtIntervalSample();
    virtual ~QwtSeriesDataQwtIntervalSample();
    virtual size_t size() const;
    virtual QwtIntervalSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtIntervalSample &operator=( const QwtSeriesDataQwtIntervalSample& );
};

class QwtSeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
public:
    QwtSeriesDataQwtSetSample();
    virtual ~QwtSeriesDataQwtSetSample();
    virtual size_t size() const;
    virtual QwtSetSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQPointF &operator=( const QwtSeriesDataQPointF& );
};


/*template <typename T>
class QwtArraySeriesData: public QwtSeriesData<T>
{
public:
    QwtArraySeriesData();
    QwtArraySeriesData( const QList<T> &samples );
    void setSamples( const QList<T> &samples );
    const QList<T> samples() const;
    virtual size_t size() const;
    virtual T sample( size_t index ) const;
protected:
    QList<T> d_samples;
};*/

class QwtSeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End
public:
    QwtSeriesDataQwtOHLCSample();
    virtual ~QwtSeriesDataQwtOHLCSample();
    virtual size_t size() const;
    virtual QwtOHLCSample sample( size_t i ) const;
    virtual QRectF boundingRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
//protected:
//    mutable QRectF d_boundingRect;
private:
    QwtSeriesDataQwtOHLCSample &operator=( const QwtSeriesDataQwtOHLCSample& );
};



class QwtArraySeriesDataQPointF: QwtSeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QPointF> QwtArraySeriesDataQPointF;
typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End
public:
    QwtArraySeriesDataQPointF();
    QwtArraySeriesDataQPointF( const QList<QPointF> &samples );
    void setSamples( const QList<QPointF> &samples );
    const QList<QPointF> samples() const;
    virtual size_t size() const;
    virtual QPointF sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};

class QwtArraySeriesDataQwtPoint3D: QwtSeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtPoint3D> QwtArraySeriesDataQwtPoint3D;
typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
public:
    QwtArraySeriesDataQwtPoint3D();
    QwtArraySeriesDataQwtPoint3D( const QList<QwtPoint3D> &samples );
    void setSamples( const QList<QwtPoint3D> &samples );
    const QList<QwtPoint3D> samples() const;
    virtual size_t size() const;
    virtual QwtPoint3D sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};


class QwtArraySeriesDataQwtOHLCSample: public QwtSeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtOHLCSample> QwtArraySeriesDataQwtOHLCSample;
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End
public:
    QwtArraySeriesDataQwtOHLCSample();
    QwtArraySeriesDataQwtOHLCSample( const QList<QwtOHLCSample> &samples );
    void setSamples( const QList<QwtOHLCSample> &samples );
    const QList<QwtOHLCSample> samples() const;
    virtual size_t size() const;
    virtual QwtOHLCSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};



class QwtArraySeriesDataQwtSetSample: QwtSeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtSetSample> QwtArraySeriesDataQwtSetSample;
typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
public:
    QwtArraySeriesDataQwtSetSample();
    QwtArraySeriesDataQwtSetSample( const QList<QwtSetSample> &samples );
    void setSamples( const QList<QwtSetSample> &samples );
    const QList<QwtSetSample> samples() const;
    virtual size_t size() const;
    virtual QwtSetSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};

class QwtArraySeriesDataQwtIntervalSample: QwtSeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtIntervalSample> QwtArraySeriesDataQwtIntervalSample;
typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
public:
    QwtArraySeriesDataQwtIntervalSample();
    QwtArraySeriesDataQwtIntervalSample( const QList<QwtIntervalSample> &samples );
    void setSamples( const QList<QwtIntervalSample> &samples );
    const QList<QwtIntervalSample> samples() const;
    virtual size_t size() const;
    virtual QwtIntervalSample sample( size_t index ) const;
//protected:
//    QList<T> d_samples;
};

//! Interface for iterating over an array of points
class QwtPointSeriesData : QwtArraySeriesDataQPointF
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QPointF> QwtArraySeriesDataQPointF;
//typedef QwtSeriesData<QPointF> QwtSeriesDataQPointF;
%End
  public:
    QwtPointSeriesData(
        const QList< QPointF >& = QList< QPointF >( ) );

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;
};

//! Interface for iterating over an array of 3D points
class QwtPoint3DSeriesData : QwtArraySeriesDataQwtPoint3D
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtPoint3D> QwtArraySeriesDataQwtPoint3D;
//typedef QwtSeriesData<QwtPoint3D> QwtSeriesDataQwtPoint3D;
%End
  public:
    QwtPoint3DSeriesData(
        const QList< QwtPoint3D >& = QList< QwtPoint3D >( ) );

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;
};

//! Interface for iterating over an array of intervals
class QwtIntervalSeriesData : QwtArraySeriesDataQwtIntervalSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtIntervalSample> QwtArraySeriesDataQwtIntervalSample;
//typedef QwtSeriesData<QwtIntervalSample> QwtSeriesDataQwtIntervalSample;
%End
  public:
    QwtIntervalSeriesData(
        const QList< QwtIntervalSample >& = QList< QwtIntervalSample >( ) );

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;
};

//! Interface for iterating over an array of samples
class QwtSetSeriesData : QwtArraySeriesDataQwtSetSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtSetSample> QwtArraySeriesDataQwtSetSample;
//typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
  public:
    QwtSetSeriesData(
        const QList< QwtSetSample >& = QList< QwtSetSample >( ) );

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;
};

/*
class QwtVectorFieldData : QwtArraySeriesDataQwtVectorFieldSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtVectorFieldSample> QwtArraySeriesDataQwtVectorFieldSample;
//typedef QwtSeriesData<QwtSetSample> QwtSeriesDataQwtSetSample;
%End
  public:
    QwtVectorFieldData(
        const QList< QwtVectorFieldSample >& = QList< QwtVectorFieldSample >( ) );

    virtual QRectF boundingRect() const;// QWT_OVERRIDE;
};
*/

class QwtTradingChartData : public QwtArraySeriesDataQwtOHLCSample
{
%TypeHeaderCode
#include <qwt_series_data.h>
typedef QwtArraySeriesData<QwtOHLCSample> QwtArraySeriesDataQwtOHLCSample;
typedef QwtSeriesData<QwtOHLCSample> QwtSeriesDataQwtOHLCSample;
%End
  public:
    QwtTradingChartData(
        const QList< QwtOHLCSample >& = QList< QwtOHLCSample >( ) );

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;
};

QRectF qwtBoundingRect( const QwtSeriesDataQPointF&, int from = 0, int to = -1 );
QRectF qwtBoundingRect( const QwtSeriesDataQwtPoint3D&, int from = 0, int to = -1 );
QRectF qwtBoundingRect( const QwtSeriesDataQwtPointPolar&, int from = 0, int to = -1 );
QRectF qwtBoundingRect( const QwtSeriesDataQwtIntervalSample&, int from = 0, int to = -1 );
QRectF qwtBoundingRect( const QwtSeriesDataQwtSetSample&, int from = 0, int to = -1 );
QRectF qwtBoundingRect( const QwtSeriesDataQwtOHLCSample&, int from = 0, int to = -1 );
//QRectF qwtBoundingRect( const QwtSeriesDataQwtVectorFieldSample&, int from = 0, int to = -1 );

%End // (Qwt_6_2_0 -)




