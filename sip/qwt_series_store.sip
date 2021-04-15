/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
class QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
%End
protected:
    virtual ~QwtAbstractSeriesStore();
    virtual void dataChanged();
    virtual void setRectOfInterest( const QRectF & );
    virtual QRectF dataRect() const;
    virtual size_t dataSize() const;
//private:
//    QwtAbstractSeriesStore();
};

class QwtSeriesStoreQwtIntervalSample: QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
typedef QwtSeriesStore<QwtIntervalSample> QwtSeriesStoreQwtIntervalSample;
%End
public:
    explicit QwtSeriesStoreQwtIntervalSample();
    //QwtSeriesStoreQwtIntervalSample();
    ~QwtSeriesStoreQwtIntervalSample();
    void setData( QwtSeriesDataQwtIntervalSample *series );
    QwtSeriesDataQwtIntervalSample *data();
    //const QwtSeriesData *data() const;
    QwtIntervalSample sample( int index ) const;
    virtual size_t dataSize() const;
    virtual QRectF dataRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
    QwtSeriesDataQwtIntervalSample *swapData( QwtSeriesDataQwtIntervalSample *series );
};

class QwtSeriesStoreQPointF: QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
typedef QwtSeriesStore<QPointF> QwtSeriesStoreQPointF;
%End
public:
    explicit QwtSeriesStoreQPointF();
    //QwtSeriesStoreQPointF();
    ~QwtSeriesStoreQPointF();
    void setData( QwtSeriesDataQPointF *series );
    QwtSeriesDataQPointF *data();
    //const QwtSeriesData *data() const;
    QPointF sample( int index ) const;
    virtual size_t dataSize() const;
    virtual QRectF dataRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
    QwtSeriesDataQPointF *swapData( QwtSeriesDataQPointF *series );
};

class QwtSeriesStoreQwtPoint3D: QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
typedef QwtSeriesStore<QwtPoint3D> QwtSeriesStoreQwtPoint3D;
%End
public:
    explicit QwtSeriesStoreQwtPoint3D();
    ~QwtSeriesStoreQwtPoint3D();
    void setData( QwtSeriesDataQwtPoint3D *series );
    QwtSeriesDataQwtPoint3D *data();
    //const QwtSeriesData *data() const;
    QwtPoint3D sample( int index ) const;
    virtual size_t dataSize() const;
    virtual QRectF dataRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
    QwtSeriesDataQwtPoint3D *swapData( QwtSeriesDataQwtPoint3D *series );
};

class QwtSeriesStoreQwtOHLCSample: public QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
typedef QwtSeriesStore<QwtOHLCSample> QwtSeriesStoreQwtOHLCSample;
%End
public:
    explicit QwtSeriesStoreQwtOHLCSample();
    ~QwtSeriesStoreQwtOHLCSample();
    void setData( QwtSeriesDataQwtOHLCSample *series );
    QwtSeriesDataQwtOHLCSample *data();
    //const QwtSeriesDataQwtOHLCSample *data() const;
    QwtOHLCSample sample( int index ) const;
    virtual size_t dataSize() const;
    virtual QRectF dataRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
    QwtSeriesDataQwtOHLCSample *swapData( QwtSeriesDataQwtOHLCSample *series );
};



class QwtSeriesStoreQwtSetSample: QwtAbstractSeriesStore
{
%TypeHeaderCode
#include <qwt_series_store.h>
typedef QwtSeriesStore<QwtSetSample> QwtSeriesStoreQwtSetSample;
%End
public:
    explicit QwtSeriesStoreQwtSetSample();
    //QwtSeriesStoreQPointF();
    ~QwtSeriesStoreQwtSetSample();
    void setData( QwtSeriesDataQwtSetSample *series );
    QwtSeriesDataQwtSetSample *data();
    //const QwtSeriesData *data() const;
    QwtSetSample sample( int index ) const;
    virtual size_t dataSize() const;
    virtual QRectF dataRect() const;
    virtual void setRectOfInterest( const QRectF &rect );
    QwtSeriesDataQwtSetSample *swapData( QwtSeriesDataQwtSetSample *series );
};

