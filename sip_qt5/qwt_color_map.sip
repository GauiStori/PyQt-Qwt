/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%If(- Qwt_6_2_0)
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

%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtColorMap /NoDefaultCtors/
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

    explicit QwtColorMap( Format = QwtColorMap::RGB );
    virtual ~QwtColorMap();

    void setFormat( Format );
    Format format() const;
    virtual QRgb rgb( const QwtInterval& interval, double value ) const = 0;

    virtual uint colorIndex( int numColors,
        const QwtInterval& interval, double value ) const;

    QColor color( const QwtInterval&, double value ) const;
    virtual QVector< QRgb > colorTable( int numColors ) const;
    virtual QVector< QRgb > colorTable256() const;
};

class QwtLinearColorMap : QwtColorMap /NoDefaultCtors/
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

    explicit QwtLinearColorMap( QwtColorMap::Format = QwtColorMap::RGB );

    QwtLinearColorMap( const QColor& from, const QColor& to,
        QwtColorMap::Format = QwtColorMap::RGB );

    virtual ~QwtLinearColorMap();

    void setMode( Mode );
    Mode mode() const;

    void setColorInterval( const QColor& color1, const QColor& color2 );
    void addColorStop( double value, const QColor& );
    QVector< double > colorStops() const;

    QColor color1() const;
    QColor color2() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;// QWT_OVERRIDE;

    virtual uint colorIndex( int numColors,
        const QwtInterval&, double value ) const;// QWT_OVERRIDE;

    class ColorStops;
};

class QwtAlphaColorMap : QwtColorMap /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
  public:
    explicit QwtAlphaColorMap( const QColor& = QColor( Qt::gray ) );
    virtual ~QwtAlphaColorMap();

    void setAlphaInterval( int alpha1, int alpha2 );

    int alpha1() const;
    int alpha2() const;

    void setColor( const QColor& );
    QColor color() const;

    virtual QRgb rgb( const QwtInterval&,
        double value ) const;// QWT_OVERRIDE;
};

class QwtHueColorMap : QwtColorMap /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_color_map.h>
%End
  public:
    explicit QwtHueColorMap( QwtColorMap::Format = QwtColorMap::RGB );
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
        double value ) const;// QWT_OVERRIDE;
};

class QwtSaturationValueColorMap : QwtColorMap /NoDefaultCtors/
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
        double value ) const;// QWT_OVERRIDE;
};

%End // (Qwt_6_2_0 -)
