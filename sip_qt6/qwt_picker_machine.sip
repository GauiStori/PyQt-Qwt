/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


class QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    enum SelectionType
    {
        NoSelection = -1,
        PointSelection,
        RectSelection,
        PolygonSelection
    };

    //! Commands - the output of a state machine
    enum Command
    {
        Begin,
        Append,
        Move,
        Remove,
        End
    };

    QwtPickerMachine( SelectionType type );
    virtual ~QwtPickerMachine();

    //! Transition
    virtual QList<QwtPickerMachine::Command> transition( const QwtEventPattern &, const QEvent * /Transfer/) = 0;
    void reset();

    int state() const;
    void setState( int );

    SelectionType selectionType() const;

private:
    QwtPickerMachine& operator=(const QwtPickerMachine&);
    //SelectionType d_selectionType;
    //int d_state;
};

/*!
  \brief A state machine for indicating mouse movements

  QwtPickerTrackerMachine supports displaying information
  corresponding to mouse movements, but is not intended for
  selecting anything. Begin/End are related to Enter/Leave events.
*/
class QwtPickerTrackerMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerTrackerMachine();

    virtual QList<QwtPickerMachine::Command> transition(
        const QwtEventPattern &, const QEvent * /Transfer/);
};

/*!
  \brief A state machine for point selections

  Pressing QwtEventPattern::MouseSelect1 or
  QwtEventPattern::KeySelect1 selects a point.

  \sa QwtEventPattern::MousePatternCode, QwtEventPattern::KeyPatternCode
*/
class QwtPickerClickPointMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerClickPointMachine();

    virtual QList<QwtPickerMachine::Command> transition( const QwtEventPattern &, const QEvent * /Transfer/);
};

/*!
  \brief A state machine for point selections

  Pressing QwtEventPattern::MouseSelect1 or QwtEventPattern::KeySelect1
  starts the selection, releasing QwtEventPattern::MouseSelect1 or
  a second press of QwtEventPattern::KeySelect1 terminates it.
*/
class QwtPickerDragPointMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerDragPointMachine();

    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern &, const QEvent *  /Transfer/);
};

/*!
  \brief A state machine for rectangle selections

  Pressing QwtEventPattern::MouseSelect1 starts
  the selection, releasing it selects the first point. Pressing it
  again selects the second point and terminates the selection.
  Pressing QwtEventPattern::KeySelect1 also starts the
  selection, a second press selects the first point. A third one selects
  the second point and terminates the selection.

  \sa QwtEventPattern::MousePatternCode, QwtEventPattern::KeyPatternCode
*/

class QwtPickerClickRectMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerClickRectMachine();

    virtual QList<QwtPickerMachine::Command> transition(
        const QwtEventPattern &, const QEvent *  /Transfer/);
};

/*!
  \brief A state machine for rectangle selections

  Pressing QwtEventPattern::MouseSelect1 selects
  the first point, releasing it the second point.
  Pressing QwtEventPattern::KeySelect1 also selects the
  first point, a second press selects the second point and terminates
  the selection.

  \sa QwtEventPattern::MousePatternCode, QwtEventPattern::KeyPatternCode
*/

class QwtPickerDragRectMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerDragRectMachine();

    virtual QList<QwtPickerMachine::Command> transition( const QwtEventPattern &, const QEvent *  /Transfer/);
};

/*!
  \brief A state machine for line selections
    
  Pressing QwtEventPattern::MouseSelect1 selects
  the first point, releasing it the second point.
  Pressing QwtEventPattern::KeySelect1 also selects the
  first point, a second press selects the second point and terminates
  the selection.

  A common use case of QwtPickerDragLineMachine are pickers for
  distance measurements.
  
  \sa QwtEventPattern::MousePatternCode, QwtEventPattern::KeyPatternCode
*/              
                    
class QwtPickerDragLineMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerDragLineMachine();

    virtual QList<QwtPickerMachine::Command> transition(const QwtEventPattern &, const QEvent *  /Transfer/);
};

/*!
  \brief A state machine for polygon selections

  Pressing QwtEventPattern::MouseSelect1 or QwtEventPattern::KeySelect1
  starts the selection and selects the first point, or appends a point.
  Pressing QwtEventPattern::MouseSelect2 or QwtEventPattern::KeySelect2
  appends the last point and terminates the selection.

  \sa QwtEventPattern::MousePatternCode, QwtEventPattern::KeyPatternCode
*/

class QwtPickerPolygonMachine: QwtPickerMachine
{
%TypeHeaderCode
#include <qwt_picker_machine.h>
%End

public:
    QwtPickerPolygonMachine();

    virtual QList<QwtPickerMachine::Command> transition( const QwtEventPattern &, const QEvent *  /Transfer/);
};

