/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtTextEngine
{
%TypeHeaderCode
#include <qwt_text_engine.h>
%End

public:
    virtual ~QwtTextEngine();
    virtual double heightForWidth( const QFont &font, int flags, const QString &text, double width ) const = 0;
    virtual QSizeF textSize( const QFont &font, int flags, const QString &text ) const = 0;
    virtual bool mightRender( const QString &text ) const = 0;
    virtual void textMargins( const QFont &font, const QString &text, double &left, double &right, double &top, double &bottom ) const = 0;
    virtual void draw( QPainter *painter, const QRectF &rect, int flags, const QString &text ) const = 0;

protected:
    QwtTextEngine();
};

class QwtPlainTextEngine: QwtTextEngine
{
%TypeHeaderCode
#include <qwt_text_engine.h>
%End

public:
    QwtPlainTextEngine();
    virtual ~QwtPlainTextEngine();

    virtual double heightForWidth( const QFont &font, int flags,
        const QString &text, double width ) const;

    virtual QSizeF textSize( const QFont &font, int flags,
        const QString &text ) const;

    virtual void draw( QPainter *painter, const QRectF &rect,
        int flags, const QString &text ) const;

    virtual bool mightRender( const QString & ) const;

    virtual void textMargins( const QFont &, const QString &,
        double &left, double &right, double &top, double &bottom ) const;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};


/*#ifndef QT_NO_RICHTEXT

class QWT_EXPORT QwtRichTextEngine: public QwtTextEngine
{
public:
    QwtRichTextEngine();

    virtual double heightForWidth( const QFont &font, int flags,
        const QString &text, double width ) const;

    virtual QSizeF textSize( const QFont &font, int flags,
        const QString &text ) const;

    virtual void draw( QPainter *painter, const QRectF &rect,
        int flags, const QString &text ) const;

    virtual bool mightRender( const QString & ) const;

    virtual void textMargins( const QFont &, const QString &,
        double &left, double &right, double &top, double &bottom ) const;

private:
    QString taggedText( const QString &, int flags ) const;
};

#endif // !QT_NO_RICHTEXT
*/
