/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotAbstractBarChart: QwtPlotSeriesItem
{
%TypeHeaderCode
#include <qwt_plot_abstract_barchart.h>
%End
public:
    enum LayoutPolicy
    {
        AutoAdjustSamples,
        ScaleSamplesToAxes,
        ScaleSampleToCanvas,
        FixedSampleSize
    };

    explicit QwtPlotAbstractBarChart( const QwtText &title );
    virtual ~QwtPlotAbstractBarChart();

    void setLayoutPolicy( QwtPlotAbstractBarChart::LayoutPolicy );
    QwtPlotAbstractBarChart::LayoutPolicy layoutPolicy() const;

    void setLayoutHint( double );
    double layoutHint() const;

    void setSpacing( int );
    int spacing() const;

    void setMargin( int );
    int margin() const;

    void setBaseline( double );
    double baseline() const;

    virtual void getCanvasMarginHint( 
        const QwtScaleMap &xMap, const QwtScaleMap &yMap,
        const QRectF &canvasRect,
        double &left, double &top, double &right, double &bottom) const;


protected:
    double sampleWidth( const QwtScaleMap &map,
        double canvasSize, double dataSize,
        double value ) const;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
