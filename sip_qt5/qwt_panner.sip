/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPanner: QWidget
{
%TypeHeaderCode
#include <qwt_panner.h>
%End
    //Q_OBJECT

public:
    QwtPanner( QWidget* parent /TransferThis/);
    virtual ~QwtPanner();

    void setEnabled( bool );
    bool isEnabled() const;

    void setMouseButton( Qt::MouseButton, 
        Qt::KeyboardModifiers = Qt::NoModifier );
    void getMouseButton( Qt::MouseButton &button, 
        Qt::KeyboardModifiers & ) const;

    void setAbortKey( int key, Qt::KeyboardModifiers = Qt::NoModifier );
    void getAbortKey( int &key, Qt::KeyboardModifiers & ) const;

    void setCursor( const QCursor & );
    const QCursor cursor() const;

    void setOrientations( Qt::Orientations );
    Qt::Orientations orientations() const;

    bool isOrientationEnabled( Qt::Orientation ) const;

    virtual bool eventFilter( QObject *, QEvent * );

Q_SIGNALS:
    /*!
      Signal emitted, when panning is done

      \param dx Offset in horizontal direction
      \param dy Offset in vertical direction
    */
    void panned( int dx, int dy );

    /*!
      Signal emitted, while the widget moved, but panning
      is not finished.

      \param dx Offset in horizontal direction
      \param dy Offset in vertical direction
    */
    void moved( int dx, int dy );

protected:
    virtual void widgetMousePressEvent( QMouseEvent * );
    virtual void widgetMouseReleaseEvent( QMouseEvent * );
    virtual void widgetMouseMoveEvent( QMouseEvent * );
    virtual void widgetKeyPressEvent( QKeyEvent * );
    virtual void widgetKeyReleaseEvent( QKeyEvent * );

    virtual void paintEvent( QPaintEvent * );

    virtual QBitmap contentsMask() const;
    virtual QPixmap grab() const;

/*private:
#ifndef QT_NO_CURSOR
    void showCursor( bool );
#endif

    class PrivateData;
    PrivateData *d_data;*/
};

