/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2018   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief An analog clock

  \image html analogclock.png

  \par Example
  \code 
  #include <qwt_analog_clock.h>

  QwtAnalogClock *clock = new QwtAnalogClock(...);
  clock->scaleDraw()->setPenWidth(3);
  clock->setLineWidth(6);
  clock->setFrameShadow(QwtDial::Sunken);
  clock->setTime();

  // update the clock every second
  QTimer *timer = new QTimer(clock);
  timer->connect(timer, SIGNAL(timeout()), clock, SLOT(setCurrentTime()));
  timer->start(1000);

  \endcode

  \note The examples/dials example shows how to use QwtAnalogClock.
*/

class QwtAnalogClock: QwtDial
{
%TypeHeaderCode
#include <qwt_analog_clock.h>
%End

public:
    /*!
        Hand type
        \sa setHand(), hand()
    */
    enum Hand
    {
        //! Needle displaying the seconds
        SecondHand,

        //! Needle displaying the minutes
        MinuteHand,

        //! Needle displaying the hours
        HourHand,

        //! Number of needles
        NHands
    };

    explicit QwtAnalogClock( QWidget* parent /TransferThis/ = NULL );
    virtual ~QwtAnalogClock();

    void setHand( Hand, QwtDialNeedle * /Transfer/);

    //const QwtDialNeedle *hand( Hand ) const;
    QwtDialNeedle *hand( Hand );

public Q_SLOTS:
    void setCurrentTime();
    void setTime( const QTime & );

protected:
    virtual void drawNeedle( QPainter *, const QPointF &,
        double radius, double direction, QPalette::ColorGroup ) const;

    virtual void drawHand( QPainter *, Hand, const QPointF &,
        double radius, double direction, QPalette::ColorGroup ) const;

private:
    // use setHand instead
    void setNeedle( QwtDialNeedle * );

    //QwtDialNeedle *d_hand[NHands];
};
