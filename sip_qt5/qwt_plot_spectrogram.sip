/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotSpectrogram: QwtPlotRasterItem
{
%TypeHeaderCode
#include <qwt_plot_spectrogram.h>
%End
public:
    /*!
      The display mode controls how the raster data will be represented.
      \sa setDisplayMode(), testDisplayMode()
    */

    enum DisplayMode
    {
        //! The values are mapped to colors using a color map.
        ImageMode = 0x01,

        //! The data is displayed using contour lines
        ContourMode = 0x02
    };

    //! Display modes
    typedef QFlags<QwtPlotSpectrogram::DisplayMode> DisplayModes;

    explicit QwtPlotSpectrogram( const QString &title = QString::null );
    virtual ~QwtPlotSpectrogram();

    void setDisplayMode( QwtPlotSpectrogram::DisplayMode, bool on = true );
    bool testDisplayMode( QwtPlotSpectrogram::DisplayMode ) const;

    void setData( QwtRasterData *data /Transfer/);
    //const QwtRasterData *data() const;
    QwtRasterData *data();

    void setColorMap( QwtColorMap * /Transfer/);
    //const QwtColorMap *colorMap() const;

    virtual QwtInterval interval(Qt::Axis) const;
    virtual QRectF pixelHint( const QRectF & ) const;

    void setDefaultContourPen( const QColor &, 
        qreal width = 0.0, Qt::PenStyle = Qt::SolidLine );
    void setDefaultContourPen( const QPen & );
    QPen defaultContourPen() const;

    virtual QPen contourPen( double level ) const;

    void setConrecFlag( QwtRasterData::ConrecFlag, bool on );
    bool testConrecFlag( QwtRasterData::ConrecFlag ) const;

    void setContourLevels( const QList<double> & );
    QList<double> contourLevels() const;

    virtual int rtti() const;

    virtual void draw( QPainter *p,
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &rect ) const;

protected:
    virtual QImage renderImage(
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &area, const QSize &imageSize ) const;

    virtual QSize contourRasterSize(
        const QRectF &, const QRect & ) const;

    //virtual QwtRasterData::ContourLines renderContourLines(
    //    const QRectF &rect, const QSize &raster ) const; FIXME

    //virtual void drawContourLines( QPainter *p,
    //    const QwtScaleMap &xMap, const QwtScaleMap &yMap,
    //    const QwtRasterData::ContourLines& lines ) const;FIXME

    void renderTile( const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRect &imageRect, QImage *image ) const;

};

