/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief QwtSystemClock provides high resolution clock time functions.

  Sometimes the resolution offered by QTime ( millisecond ) is not accurate
  enough for implementing time measurements ( f.e. sampling ).
  QwtSystemClock offers a subset of the QTime functionality using higher
  resolution timers ( if possible ).

  Precision and time intervals are multiples of milliseconds (ms).

  ( QwtSystemClock is obsolete since Qt 4.8 as QElapsedTimer offers the same
    precision )

  \note The implementation uses high-resolution performance counter on Windows,
        mach_absolute_time() on the Mac or POSIX timers on other systems.
        If none is available it falls back on QTimer.
*/

class QwtSystemClock
{
%TypeHeaderCode
#include <qwt_system_clock.h>
%End
public:
    QwtSystemClock();
    virtual ~QwtSystemClock();

    bool isNull() const;

    void start();
    double restart();
    double elapsed() const;
/*
private:
    class PrivateData;
    PrivateData *d_data;
    */
};


