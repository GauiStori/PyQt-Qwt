/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtRasterData
{
%TypeHeaderCode
#include <qwt_raster_data.h>
%End
public:
    typedef QMap<double, QPolygonF> ContourLines;
    enum ConrecFlag
    {
        IgnoreAllVerticesOnLevel = 0x01,
        IgnoreOutOfRange = 0x02
    };
    typedef QFlags<QwtRasterData::ConrecFlag> ConrecFlags;

    QwtRasterData();
    virtual ~QwtRasterData();

    virtual void setInterval( Qt::Axis, const QwtInterval & );
    const QwtInterval &interval(Qt::Axis) const;

    virtual QRectF pixelHint( const QRectF & ) const;

    virtual void initRaster( const QRectF &, const QSize& raster );
    virtual void discardRaster();

    virtual double value( double x, double y ) const = 0;

    /*virtual ContourLines contourLines( const QRectF &rect,
        const QSize &raster, const QList<double> &levels,
        ConrecFlags ) const;FIXME*/

    class Contour3DPoint;
    class ContourPlane;

private:
    // Disabled copy constructor and operator=
    QwtRasterData( const QwtRasterData & );
    //QwtRasterData &operator=( const QwtRasterData & );

    //QwtInterval d_intervals[3];
};

/*inline const QwtInterval &QwtRasterData::interval( Qt::Axis axis) const
{
    return d_intervals[axis];
}

Q_DECLARE_OPERATORS_FOR_FLAGS( QwtRasterData::ConrecFlags )
*/
