/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief The QwtDynGridLayout class lays out widgets in a grid,
         adjusting the number of columns and rows to the current size.

  QwtDynGridLayout takes the space it gets, divides it up into rows and
  columns, and puts each of the widgets it manages into the correct cell(s).
  It lays out as many number of columns as possible (limited by maxColumns()).
*/

class QwtDynGridLayout : public QLayout
{
%TypeHeaderCode
#include <qwt_dyngrid_layout.h>
%End
public:
    explicit QwtDynGridLayout( QWidget *, int margin = 0, int spacing = -1 );
    explicit QwtDynGridLayout( int spacing = -1 );

    virtual ~QwtDynGridLayout();

    virtual void invalidate();

    void setMaxColumns( uint maxColumns );
    uint maxColumns() const;

    uint numRows () const;
    uint numColumns () const;

    virtual void addItem( QLayoutItem * );

    virtual QLayoutItem *itemAt( int index ) const;
    virtual QLayoutItem *takeAt( int index );
    virtual int count() const;

    void setExpandingDirections( Qt::Orientations );
    virtual Qt::Orientations expandingDirections() const;
    QList<QRect> layoutItems( const QRect &, uint numColumns ) const;

    virtual int maxItemWidth() const;

    virtual void setGeometry( const QRect &rect );

    virtual bool hasHeightForWidth() const;
    virtual int heightForWidth( int ) const;

    virtual QSize sizeHint() const;

    virtual bool isEmpty() const;
    uint itemCount() const;

    virtual uint columnsForWidth( int width ) const;

protected:

    void layoutGrid( uint numColumns,
        QList<int>& rowHeight, QList<int>& colWidth ) const;
    void stretchGrid( const QRect &rect, uint numColumns,
        QList<int>& rowHeight, QList<int>& colWidth ) const;

/*
private:
    void init();
    int maxRowWidth( int numColumns ) const;

    class PrivateData;
    PrivateData *d_data;
    */
};


