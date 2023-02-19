/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
//class QwtPlot;
//class QPixmap;
%ModuleHeaderCode
// fix to allow compilation with sip that for some reason
// doesn't add this include to the file where the code from
// ConvertToSubClassCode goes.
#include <qwt_plot_canvas.h>
%End


class QwtPlotCanvas : QFrame
{
%TypeHeaderCode
#include <qwt_plot_canvas.h>
%End
%ConvertToSubClassCode
    if ( qobject_cast<QwtPlotCanvas *>( sipCpp ) )
      sipType = sipType_QwtPlotCanvas;
    else
      sipType = NULL;
%End
//    Q_OBJECT

//    Q_PROPERTY( double borderRadius READ borderRadius WRITE setBorderRadius )

public:

    /*!
      \brief Paint attributes

      The default setting enables BackingStore and Opaque.

      \sa setPaintAttribute(), testPaintAttribute()
     */
    enum PaintAttribute
    {
        BackingStore = 1,
        Opaque       = 2,
        HackStyledBackground = 4,
        ImmediatePaint = 8
    };

    //! Paint attributes
    //typedef QFlags<PaintAttribute> PaintAttributes;
    enum FocusIndicator
    {
        NoFocusIndicator,
        CanvasFocusIndicator,
        ItemFocusIndicator
    };

    explicit QwtPlotCanvas( QwtPlot * = NULL );
    virtual ~QwtPlotCanvas();

    QwtPlot *plot();
    //const QwtPlot *plot() const;

    void setFocusIndicator( FocusIndicator );
    FocusIndicator focusIndicator() const;

    void setBorderRadius( double );
    double borderRadius() const;

    void setPaintAttribute( PaintAttribute, bool on = true );
    bool testPaintAttribute( PaintAttribute ) const;

    const QPixmap *backingStore() const;
    void invalidateBackingStore();

    virtual bool event( QEvent * );

    //Q_INVOKABLE QPainterPath borderPath( const QRect & ) const;

public slots:
    void replot();

protected:
    virtual void paintEvent( QPaintEvent * );
    virtual void resizeEvent( QResizeEvent * );

    virtual void drawFocusIndicator( QPainter * );
    virtual void drawBorder( QPainter * );

    void updateStyleSheetInfo();

private:
    void drawCanvas( QPainter *, bool withBackground );
};

