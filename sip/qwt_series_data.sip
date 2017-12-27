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
    QwtArraySeriesData( const QVector<T> &samples );
    void setSamples( const QVector<T> &samples );
    const QVector<T> samples() const;
    virtual size_t size() const;
    virtual T sample( size_t index ) const;
protected:
    QVector<T> d_samples;
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
    QwtArraySeriesDataQPointF( const QVector<QPointF> &samples );
    void setSamples( const QVector<QPointF> &samples );
    const QVector<QPointF> samples() const;
    virtual size_t size() const;
    virtual QPointF sample( size_t index ) const;
//protected:
//    QVector<T> d_samples;
};

/*
class QwtTradingChartData: public QwtArraySeriesData<QwtOHLCSample>
{
public:
    QwtTradingChartData(
        const QVector<QwtOHLCSample> & = QVector<QwtOHLCSample>() );

    virtual QRectF boundingRect() const;
};


template <typename T, typename LessThan>
inline int qwtUpperSampleIndex( const QwtSeriesData<T> &series,
    double value, LessThan lessThan  ) 
{
    const int indexMax = series.size() - 1;

    if ( indexMax < 0 || !lessThan( value, series.sample( indexMax ) )  )
        return -1;

    int indexMin = 0;
    int n = indexMax;

    while ( n > 0 )
    {
        const int half = n >> 1;
        const int indexMid = indexMin + half;

        if ( lessThan( value, series.sample( indexMid ) ) )
        {
            n = half;
        }
        else
        {
            indexMin = indexMid + 1;
            n -= half + 1;
        }
    }

    return indexMin;
}
*/
