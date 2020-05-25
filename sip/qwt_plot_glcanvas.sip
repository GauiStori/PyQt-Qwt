/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/


/*!
  \brief An alternative canvas for a QwtPlot derived from QGLWidget

  QwtPlotGLCanvas implements the very basics to act as canvas
  inside of a QwtPlot widget. It might be extended to a full
  featured alternative to QwtPlotCanvas in a future version of Qwt.

  Even if QwtPlotGLCanvas is not derived from QFrame it imitates
  its API. When using style sheets it supports the box model - beside
  backgrounds with rounded borders.

  \sa QwtPlot::setCanvas(), QwtPlotCanvas

  \note With Qt4 you might want to use the QPaintEngine::OpenGL paint engine
        ( see QGL::setPreferredPaintEngine() ). On a Linux test system
        QPaintEngine::OpenGL2 shows very basic problems like translated
        geometries.
*/
class QwtPlotGLCanvas: public QGLWidget
{
%TypeHeaderCode
#include <qwt_plot_glcanvas.h>
%End
public:
    /*!
        \brief Frame shadow

         Unfortunately it is not possible to use QFrame::Shadow
         as a property of a widget that is not derived from QFrame.
         The following enum is made for the designer only. It is safe
         to use QFrame::Shadow instead.
     */
    enum Shadow
    {
        //! QFrame::Plain
        Plain = QFrame::Plain,

        //! QFrame::Raised
        Raised = QFrame::Raised,

        //! QFrame::Sunken
        Sunken = QFrame::Sunken
    };

    /*!
        \brief Frame shape

        Unfortunately it is not possible to use QFrame::Shape
        as a property of a widget that is not derived from QFrame.
        The following enum is made for the designer only. It is safe
        to use QFrame::Shadow instead.

        \note QFrame::StyledPanel and QFrame::WinPanel are unsupported
              and will be displayed as QFrame::Panel.
     */
    enum Shape
    {
        NoFrame = QFrame::NoFrame,

        Box = QFrame::Box,
        Panel = QFrame::Panel
    };

    explicit QwtPlotGLCanvas( QwtPlot * = NULL );
    virtual ~QwtPlotGLCanvas();

    void setFrameStyle( int style );
    int frameStyle() const;

    void setFrameShadow( Shadow );
    Shadow frameShadow() const;

    void setFrameShape( Shape );
    Shape frameShape() const;

    void setLineWidth( int );
    int lineWidth() const;

    void setMidLineWidth( int );
    int midLineWidth() const;

    int frameWidth() const;
    QRect frameRect() const;

    QPainterPath borderPath( const QRect & ) const;

    virtual bool event( QEvent * );

public:
    void replot();

protected:
    virtual void paintEvent( QPaintEvent * );

    virtual void drawBackground( QPainter * );
    virtual void drawBorder( QPainter * );
    virtual void drawItems( QPainter * );

/*    
private:
    class PrivateData;
    PrivateData *d_data;
    */
};


