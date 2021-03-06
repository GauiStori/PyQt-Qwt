/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtTextLabel : public QFrame
{
%TypeHeaderCode
#include <qwt_text_label.h>
%End
    /*Q_OBJECT

    Q_PROPERTY( int indent READ indent WRITE setIndent )
    Q_PROPERTY( int margin READ margin WRITE setMargin )
    Q_PROPERTY( QString plainText READ plainText WRITE setPlainText )*/

public:
    explicit QwtTextLabel( QWidget *parent = NULL );
    explicit QwtTextLabel( const QwtText &, QWidget *parent = NULL );
    virtual ~QwtTextLabel();

    void setPlainText( const QString & );
    QString plainText() const;

public Q_SLOTS:
    void setText( const QString &,
        QwtText::TextFormat textFormat = QwtText::AutoText );
    virtual void setText( const QwtText & );

    void clear();

public:
    const QwtText &text() const;

    int indent() const;
    void setIndent( int );

    int margin() const;
    void setMargin( int );

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual int heightForWidth( int ) const;

    QRect textRect() const;

    virtual void drawText( QPainter *, const QRectF & );

protected:
    virtual void paintEvent( QPaintEvent *e );
    virtual void drawContents( QPainter * );

/*private:
    void init();
    int defaultIndent() const;

    class PrivateData;
    PrivateData *d_data;*/
};
