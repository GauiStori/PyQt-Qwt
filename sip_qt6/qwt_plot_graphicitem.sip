/******************************************************************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class  QwtPlotGraphicItem : QwtPlotItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_plot_graphicitem.h>
%End
  public:
    explicit QwtPlotGraphicItem( const QString& title = QString() );
    explicit QwtPlotGraphicItem( const QwtText& title );

    virtual ~QwtPlotGraphicItem();

    void setGraphic( const QRectF& rect, const QwtGraphic& );
    QwtGraphic graphic() const;

    virtual QRectF boundingRect() const; // QWT_OVERRIDE;

    virtual void draw( QPainter*,
        const QwtScaleMap& xMap, const QwtScaleMap& yMap,
        const QRectF& canvasRect ) const; // QWT_OVERRIDE;

    virtual int rtti() const; // QWT_OVERRIDE;

  /*private:
    void init();

    class PrivateData;
    PrivateData* m_data;*/
};
