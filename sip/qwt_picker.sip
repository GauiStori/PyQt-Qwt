/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtPicker: QObject, QwtEventPattern
{
%TypeHeaderCode
#include <qwt_picker.h>
%End
/*    Q_OBJECT

    Q_ENUMS( RubberBand DisplayMode ResizeMode )

    Q_PROPERTY( bool isEnabled READ isEnabled WRITE setEnabled )
    Q_PROPERTY( ResizeMode resizeMode READ resizeMode WRITE setResizeMode )

    Q_PROPERTY( DisplayMode trackerMode READ trackerMode WRITE setTrackerMode )
    Q_PROPERTY( QPen trackerPen READ trackerPen WRITE setTrackerPen )
    Q_PROPERTY( QFont trackerFont READ trackerFont WRITE setTrackerFont )

    Q_PROPERTY( RubberBand rubberBand READ rubberBand WRITE setRubberBand )
    Q_PROPERTY( QPen rubberBandPen READ rubberBandPen WRITE setRubberBandPen )
*/
public:
    /*!
      Rubber band style

      The default value is QwtPicker::NoRubberBand.
      \sa setRubberBand(), rubberBand()
    */

    enum RubberBand
    {
        //! No rubberband.
        NoRubberBand = 0,

        //! A horizontal line ( only for QwtPickerMachine::PointSelection )
        HLineRubberBand,

        //! A vertical line ( only for QwtPickerMachine::PointSelection )
        VLineRubberBand,

        //! A crosshair ( only for QwtPickerMachine::PointSelection )
        CrossRubberBand,

        //! A rectangle ( only for QwtPickerMachine::RectSelection )
        RectRubberBand,

        //! An ellipse ( only for QwtPickerMachine::RectSelection )
        EllipseRubberBand,

        //! A polygon ( only for QwtPickerMachine::PolygonSelection )
        PolygonRubberBand,

        /*!
          Values >= UserRubberBand can be used to define additional
          rubber bands.
         */
        UserRubberBand = 100
    };

    /*!
      \brief Display mode
      \sa setTrackerMode(), trackerMode(), isActive()
    */
    enum DisplayMode
    {
        //! Display never
        AlwaysOff,

        //! Display always
        AlwaysOn,

        //! Display only when the selection is active
        ActiveOnly
    };

    /*!
      Controls what to do with the selected points of an active
         selection when the observed widget is resized.

      The default value is QwtPicker::Stretch.
      \sa setResizeMode()
    */

    enum ResizeMode
    {
        //! All points are scaled according to the new size,
        Stretch,

        //! All points remain unchanged.
        KeepSize
    };

    explicit QwtPicker( QWidget *parent  /TransferThis/);
    explicit QwtPicker( RubberBand rubberBand,
                        DisplayMode trackerMode, QWidget * /Transfer/);

    virtual ~QwtPicker();

    void setStateMachine( QwtPickerMachine * /Transfer/);
    //const QwtPickerMachine *stateMachine() const; FIXME
    QwtPickerMachine *stateMachine();

    void setRubberBand( RubberBand );
    RubberBand rubberBand() const;

    void setTrackerMode( DisplayMode );
    DisplayMode trackerMode() const;

    void setResizeMode( ResizeMode );
    ResizeMode resizeMode() const;

    void setRubberBandPen( const QPen & );
    QPen rubberBandPen() const;

    void setTrackerPen( const QPen & );
    QPen trackerPen() const;

    void setTrackerFont( const QFont & );
    QFont trackerFont() const;

    bool isEnabled() const;
    bool isActive() const;

    virtual bool eventFilter( QObject *, QEvent *);

    QWidget *parentWidget();
    //const QWidget *parentWidget() const; FIXME

    virtual QPainterPath pickArea() const;

    virtual void drawRubberBand( QPainter * ) const;
    virtual void drawTracker( QPainter * ) const;

    virtual QRegion rubberBandMask() const;

    //virtual QwtText trackerText( const QPoint &pos ) const; FIXME
    QPoint trackerPosition() const;
    virtual QRect trackerRect( const QFont & ) const;

    QPolygon selection() const;

public Q_SLOTS:
    void setEnabled( bool );

Q_SIGNALS:
    /*!
      A signal indicating, when the picker has been activated.
      Together with setEnabled() it can be used to implement
      selections with more than one picker.

      \param on True, when the picker has been activated
    */
    void activated( bool on );

    /*!
      A signal emitting the selected points,
      at the end of a selection.

      \param polygon Selected points
    */
    void selected( const QPolygon &polygon );

    /*!
      A signal emitted when a point has been appended to the selection

      \param pos Position of the appended point.
      \sa append(). moved()
    */
    void appended( const QPoint &pos );

    /*!
      A signal emitted whenever the last appended point of the
      selection has been moved.

      \param pos Position of the moved last point of the selection.
      \sa move(), appended()
    */
    void moved( const QPoint &pos );

    /*!
      A signal emitted whenever the last appended point of the
      selection has been removed.

      \param pos Position of the point, that has been removed
      \sa remove(), appended()
    */
    void removed( const QPoint &pos );
    /*!
      A signal emitted when the active selection has been changed.
      This might happen when the observed widget is resized.

      \param selection Changed selection
      \sa stretchSelection()
    */
    void changed( const QPolygon &selection );

protected:
    virtual QPolygon adjustedPoints( const QPolygon & ) const;

    virtual void transition( const QEvent *);

    virtual void begin();
    virtual void append( const QPoint & );
    virtual void move( const QPoint & );
    virtual void remove();
    virtual bool end( bool ok = true );

    virtual bool accept( QPolygon & ) const;
    virtual void reset();

    virtual void widgetMousePressEvent( QMouseEvent *);
    virtual void widgetMouseReleaseEvent( QMouseEvent *);
    virtual void widgetMouseDoubleClickEvent( QMouseEvent *);
    virtual void widgetMouseMoveEvent( QMouseEvent *);
    virtual void widgetWheelEvent( QWheelEvent *);
    virtual void widgetKeyPressEvent( QKeyEvent *);
    virtual void widgetKeyReleaseEvent( QKeyEvent *);
    virtual void widgetEnterEvent( QEvent *);
    virtual void widgetLeaveEvent( QEvent *);

    virtual void stretchSelection( const QSize &oldSize,
                                   const QSize &newSize );

    virtual void updateDisplay();

    //const QwtWidgetOverlay *rubberBandOverlay() const;FIXME
    //const QwtWidgetOverlay *trackerOverlay() const; FIXME

    const QPolygon &pickedPoints() const;

private:
    void init( QWidget *, RubberBand rubberBand, DisplayMode trackerMode );

    void setMouseTracking( bool );

    //class PrivateData;
    //PrivateData *d_data;
};
