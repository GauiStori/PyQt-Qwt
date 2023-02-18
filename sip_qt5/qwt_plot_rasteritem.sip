/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotRasterItem: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_rasteritem.h>
%End
public:
    enum CachePolicy
    {
        NoCache,
        PaintCache
    };

    enum PaintAttribute
    {
        PaintInDeviceResolution = 1
    };

    typedef QFlags<QwtPlotRasterItem::PaintAttribute> PaintAttributes;

    explicit QwtPlotRasterItem( const QString& title = QString::null );
    explicit QwtPlotRasterItem( const QwtText& title );
    virtual ~QwtPlotRasterItem();

    void setPaintAttribute( QwtPlotRasterItem::PaintAttribute, bool on = true );
    bool testPaintAttribute( QwtPlotRasterItem::PaintAttribute ) const;

    void setAlpha( int alpha );
    int alpha() const;

    void setCachePolicy( CachePolicy );
    CachePolicy cachePolicy() const;

    void invalidateCache();

    virtual void draw( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &rect ) const;

    virtual QRectF pixelHint( const QRectF & ) const;

    virtual QwtInterval interval(Qt::Axis) const;
    virtual QRectF boundingRect() const;

protected:
    virtual QImage renderImage( const QwtScaleMap &xMap,
        const QwtScaleMap &yMap, const QRectF &area,
        const QSize &imageSize ) const = 0;

    virtual QwtScaleMap imageMap( Qt::Orientation,
        const QwtScaleMap &map, const QRectF &area,
        const QSize &imageSize, double pixelSize) const;

private:
    QwtPlotRasterItem( const QwtPlotRasterItem & );
    //QwtPlotRasterItem &operator=( const QwtPlotRasterItem & );

/*    void init();

    QImage compose( const QwtScaleMap &, const QwtScaleMap &,
        const QRectF &imageArea, const QRectF &paintRect,
        const QSize &imageSize, bool doCache) const;


    class PrivateData;
    PrivateData *d_data;*/
};
