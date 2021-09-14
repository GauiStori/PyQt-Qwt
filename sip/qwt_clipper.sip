/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief Some clipping algorithms
*/

namespace QwtClipper
{
%TypeHeaderCode
#include <qwt_clipper.h>
%End

    QPolygon clippedPolygon( const QRect &,
        const QPolygon &, bool closePolygon = false );
    QPolygon clippedPolygon( const QRectF &,
        const QPolygon &, bool closePolygon = false );

    QPolygonF clippedPolygonF( const QRectF &,
        const QPolygonF &, bool closePolygon = false );

    QVector<QwtInterval> clipCircle(
        const QRectF &, const QPointF &, double radius );
};


