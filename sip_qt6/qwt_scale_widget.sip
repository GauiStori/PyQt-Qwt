/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
class QwtScaleWidget : public QWidget
{
%TypeHeaderCode
#include <qwt_scale_widget.h>
%End
public:
    //! Layout flags of the title
    enum LayoutFlag
    {
        /*!
          The title of vertical scales is painted from top to bottom. 
          Otherwise it is painted from bottom to top.
         */
        TitleInverted = 1
    };

    //! Layout flags of the title
    //typedef QFlags<LayoutFlag> LayoutFlags;

    explicit QwtScaleWidget( QWidget *parent /TransferThis/ = NULL );
    explicit QwtScaleWidget( QwtScaleDraw::Alignment, QWidget *parent /TransferThis/ = NULL );
    virtual ~QwtScaleWidget();

signals:
    //! Signal emitted, whenever the scale division changes
    void scaleDivChanged();

public:
    void setTitle( const QString &title );
    //void setTitle( const QwtText &title );
    //QwtText title() const;

    void setLayoutFlag( LayoutFlag, bool on );
    bool testLayoutFlag( LayoutFlag ) const;

    void setBorderDist( int start, int end );
    int startBorderDist() const;
    int endBorderDist() const;

    void getBorderDistHint( int &start, int &end ) const;

    void getMinBorderDist( int &start, int &end ) const;
    void setMinBorderDist( int start, int end );

    void setMargin( int );
    int margin() const;

    void setSpacing( int td );
    int spacing() const;

    void setScaleDiv( const QwtScaleDiv &sd );
    //void setTransformation( QwtTransform * );

    void setScaleDraw( QwtScaleDraw * /Transfer/);
    //const QwtScaleDraw *scaleDraw() const;
    QwtScaleDraw *scaleDraw();

    void setLabelAlignment( Qt::Alignment );
    void setLabelRotation( double rotation );

    void setColorBarEnabled( bool );
    bool isColorBarEnabled() const;

    void setColorBarWidth( int );
    int colorBarWidth() const;

    void setColorMap( const QwtInterval &, QwtColorMap * /Transfer/);

    QwtInterval colorBarInterval() const;
    //const QwtColorMap *colorMap() const;

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    int titleHeightForWidth( int width ) const;
    int dimForLength( int length, const QFont &scaleFont ) const;

    void drawColorBar( QPainter *painter /Transfer/, const QRectF & ) const;
    void drawTitle( QPainter *painter /Transfer/, QwtScaleDraw::Alignment,
        const QRectF &rect ) const;

    void setAlignment( QwtScaleDraw::Alignment );
    QwtScaleDraw::Alignment alignment() const;

    QRectF colorBarRect( const QRectF& ) const;

protected:
    virtual void paintEvent( QPaintEvent *);
    virtual void resizeEvent( QResizeEvent *);

    void draw( QPainter *p /Transfer/) const;

    void scaleChange();
    void layoutScale( bool update = true );

/*private:
    void initScale( QwtScaleDraw::Alignment );

    class PrivateData;
    PrivateData *d_data;*/
};
