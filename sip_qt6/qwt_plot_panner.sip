/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class  QwtPlotPanner: QwtPanner
{
%TypeHeaderCode
#include <qwt_plot_panner.h>
%End
    //Q_OBJECT

public:
    explicit QwtPlotPanner( QWidget * /TransferThis/ );
    virtual ~QwtPlotPanner();

    QWidget *canvas();
    //const QWidget *canvas() const;

    QwtPlot *plot();
    //const QwtPlot *plot() const;

    void setAxisEnabled( int axis, bool on );
    bool isAxisEnabled( int axis ) const;

protected Q_SLOTS:
    virtual void moveCanvas( int dx, int dy );

protected:
    virtual QBitmap contentsMask() const;
    virtual QPixmap grab() const;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
