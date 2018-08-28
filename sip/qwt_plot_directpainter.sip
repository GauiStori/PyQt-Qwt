/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPlotDirectPainter: QObject
{
%TypeHeaderCode
#include <qwt_plot_directpainter.h>
%End
public:
    enum Attribute
    {
        AtomicPainter = 0x01,
        FullRepaint = 0x02,
        CopyBackingStore = 0x04
    };

    typedef QFlags<QwtPlotDirectPainter::Attribute> Attributes;

    QwtPlotDirectPainter( QObject *parent /TransferThis/ = NULL );
    virtual ~QwtPlotDirectPainter();

    void setAttribute( Attribute, bool on );
    bool testAttribute( Attribute ) const;

    void setClipping( bool );
    bool hasClipping() const;

    void setClipRegion( const QRegion & );
    QRegion clipRegion() const;

    void drawSeries( QwtPlotSeriesItem * /Transfer/, int from, int to );
    void reset();

    virtual bool eventFilter( QObject *, QEvent * );

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};

//Q_DECLARE_OPERATORS_FOR_FLAGS( QwtPlotDirectPainter::Attributes )
