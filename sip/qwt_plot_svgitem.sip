/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief A plot item, which displays
         data in Scalable Vector Graphics (SVG) format.

  SVG images are often used to display maps
*/

class QwtPlotSvgItem: public QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_svgitem.h>
%End
public:
    explicit QwtPlotSvgItem( const QString& title = QString() );
    explicit QwtPlotSvgItem( const QwtText& title );
    virtual ~QwtPlotSvgItem();

    bool loadFile( const QRectF&, const QString &fileName );
    bool loadData( const QRectF&, const QByteArray & );

/*    
private:
    void init();

    class PrivateData;
    PrivateData *d_data;
    */
};


