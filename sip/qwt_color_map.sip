/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
public:
    enum Format
    {
        RGB,
        Indexed
    };

    QwtColorMap( Format = QwtColorMap::RGB );
    virtual ~QwtColorMap();

    Format format() const;
    virtual QRgb rgb( const QwtInterval &interval, double value ) const = 0;
    virtual unsigned char colorIndex( const QwtInterval &interval, double value ) const = 0;

    QColor color( const QwtInterval &, double value ) const;
    virtual QVector<QRgb> colorTable( const QwtInterval & ) const;

//private:
//    Format d_format;
};

class QwtLinearColorMap: QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
public:
    enum Mode
    {
        FixedColors,
        ScaledColors
    };

    QwtLinearColorMap( Format = QwtColorMap::RGB );
    QwtLinearColorMap( const QColor &from, const QColor &to, 
                       Format = QwtColorMap::RGB );

    virtual ~QwtLinearColorMap();

    void setMode( Mode );
    Mode mode() const;

    void setColorInterval( const QColor &color1, const QColor &color2 );
    void addColorStop( double value, const QColor& );
    QVector<double> colorStops() const;

    QColor color1() const;
    QColor color2() const;

    virtual QRgb rgb( const QwtInterval &, double value ) const;
    virtual unsigned char colorIndex( const QwtInterval &, double value ) const;

    class ColorStops;

private:
    // Disabled copy constructor and operator=
    QwtLinearColorMap( const QwtLinearColorMap & );
    //QwtLinearColorMap &operator=( const QwtLinearColorMap & );

    //class PrivateData;
    //PrivateData *d_data;
};

class QwtAlphaColorMap: QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
public:
    QwtAlphaColorMap( const QColor & = QColor( Qt::gray ) );
    virtual ~QwtAlphaColorMap();

    void setColor( const QColor & );
    QColor color() const;

    virtual QRgb rgb( const QwtInterval &, double value ) const;

private:
    QwtAlphaColorMap( const QwtAlphaColorMap & );
    //QwtAlphaColorMap &operator=( const QwtAlphaColorMap & );

    virtual unsigned char colorIndex( const QwtInterval &, double value ) const;

    //class PrivateData;
    //PrivateData *d_data;
};


/*inline QColor QwtColorMap::color(
    const QwtInterval &interval, double value ) const
{
    if ( d_format == RGB )
    {
        return QColor::fromRgba( rgb( interval, value ) );
    }
    else
    {
        const unsigned int index = colorIndex( interval, value );
        return colorTable( interval )[index]; // slow
    }
}

inline QwtColorMap::Format QwtColorMap::format() const
{
    return d_format;
}*/

