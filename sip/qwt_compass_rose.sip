/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2018   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

//class QPainter;

/*!
  \brief Abstract base class for a compass rose
*/
class QwtCompassRose
{
%TypeHeaderCode
#include <qwt_compass_rose.h>
%End
public:
    //! Destructor
    virtual ~QwtCompassRose();

    //! Assign a palette
    virtual void setPalette( const QPalette &p );

    //! \return Current palette
    const QPalette &palette() const;

    /*!
        Draw the rose

        \param painter Painter
        \param center Center point
        \param radius Radius of the rose
        \param north Position
        \param colorGroup Color group
     */
    virtual void draw( QPainter *painter, 
        const QPointF &center, double radius, double north,
        QPalette::ColorGroup colorGroup = QPalette::Active ) const = 0;
        
//private:
//    QPalette d_palette;
};

/*!
  \brief A simple rose for QwtCompass
*/
class  QwtSimpleCompassRose: QwtCompassRose
{
%TypeHeaderCode
#include <qwt_compass_rose.h>
%End
public:
    QwtSimpleCompassRose( int numThorns = 8, int numThornLevels = -1 );
    virtual ~QwtSimpleCompassRose();

    void setWidth( double w );
    double width() const;

    void setNumThorns( int count );
    int numThorns() const;

    void setNumThornLevels( int count );
    int numThornLevels() const;

    void setShrinkFactor( double factor );
    double shrinkFactor() const;

    virtual void draw( QPainter *, const QPointF &center, double radius,
        double north, QPalette::ColorGroup = QPalette::Active ) const;

    static void drawRose( QPainter *, const QPalette &,
        const QPointF &center, double radius, double origin, double width,
        int numThorns, int numThornLevels, double shrinkFactor );

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
