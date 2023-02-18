/******************************************************************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%If(Qwt_6_2_0 -)
class QwtSplineCurveFitter : QwtCurveFitter /NoDefaultCtors/
{
%TypeHeaderCode
#include "qwt_spline_curve_fitter.h"
%End
  public:
    QwtSplineCurveFitter();
    virtual ~QwtSplineCurveFitter();

    void setSpline( QwtSpline* );

    //const QwtSpline* spline() const;
    QwtSpline* spline();

    virtual QPolygonF fitCurve( const QPolygonF& ) const;// QWT_OVERRIDE;
    virtual QPainterPath fitCurvePath( const QPolygonF& ) const;// QWT_OVERRIDE;

//  private:
//    QwtSpline* m_spline;
};
%End // (Qwt_6_2_0 -)
