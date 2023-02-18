/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtGraphic: QwtNullPaintDevice
{
%TypeHeaderCode
#include <qwt_graphic.h>
%End
public:
    enum RenderHint
    {
        RenderPensUnscaled = 0x1
    };
    typedef QFlags<QwtGraphic::RenderHint> RenderHints;

    QwtGraphic();
    QwtGraphic( const QwtGraphic & );

    virtual ~QwtGraphic();


    void reset();

    bool isNull() const;
    bool isEmpty() const;

    void render( QPainter * ) const;

    void render( QPainter *, const QSizeF &, 
            Qt::AspectRatioMode = Qt::IgnoreAspectRatio  ) const;

    void render( QPainter *, const QRectF &, 
            Qt::AspectRatioMode = Qt::IgnoreAspectRatio  ) const;

    void render( QPainter *, const QPointF &,
        Qt::Alignment = Qt::AlignTop | Qt::AlignLeft ) const;

    QPixmap toPixmap() const; 
    QPixmap toPixmap( const QSize &, 
        Qt::AspectRatioMode = Qt::IgnoreAspectRatio  ) const;

    QImage toImage() const; 
    QImage toImage( const QSize &, 
        Qt::AspectRatioMode = Qt::IgnoreAspectRatio  ) const;

    QRectF scaledBoundingRect( double sx, double sy ) const;

    QRectF boundingRect() const;
    QRectF controlPointRect() const;

    //const QVector< QwtPainterCommand > &commands() const; FIXME
    //void setCommands( QVector< QwtPainterCommand > & ); FIXME

    void setDefaultSize( const QSizeF & );
    QSizeF defaultSize() const;
    
    void setRenderHint( QwtGraphic::RenderHint, bool on = true );
    bool testRenderHint( QwtGraphic::RenderHint ) const;

protected:
    virtual QSize sizeMetrics() const;

    virtual void drawPath( const QPainterPath & );

    virtual void drawPixmap( const QRectF &,
        const QPixmap &, const QRectF & );

    virtual void drawImage( const QRectF &,
        const QImage &, const QRectF &, Qt::ImageConversionFlags );

    virtual void updateState( const QPaintEngineState &state );

private:
    QwtGraphic& operator=( const QwtGraphic & );
/*    void updateBoundingRect( const QRectF & );
    void updateControlPointRect( const QRectF & );

    class PathInfo;

    class PrivateData;
    PrivateData *d_data;*/
};

//Q_DECLARE_OPERATORS_FOR_FLAGS( QwtGraphic::RenderHints )
//Q_DECLARE_METATYPE( QwtGraphic )
