/******************************************************************************
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

    void setFormat( Format );
    Format format() const;
    virtual QRgb rgb( const QwtInterval& interval, double value ) const = 0;
    virtual uint colorIndex( int numColors, const QwtInterval& interval, double value ) const;

    QColor color( const QwtInterval&, double value ) const;
    virtual QVector< QRgb > colorTable( int ) const;
    virtual QVector< QRgb > colorTable256() const;

private:
    QwtColorMap( const QwtColorMap & );

//    Format m_format;
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
    QwtLinearColorMap( const QColor& from, const QColor& to,
        Format = QwtColorMap::RGB );

    virtual ~QwtLinearColorMap();

    void setMode( Mode );
    Mode mode() const;

    void setColorInterval( const QColor& color1, const QColor& color2 );
    void addColorStop( double value, const QColor& );
    QVector< double > colorStops() const;

    QColor color1() const;
    QColor color2() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;

    virtual uint colorIndex( int numColors,
        const QwtInterval&, double value ) const;

    class ColorStops;

  private:
    QwtLinearColorMap( const QwtLinearColorMap & );
//    class PrivateData;
//    PrivateData* m_data;
};

class QwtAlphaColorMap: QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
  public:
    QwtAlphaColorMap( const QColor& = QColor( Qt::gray ) );
    virtual ~QwtAlphaColorMap();

    void setAlphaInterval( int alpha1, int alpha2 );

    int alpha1() const;
    int alpha2() const;

    void setColor( const QColor& );
    QColor color() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;

  private:
    QwtAlphaColorMap( const QwtAlphaColorMap & );
//    class PrivateData;
//    PrivateData* m_data;
};

class QwtHueColorMap : QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
  public:
    QwtHueColorMap( Format = QwtColorMap::RGB );
    virtual ~QwtHueColorMap();

    void setHueInterval( int hue1, int hue2 ); // direction ?
    void setSaturation( int saturation );
    void setValue( int value );
    void setAlpha( int alpha );

    int hue1() const;
    int hue2() const;
    int saturation() const;
    int value() const;
    int alpha() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;

  private:
    QwtHueColorMap( const QwtHueColorMap & );
//    class PrivateData;
//    PrivateData* m_data;
};

class QwtSaturationValueColorMap : QwtColorMap
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
  public:
    QwtSaturationValueColorMap();
    virtual ~QwtSaturationValueColorMap();

    void setHue( int hue );
    void setSaturationInterval( int sat1, int sat2 );
    void setValueInterval( int value1, int value2 );
    void setAlpha( int alpha );

    int hue() const;
    int saturation1() const;
    int saturation2() const;
    int value1() const;
    int value2() const;
    int alpha() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;

  private:
    QwtSaturationValueColorMap( const QwtSaturationValueColorMap & );
//    class PrivateData;
//    PrivateData* m_data;
};

/*inline QColor QwtColorMap::color( const QwtInterval& interval, double value ) const
{
    return QColor::fromRgba( rgb( interval, value ) );
}

inline QwtColorMap::Format QwtColorMap::format() const
{
    return m_format;
}*/
