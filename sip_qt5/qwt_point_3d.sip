/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief QwtPoint3D class defines a 3D point in double coordinates
*/

class QwtPoint3D
{
%TypeHeaderCode
#include <qwt_point_3d.h>
%End
public:
    QwtPoint3D();
    QwtPoint3D( double x, double y, double z );
    QwtPoint3D( const QwtPoint3D & );
    QwtPoint3D( const QPointF & );

    bool isNull()    const;

    double x() const;
    double y() const;
    double z() const;

    double rx();
    double ry();
    double rz();

    void setX( double x );
    void setY( double y );
    void setZ( double y );

    QPointF toPoint() const;

    bool operator==( const QwtPoint3D & ) const;
    bool operator!=( const QwtPoint3D & ) const;
/*
private:
    double d_x;
    double d_y;
    double d_z;
   */
};


