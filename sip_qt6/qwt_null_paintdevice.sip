/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtNullPaintDevice: QPaintDevice
{
%TypeHeaderCode
#include <qwt_null_paintdevice.h>
%End
public:
    enum Mode
    {
        NormalMode, 
        PolygonPathMode,
        PathMode
    };

    QwtNullPaintDevice();
    virtual ~QwtNullPaintDevice();

    void setMode( Mode );
    Mode mode() const;

    virtual QPaintEngine *paintEngine() const;

    virtual int metric( PaintDeviceMetric metric ) const;

    virtual void drawRects(const QRect *, int );
    virtual void drawRects(const QRectF *, int );

    virtual void drawLines(const QLine *, int );
    virtual void drawLines(const QLineF *, int );

    virtual void drawEllipse(const QRectF &);
    virtual void drawEllipse(const QRect &);

    virtual void drawPath(const QPainterPath &);

    virtual void drawPoints(const QPointF *, int );
    virtual void drawPoints(const QPoint *, int );

    virtual void drawPolygon(
        const QPointF *, int , QPaintEngine::PolygonDrawMode );

    virtual void drawPolygon(
        const QPoint *, int , QPaintEngine::PolygonDrawMode );

    virtual void drawPixmap(const QRectF &,
        const QPixmap &, const QRectF &);

    virtual void drawTextItem(const QPointF &, const QTextItem &);

    virtual void drawTiledPixmap(const QRectF &,
        const QPixmap &, const QPointF &s);

    virtual void drawImage(const QRectF &,
        const QImage &, const QRectF &, Qt::ImageConversionFlags );

    virtual void updateState( const QPaintEngineState &state );

protected:
    //! \return Size needed to implement metric()
    virtual QSize sizeMetrics() const = 0;

/*private:
    class PaintEngine;
    PaintEngine *d_engine;

    class PrivateData;
    PrivateData *d_data;*/
};
