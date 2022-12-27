/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%If(- Qwt_6_1_6)
class QwtSpline
{
%TypeHeaderCode
#include <qwt_spline.h>
%End

public:
    //! Spline type
    enum SplineType
    {
        //! A natural spline
        Natural,

        //! A periodic spline
        Periodic
    };

    QwtSpline();
    QwtSpline( const QwtSpline & );

    ~QwtSpline();

    //QwtSpline &operator=( const QwtSpline & );

    void setSplineType( SplineType );
    SplineType splineType() const;

    bool setPoints( const QPolygonF& points );
    QPolygonF points() const;

    void reset();

    bool isValid() const;
    double value( double x ) const;

    const QVector<double> &coefficientsA() const;
    const QVector<double> &coefficientsB() const;
    const QVector<double> &coefficientsC() const;

protected:
    bool buildNaturalSpline( const QPolygonF & );
    bool buildPeriodicSpline( const QPolygonF & );

};
%End // (- Qwt_6_1_6)

%If(Qwt_6_2_0 -)
//class QwtSplineParametrization; FIXME Implement later
//class QwtSplinePolynomial; FIXME Implement later

class QwtSpline /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_spline.h>
%End
  public:
    enum BoundaryType
    {
        ConditionalBoundaries,
        PeriodicPolygon,
        ClosedPolygon
    };
    enum BoundaryPosition
    {
        AtBeginning,
        AtEnd
    };

    enum BoundaryCondition
    {
        Clamped1,
        Clamped2,
        Clamped3,
        LinearRunout
    };

    QwtSpline();
    virtual ~QwtSpline();

    void setParametrization( int type );
    //void setParametrization( QwtSplineParametrization* ); FIXME
    //const QwtSplineParametrization* parametrization() const; FIXME

    void setBoundaryType( BoundaryType );
    BoundaryType boundaryType() const;

    void setBoundaryValue( BoundaryPosition, double value );
    double boundaryValue( BoundaryPosition ) const;

    void setBoundaryCondition( BoundaryPosition, int condition );
    int boundaryCondition( BoundaryPosition ) const;

    void setBoundaryConditions( int condition,
        double valueBegin = 0.0, double valueEnd = 0.0 );

    virtual QPolygonF polygon( const QPolygonF&, double tolerance ) const;
    virtual QPainterPath painterPath( const QPolygonF& ) const = 0;

    virtual uint locality() const;

/*  private:
    Q_DISABLE_COPY(QwtSpline)

    class PrivateData;
    PrivateData* m_data;*/
};

class QwtSplineInterpolating : QwtSpline /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_spline.h>
%End
  public:
    QwtSplineInterpolating();
    virtual ~QwtSplineInterpolating();

    virtual QPolygonF equidistantPolygon( const QPolygonF&,
        double distance, bool withNodes ) const;

    virtual QPolygonF polygon(
        const QPolygonF&, double tolerance ) const;// QWT_OVERRIDE;

    virtual QPainterPath painterPath( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QVector< QLineF > bezierControlLines( const QPolygonF& ) const = 0;

  //private:
  //  Q_DISABLE_COPY(QwtSplineInterpolating)
};

/*!
   \brief Base class for spline interpolations providing a
         first order geometric continuity ( G1 ) between adjoining curves
 */
class  QwtSplineG1 : public QwtSplineInterpolating /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_spline.h>
%End
  public:
    QwtSplineG1();
    virtual ~QwtSplineG1();
};

/*!
   \brief Base class for spline interpolations providing a
         first order parametric continuity ( C1 ) between adjoining curves

   All interpolations with C1 continuity are based on rules for finding
   the 1. derivate at some control points.

   In case of non parametric splines those points are the curve points, while
   for parametric splines the calculation is done twice using a parameter value t.

   \sa QwtSplineParametrization
 */
class  QwtSplineC1 : public QwtSplineG1 /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_spline.h>
%End
  public:
    QwtSplineC1();
    virtual ~QwtSplineC1();

    virtual QPainterPath painterPath( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QVector< QLineF > bezierControlLines( const QPolygonF& ) const;// QWT_OVERRIDE;

    virtual QPolygonF equidistantPolygon( const QPolygonF&,
        double distance, bool withNodes ) const;// QWT_OVERRIDE;

    // these methods are the non parametric part
    //virtual QVector< QwtSplinePolynomial > polynomials( const QPolygonF& ) const; FIXME
    virtual QVector< double > slopes( const QPolygonF& ) const = 0;

    virtual double slopeAtBeginning( const QPolygonF&, double slopeNext ) const;
    virtual double slopeAtEnd( const QPolygonF&, double slopeBefore ) const;
};

/*!
   \brief Base class for spline interpolations providing a
         second order parametric continuity ( C2 ) between adjoining curves

   All interpolations with C2 continuity are based on rules for finding
   the 2. derivate at some control points.

   In case of non parametric splines those points are the curve points, while
   for parametric splines the calculation is done twice using a parameter value t.

   \sa QwtSplineParametrization
 */
class QwtSplineC2 : public QwtSplineC1 /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_spline.h>
%End
  public:
    /*enum BoundaryConditionC2
    {
        CubicRunout = LinearRunout + 1,
        NotAKnot
    };*/

    QwtSplineC2();
    virtual ~QwtSplineC2();

    virtual QPainterPath painterPath( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QVector< QLineF > bezierControlLines( const QPolygonF& ) const;// QWT_OVERRIDE;

    virtual QPolygonF equidistantPolygon( const QPolygonF&,
        double distance, bool withNodes ) const;// QWT_OVERRIDE;

    // calculating the parametric equations
    //virtual QVector< QwtSplinePolynomial > polynomials( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QVector< double > slopes( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QVector< double > curvatures( const QPolygonF& ) const = 0;
};
%End // (Qwt_6_2_0 -)
