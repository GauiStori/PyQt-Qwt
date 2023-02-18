 /*
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

typedef QList<QwtPlotItem *> QwtPlotItemList;
//typedef QList<QwtPlotItem *>::ConstIterator QwtPlotItemIterator;

class QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot_dict.h>
%End

public:
    explicit QwtPlotDict();
    virtual ~QwtPlotDict();

    void setAutoDelete( bool );
    bool autoDelete() const;

    const QwtPlotItemList& itemList() const;
    QwtPlotItemList itemList( int rtti ) const;

    void detachItems( int rtti = QwtPlotItem::Rtti_PlotItem,
        bool autoDelete = true );

protected:
    void insertItem( QwtPlotItem * /Transfer/);
    void removeItem( QwtPlotItem * /Transfer/);

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
