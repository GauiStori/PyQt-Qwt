/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtCurveFitter
{
%TypeHeaderCode
#include <qwt_curve_fitter.h>
%End

public:
    virtual ~QwtCurveFitter();

    /*!
        Find a curve which has the best fit to a series of data points

        \param polygon Series of data points
        \return Curve points
     */
    virtual QPolygonF fitCurve( const QPolygonF &polygon ) const = 0;

protected:
    QwtCurveFitter();

private:
    QwtCurveFitter( const QwtCurveFitter & );
    //QwtCurveFitter &operator=( const QwtCurveFitter & );
};

/*!
  \brief A curve fitter using cubic splines
*/
class QwtSplineCurveFitter: public QwtCurveFitter
{
%TypeHeaderCode
#include <qwt_curve_fitter.h>
%End

public:
    /*!
      Spline type
      The default setting is Auto
      \sa setFitMode(), FitMode()
     */
    enum FitMode
    {
        /*!
          Use the default spline algorithm for polygons with
          increasing x values ( p[i-1] < p[i] ), otherwise use
          a parametric spline algorithm.
         */
        Auto,

        //! Use a default spline algorithm
        Spline,

        //! Use a parametric spline algorithm
        ParametricSpline
    };

    QwtSplineCurveFitter();
    virtual ~QwtSplineCurveFitter();

    void setFitMode( FitMode );
    FitMode fitMode() const;

    void setSpline( const QwtSpline& );
    //const QwtSpline &spline() const; FIXME. 
    QwtSpline &spline();

    void setSplineSize( int size );
    int splineSize() const;

    virtual QPolygonF fitCurve( const QPolygonF & ) const;

private:
    QPolygonF fitSpline( const QPolygonF & ) const;
    QPolygonF fitParametric( const QPolygonF & ) const;

    //class PrivateData;
    //PrivateData *d_data;
};

/*!
  \brief A curve fitter implementing Douglas and Peucker algorithm

  The purpose of the Douglas and Peucker algorithm is that given a 'curve'
  composed of line segments to find a curve not too dissimilar but that
  has fewer points. The algorithm defines 'too dissimilar' based on the
  maximum distance (tolerance) between the original curve and the
  smoothed curve.

  The runtime of the algorithm increases non linear ( worst case O( n*n ) )
  and might be very slow for huge polygons. To avoid performance issues
  it might be useful to split the polygon ( setChunkSize() ) and to run the algorithm
  for these smaller parts. The disadvantage of having no interpolation
  at the borders is for most use cases irrelevant.

  The smoothed curve consists of a subset of the points that defined the
  original curve.

  In opposite to QwtSplineCurveFitter the Douglas and Peucker algorithm reduces
  the number of points. By adjusting the tolerance parameter according to the
  axis scales QwtSplineCurveFitter can be used to implement different
  level of details to speed up painting of curves of many points.
*/
class QwtWeedingCurveFitter: public QwtCurveFitter
{
%TypeHeaderCode
#include <qwt_curve_fitter.h>
%End

public:
    QwtWeedingCurveFitter( double tolerance = 1.0 );
    virtual ~QwtWeedingCurveFitter();

    void setTolerance( double );
    double tolerance() const;

    void setChunkSize( uint );
    uint chunkSize() const;

    virtual QPolygonF fitCurve( const QPolygonF & ) const;

private:
    virtual QPolygonF simplify( const QPolygonF & ) const;

    //class Line;

    //class PrivateData;
    //PrivateData *d_data;
};
