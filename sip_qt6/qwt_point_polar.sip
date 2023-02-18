/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2018   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief A point in polar coordinates

  In polar coordinates a point is determined by an angle and a distance.
  See http://en.wikipedia.org/wiki/Polar_coordinate_system
*/

class QwtPointPolar
{
%TypeHeaderCode
#include <qwt_point_polar.h>
%End

public:
    QwtPointPolar();
    QwtPointPolar( double azimuth, double radius );
    QwtPointPolar( const QwtPointPolar & );
    QwtPointPolar( const QPointF & );

    void setPoint( const QPointF & );
    QPointF toPoint() const;

    bool isValid() const;
    bool isNull() const;

    double radius() const;
    double azimuth() const;

    //double &rRadius();
    //double &rAzimuth();

    void setRadius( double );
    void setAzimuth( double );

    bool operator==( const QwtPointPolar & ) const;
    bool operator!=( const QwtPointPolar & ) const;

    QwtPointPolar normalized() const;

/*private:
    double d_azimuth;
    double d_radius;*/
};

/*!
    Constructs a null point, with a radius and azimuth set to 0.0.
    \sa QPointF::isNull()
*/
//inline QwtPointPolar::QwtPointPolar();
/*!
   Constructs a point with coordinates specified by radius and azimuth.

   \param azimuth Azimuth
   \param radius Radius
*/
/*inline QwtPointPolar::QwtPointPolar( double azimuth, double radius ):
    d_azimuth( azimuth ),
    d_radius( radius );
/*!
    Constructs a point using the values of the point specified.
    \param other Other point
*/
//inline QwtPointPolar::QwtPointPolar( const QwtPointPolar &other );
//! Returns true if radius() >= 0.0
//inline bool QwtPointPolar::isValid() const;
//! Returns true if radius() >= 0.0
//inline bool QwtPointPolar::isNull() const;
//! Returns the radius.
//inline double QwtPointPolar::radius() const;
//! Returns the azimuth.
//inline double QwtPointPolar::azimuth() const;
//! Returns the radius.
//inline double &QwtPointPolar::rRadius();
//! Returns the azimuth.
//inline double &QwtPointPolar::rAzimuth();
//! Sets the radius to radius.
//inline void QwtPointPolar::setRadius( double radius );
//! Sets the atimuth to atimuth.
//inline void QwtPointPolar::setAzimuth( double azimuth );
//#ifndef QT_NO_DEBUG_STREAM
//QWT_EXPORT QDebug operator<<( QDebug, const QwtPointPolar & );
//#endif
/*inline QPoint qwtPolar2Pos( const QPoint &pole, double radius, double angle );
inline QPoint qwtDegree2Pos( const QPoint &pole, double radius, double angle );
inline QPointF qwtPolar2Pos( const QPointF &pole, double radius, double angle );
inline QPointF qwtDegree2Pos( const QPointF &pole, double radius, double angle );
inline QPointF qwtFastPolar2Pos( const QPointF &pole, double radius, double angle );
inline QPointF qwtFastDegree2Pos( const QPointF &pole, double radius, double angle );
inline QwtPointPolar qwtFastPos2Polar( const QPointF &pos );
*/
