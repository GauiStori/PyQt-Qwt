/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/



//class QwtPlot;

/*!
  \brief QwtPlotMagnifier provides zooming, by magnifying in steps.

  Using QwtPlotMagnifier a plot can be zoomed in/out in steps using
  keys, the mouse wheel or moving a mouse button in vertical direction.

  Together with QwtPlotZoomer and QwtPlotPanner it is possible to implement
  individual and powerful navigation of the plot canvas.

  \sa QwtPlotZoomer, QwtPlotPanner, QwtPlot
*/
class QwtPlotMagnifier: public QwtMagnifier
{
%TypeHeaderCode
#include <qwt_plot_magnifier.h>
%End

   

public:
    explicit QwtPlotMagnifier( QWidget * );
    virtual ~QwtPlotMagnifier();

    void setAxisEnabled( int axis, bool on );
    bool isAxisEnabled( int axis ) const;

    QWidget *canvas();
    //const QWidget *canvas() const;

    QwtPlot *plot();
    //const QwtPlot *plot() const;

protected:
    virtual void rescale( double factor );
/*
private:
    class PrivateData;
    PrivateData *d_data;*/
};


