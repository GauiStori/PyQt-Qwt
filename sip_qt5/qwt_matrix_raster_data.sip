/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief A class representing a matrix of values as raster data

  QwtMatrixRasterData implements an interface for a matrix of
  equidistant values, that can be used by a QwtPlotRasterItem.
  It implements a couple of resampling algorithms, to provide
  values for positions, that or not on the value matrix.
*/

%If(- Qwt_6_2_0)
class QwtMatrixRasterData: public QwtRasterData
{
%TypeHeaderCode
#include <qwt_matrix_raster_data.h>
%End
public:
    enum ResampleMode
    {
        NearestNeighbour,
        BilinearInterpolation
    };

    QwtMatrixRasterData();
    virtual ~QwtMatrixRasterData();

    void setResampleMode(ResampleMode mode);
    ResampleMode resampleMode() const;

    virtual void setInterval( Qt::Axis, const QwtInterval & );

    void setValueMatrix( const QVector<double> &values, int numColumns );
    const QVector<double> valueMatrix() const;

    void setValue( int row, int col, double value );

    int numColumns() const;
    int numRows() const;

    virtual QRectF pixelHint( const QRectF & ) const;

    virtual double value( double x, double y ) const;

};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtMatrixRasterData : QwtRasterData /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_matrix_raster_data.h>
%End
  public:
    enum ResampleMode
    {
        NearestNeighbour,
        BilinearInterpolation,
        BicubicInterpolation
    };

    QwtMatrixRasterData();
    virtual ~QwtMatrixRasterData();

    void setResampleMode(ResampleMode mode);
    ResampleMode resampleMode() const;

    void setInterval( Qt::Axis, const QwtInterval& );
    virtual QwtInterval interval( Qt::Axis axis) const final;//QWT_OVERRIDE QWT_FINAL;

    void setValueMatrix( const QVector< double >& values, int numColumns );
    const QVector< double > valueMatrix() const;

    void setValue( int row, int col, double value );

    int numColumns() const;
    int numRows() const;

    virtual QRectF pixelHint( const QRectF& ) const;// QWT_OVERRIDE;

    virtual double value( double x, double y ) const;// QWT_OVERRIDE;
};
%End // (Qwt_6_2_0 -)
