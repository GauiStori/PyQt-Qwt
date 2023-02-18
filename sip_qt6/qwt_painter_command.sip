/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

/*!
  QwtPainterCommand represents the attributes of a paint operation
  how it is used between QPainter and QPaintDevice

  It is used by QwtGraphic to record and replay paint operations

  \sa QwtGraphic::commands()
 */

%If(- Qwt_6_1_6)
class QwtPainterCommand
{
%TypeHeaderCode
#include <qwt_painter_command.h>
%End

public:
    //! Type of the paint command
    enum Type
    {
        //! Invalid command
        Invalid = -1,

        //! Draw a QPainterPath
        Path,

        //! Draw a QPixmap
        Pixmap,

        //! Draw a QImage
        Image,

        //! QPainter state change
        State
    };

    //! Attributes how to paint a QPixmap
    struct PixmapData
    {
        QRectF rect;
        QPixmap pixmap;
        QRectF subRect;
    };

    //! Attributes how to paint a QImage
    struct ImageData
    {
        QRectF rect;
        QImage image;
        QRectF subRect;
        Qt::ImageConversionFlags flags;
    };

    //! Attributes of a state change
    struct StateData
    {
        QPaintEngine::DirtyFlags flags;

        QPen pen;
        QBrush brush;
        QPointF brushOrigin;
        QBrush backgroundBrush;
        Qt::BGMode backgroundMode;
        QFont font;
	%TypeCode
 	  QMatrix matrix; //qmatrix.sip missing !!!???
	%End
	
        QTransform transform;

        Qt::ClipOperation clipOperation;
        QRegion clipRegion;
        QPainterPath clipPath;
        bool isClipEnabled;

        QPainter::RenderHints renderHints;
        QPainter::CompositionMode compositionMode;
        qreal opacity;
    };

    QwtPainterCommand();
    QwtPainterCommand(const QwtPainterCommand &);

    QwtPainterCommand( const QPainterPath & );

    QwtPainterCommand( const QRectF &rect,
            const QPixmap &, const QRectF& subRect );

    QwtPainterCommand( const QRectF &rect,
            const QImage &, const QRectF& subRect,
            Qt::ImageConversionFlags );

    QwtPainterCommand( const QPaintEngineState & );

    ~QwtPainterCommand();

    Type type() const;

    QPainterPath *path();
    //const QPainterPath *path() const;

    PixmapData* pixmapData();
    //const PixmapData* pixmapData() const;

    ImageData* imageData();
    //const ImageData* imageData() const;

    StateData* stateData();
    //const StateData* stateData() const;

private:
    QwtPainterCommand &operator=(const QwtPainterCommand & );

/*
    void copy( const QwtPainterCommand & );
    void reset();

    Type d_type;

    union
    {
        QPainterPath *d_path;
        PixmapData *d_pixmapData;
        ImageData *d_imageData;
        StateData *d_stateData;
    };
    */
};
%End // (- Qwt_6_1_6)

%If(Qwt_6_2_0 -)
class QwtPainterCommand
{
%TypeHeaderCode
#include <qwt_painter_command.h>
%End
  public:
    //! Type of the paint command
    enum Type
    {
        //! Invalid command
        Invalid = -1,

        //! Draw a QPainterPath
        Path,

        //! Draw a QPixmap
        Pixmap,

        //! Draw a QImage
        Image,

        //! QPainter state change
        State
    };

    //! Attributes how to paint a QPixmap
    struct PixmapData
    {
        QRectF rect;
        QPixmap pixmap;
        QRectF subRect;
    };

    //! Attributes how to paint a QImage
    struct ImageData
    {
        QRectF rect;
        QImage image;
        QRectF subRect;
        Qt::ImageConversionFlags flags;
    };

    //! Attributes of a state change
    struct StateData
    {
        QPaintEngine::DirtyFlags flags;

        QPen pen;
        QBrush brush;
        QPointF brushOrigin;
        QBrush backgroundBrush;
        Qt::BGMode backgroundMode;
        QFont font;
        QTransform transform;

        Qt::ClipOperation clipOperation;
        QRegion clipRegion;
        QPainterPath clipPath;
        bool isClipEnabled;

        QPainter::RenderHints renderHints;
        QPainter::CompositionMode compositionMode;
        qreal opacity;
    };

    QwtPainterCommand();
    QwtPainterCommand(const QwtPainterCommand&);

    explicit QwtPainterCommand( const QPainterPath& );

    QwtPainterCommand( const QRectF& rect,
        const QPixmap&, const QRectF& subRect );

    QwtPainterCommand( const QRectF& rect,
        const QImage&, const QRectF& subRect,
        Qt::ImageConversionFlags );

    explicit QwtPainterCommand( const QPaintEngineState& );

    ~QwtPainterCommand();

    Type type() const;

    QPainterPath* path();
    //const QPainterPath* path() const;

    PixmapData* pixmapData();
    //const PixmapData* pixmapData() const;

    ImageData* imageData();
    //const ImageData* imageData() const;

    StateData* stateData();
    //const StateData* stateData() const;

  private:
    QwtPainterCommand& operator=(const QwtPainterCommand& );
/*    void copy( const QwtPainterCommand& );
    void reset();

    Type m_type;

    union
    {
        QPainterPath* m_path;
        PixmapData* m_pixmapData;
        ImageData* m_imageData;
        StateData* m_stateData;
    };*/
};
%End // (Qwt_6_2_0 -)
