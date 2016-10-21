/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtInterval
{
%TypeHeaderCode
#include <qwt_interval.h>
%End
public:
    /*!
      Flag indicating if a border is included or excluded 
      \sa setBorderFlags(), borderFlags()
    */
    enum BorderFlag
    {
        //! Min/Max values are inside the interval
        IncludeBorders = 0x00,

        //! Min value is not included in the interval
        ExcludeMinimum = 0x01,

        //! Max value is not included in the interval
        ExcludeMaximum = 0x02,

        //! Min/Max values are not included in the interval
        ExcludeBorders = 0x03 //ExcludeMinimum | ExcludeMaximum
    };

    //! Border flags
    //typedef QFlags<BorderFlag> BorderFlags;

    QwtInterval();
    //QwtInterval( double minValue, double maxValue, BorderFlags = IncludeBorders );

    //void setInterval( double minValue, double maxValue, BorderFlags = IncludeBorders );

    QwtInterval normalized() const;
    QwtInterval inverted() const;
    QwtInterval limited( double minValue, double maxValue ) const;

    bool operator==( const QwtInterval & ) const;
    bool operator!=( const QwtInterval & ) const;

    //void setBorderFlags( BorderFlags );
    //BorderFlags borderFlags() const;

    double minValue() const;
    double maxValue() const;

    double width() const;

    void setMinValue( double );
    void setMaxValue( double );

    bool contains( double value ) const;

    bool intersects( const QwtInterval & ) const;
    QwtInterval intersect( const QwtInterval & ) const;
    QwtInterval unite( const QwtInterval & ) const;

    QwtInterval operator|( const QwtInterval & ) const;
    QwtInterval operator&( const QwtInterval & ) const;

    QwtInterval &operator|=( const QwtInterval & );
    QwtInterval &operator&=( const QwtInterval & );

    QwtInterval extend( double value ) const;
    QwtInterval operator|( double ) const;
    QwtInterval &operator|=( double );

    bool isValid() const;
    bool isNull() const;
    void invalidate();

    QwtInterval symmetrize( double value ) const;

/*private:
    double d_minValue;
    double d_maxValue;
    BorderFlags d_borderFlags;*/
};
