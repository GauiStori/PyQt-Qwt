/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


class QwtEventPattern
{
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End

public:
    enum MousePatternCode
    {
        MouseSelect1,
        MouseSelect2,
        MouseSelect3,
        MouseSelect4,
        MouseSelect5,
        MouseSelect6,
        MousePatternCount
    };

    enum KeyPatternCode
    {
        KeySelect1,
        KeySelect2,
        KeyAbort,
        KeyLeft,
        KeyRight,
        KeyUp,
        KeyDown,
        KeyRedo,
        KeyUndo,
        KeyHome,
        KeyPatternCount
    };

    //! A pattern for mouse events
    class MousePattern
    {
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End
    public:
        //! Constructor
        Qt::MouseButton button;
        Qt::KeyboardModifiers modifiers;
        MousePattern( Qt::MouseButton btn = Qt::NoButton, Qt::KeyboardModifiers modifierCodes = Qt::NoModifier );
    };

    //! A pattern for key events
    class KeyPattern
    {
%TypeHeaderCode
#include <qwt_event_pattern.h>
%End
    public:
        //! Constructor
        int key;
        Qt::KeyboardModifiers modifiers;
        KeyPattern( int keyCode = Qt::Key_unknown, Qt::KeyboardModifiers modifierCodes = Qt::NoModifier );
    };

    QwtEventPattern();
    virtual ~QwtEventPattern();
    void initMousePattern( int numButtons );
    void initKeyPattern();
    void setMousePattern( MousePatternCode, Qt::MouseButton button, Qt::KeyboardModifiers = Qt::NoModifier );
    void setKeyPattern( KeyPatternCode, int keyCode, Qt::KeyboardModifiers modifierCodes = Qt::NoModifier );
    void setMousePattern( const QVector<QwtEventPattern::MousePattern> & );
    void setKeyPattern( const QVector<QwtEventPattern::KeyPattern> & );
    //FIXME const QVector<MousePattern> &mousePattern() const;
    //FIXME const QVector<KeyPattern> &keyPattern() const;
    QVector<QwtEventPattern::MousePattern> &mousePattern();
    QVector<QwtEventPattern::KeyPattern> &keyPattern();
    bool mouseMatch( MousePatternCode, const QMouseEvent *) const;
    bool keyMatch( KeyPatternCode, const QKeyEvent *) const;
protected:
    virtual bool mouseMatch( const QwtEventPattern::MousePattern &, const QMouseEvent *) const;
    virtual bool keyMatch( const QwtEventPattern::KeyPattern &, const QKeyEvent *) const;
};
