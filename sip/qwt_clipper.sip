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

class QwtClipper
{
%TypeHeaderCode
#include <qwt_clipper.h>
%End

public:
    static QPolygon clipPolygon( const QRect &,
        const QPolygon &, bool closePolygon = false );
    static QPolygon clipPolygon( const QRectF &,
        const QPolygon &, bool closePolygon = false );

    static QPolygonF clipPolygonF( const QRectF &,
        const QPolygonF &, bool closePolygon = false );

    static QVector<QwtInterval> clipCircle(
        const QRectF &, const QPointF &, double radius );
};


