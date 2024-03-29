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
class QwtAbstractScaleDraw
{
%TypeHeaderCode
#include <qwt_abstract_scale_draw.h>
%End
public:

    /*!
       Components of a scale
       \sa enableComponent(), hasComponent
    */
    enum ScaleComponent
    {
        //! Backbone = the line where the ticks are located
        Backbone = 0x01,

        //! Ticks
        Ticks = 0x02,

        //! Labels
        Labels = 0x04
    };

    //! Scale components
    //typedef QFlags<ScaleComponent> ScaleComponents;

    QwtAbstractScaleDraw();
    virtual ~QwtAbstractScaleDraw();

    void setScaleDiv( const QwtScaleDiv &s );
    const QwtScaleDiv& scaleDiv() const;

    //void setTransformation( QwtTransform * );
    //const QwtScaleMap &scaleMap() const;
    QwtScaleMap &scaleMap();

    void enableComponent( ScaleComponent, bool enable = true );
    bool hasComponent( ScaleComponent ) const;

    void setTickLength( QwtScaleDiv::TickType, double length );
    double tickLength( QwtScaleDiv::TickType ) const;
    double maxTickLength() const;

    void setSpacing( double margin );
    double spacing() const;

    void setPenWidth( int width );
    int penWidth() const;

    virtual void draw( QPainter *, const QPalette & ) const;

    //virtual QwtText label( double ) const;

    /*!
      Calculate the extent

      The extent is the distance from the baseline to the outermost
      pixel of the scale draw in opposite to its orientation.
      It is at least minimumExtent() pixels.

      \param font Font used for drawing the tick labels
      \return Number of pixels

      \sa setMinimumExtent(), minimumExtent()
    */
    virtual double extent( const QFont &font ) const = 0;

    void setMinimumExtent( double );
    double minimumExtent() const;

protected:
    /*!
       Draw a tick

       \param painter Painter
       \param value Value of the tick
       \param len Length of the tick

       \sa drawBackbone(), drawLabel()
    */
    virtual void drawTick( QPainter *painter, double value, double len ) const = 0;

    /*!
      Draws the baseline of the scale
      \param painter Painter

      \sa drawTick(), drawLabel()
    */
    virtual void drawBackbone( QPainter *painter ) const = 0;

    /*!
        Draws the label for a major scale tick

        \param painter Painter
        \param value Value

        \sa drawTick(), drawBackbone()
    */
    virtual void drawLabel( QPainter *painter, double value ) const = 0;

    void invalidateCache();
    //const QwtText &tickLabel( const QFont &, double value ) const;

private:
    QwtAbstractScaleDraw( const QwtAbstractScaleDraw & );
    /*QwtAbstractScaleDraw &operator=( const QwtAbstractScaleDraw & );

    class PrivateData;
    PrivateData *d_data;*/
};
%End // (- Qwt_6_2_0)

%If(Qwt_6_2_0 -)
class QwtAbstractScaleDraw /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_abstract_scale_draw.h>
%End
  public:
    enum ScaleComponent
    {
        Backbone = 0x01,
        Ticks = 0x02,
        Labels = 0x04
    };

    //Q_DECLARE_FLAGS( ScaleComponents, ScaleComponent )

    QwtAbstractScaleDraw();
    virtual ~QwtAbstractScaleDraw();

    void setScaleDiv( const QwtScaleDiv& );
    //const QwtScaleDiv& scaleDiv() const;

    void setTransformation( QwtTransform* );
    //const QwtScaleMap& scaleMap() const;
    QwtScaleMap& scaleMap();

    void enableComponent( ScaleComponent, bool enable = true );
    bool hasComponent( ScaleComponent ) const;

    void setTickLength( QwtScaleDiv::TickType, double length );
    double tickLength( QwtScaleDiv::TickType ) const;
    double maxTickLength() const;

    void setSpacing( double );
    double spacing() const;

    void setPenWidthF( qreal width );
    qreal penWidthF() const;

    virtual void draw( QPainter*, const QPalette& ) const;

    virtual QwtText label( double ) const;
    virtual double extent( const QFont& font ) const = 0;

    void setMinimumExtent( double );
    double minimumExtent() const;

    void invalidateCache();

  protected:
    virtual void drawTick( QPainter* painter, double value, double len ) const = 0;
    virtual void drawBackbone( QPainter* painter ) const = 0;
    virtual void drawLabel( QPainter* painter, double value ) const = 0;

    const QwtText& tickLabel( const QFont&, double value ) const;
};
%End // (Qwt_6_2_0 -)
