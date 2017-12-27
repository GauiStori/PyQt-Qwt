/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotLayout
{
%TypeHeaderCode
#include <qwt_plot_layout.h>
%End
public:
    /*!
      Options to configure the plot layout engine
      \sa activate(), QwtPlotRenderer
     */
    enum Option
    {
        //! Unused
        AlignScales = 0x01,

        /*!
          Ignore the dimension of the scrollbars. There are no
          scrollbars, when the plot is not rendered to widgets.
         */
        IgnoreScrollbars = 0x02,

        //! Ignore all frames. 
        IgnoreFrames = 0x04,

        //! Ignore the legend.
        IgnoreLegend = 0x08,

        //! Ignore the title.
        IgnoreTitle = 0x10,

        //! Ignore the footer.
        IgnoreFooter = 0x20
    };

    //! Layout options
    //typedef QFlags<Option> Options;

    explicit QwtPlotLayout();
    virtual ~QwtPlotLayout();

    void setCanvasMargin( int margin, int axis = -1 );
    int canvasMargin( int axis ) const;

    void setAlignCanvasToScales( bool );

    void setAlignCanvasToScale( int axisId, bool );
    bool alignCanvasToScale( int axisId ) const;

    void setSpacing( int );
    int spacing() const;

    void setLegendPosition( QwtPlot::LegendPosition pos, double ratio );
    void setLegendPosition( QwtPlot::LegendPosition pos );
    QwtPlot::LegendPosition legendPosition() const;

    void setLegendRatio( double ratio );
    double legendRatio() const;

    virtual QSize minimumSizeHint( const QwtPlot * ) const;

    /*virtual void activate( const QwtPlot *,
        const QRectF &rect, Options options = 0x00 );*/

    virtual void invalidate();

    QRectF titleRect() const;
    QRectF footerRect() const;
    QRectF legendRect() const;
    QRectF scaleRect( int axis ) const;
    QRectF canvasRect() const;

    class LayoutData;

protected:

    void setTitleRect( const QRectF & );
    void setFooterRect( const QRectF & );
    void setLegendRect( const QRectF & );
    void setScaleRect( int axis, const QRectF & );
    void setCanvasRect( const QRectF & );

    //QRectF layoutLegend( Options options, const QRectF & ) const;
    QRectF alignLegend( const QRectF &canvasRect,
        const QRectF &legendRect ) const;

    /*void expandLineBreaks( Options options, const QRectF &rect,
        int &dimTitle, int &dimFooter, int dimAxes[QwtPlot::axisCnt] ) const;

    void alignScales( Options options, QRectF &canvasRect,
        QRectF scaleRect[QwtPlot::axisCnt] ) const;*/

/*private:
    class PrivateData;

    PrivateData *d_data;*/
};
