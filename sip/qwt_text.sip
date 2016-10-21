/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtText
{
%TypeHeaderCode
#include <qwt_text.h>
%End

public:
    enum TextFormat
    {
        AutoText = 0,
        PlainText,
        RichText,
        MathMLText,
        TeXText,
        OtherFormat = 100
    };

    enum PaintAttribute
    {
        PaintUsingTextFont = 0x01,
        PaintUsingTextColor = 0x02,
        PaintBackground = 0x04
    };

    typedef QFlags<QwtText::PaintAttribute> PaintAttributes;
    enum LayoutAttribute
    {
        MinimumLayout = 0x01
    };

    //! Layout attributes
    typedef QFlags<QwtText::LayoutAttribute> LayoutAttributes;

    QwtText( const QwtText & );
    QwtText( const QString & = QString::null, QwtText::TextFormat textFormat = AutoText );
    ~QwtText();

    bool operator==( const QwtText & ) const;
    bool operator!=( const QwtText & ) const;

    void setText( const QString &, QwtText::TextFormat textFormat = AutoText );
    QString text() const;

    bool isNull() const;
    bool isEmpty() const;

    void setFont( const QFont & );
    QFont font() const;

    QFont usedFont( const QFont & ) const;

    void setRenderFlags( int flags );
    int renderFlags() const;

    void setColor( const QColor & );
    QColor color() const;

    QColor usedColor( const QColor & ) const;

    void setBorderRadius( double );
    double borderRadius() const;

    void setBorderPen( const QPen & );
    QPen borderPen() const;

    void setBackgroundBrush( const QBrush & );
    QBrush backgroundBrush() const;

    void setPaintAttribute( QwtText::PaintAttribute, bool on = true );
    bool testPaintAttribute( QwtText::PaintAttribute ) const;

    void setLayoutAttribute( QwtText::LayoutAttribute, bool on = true );
    bool testLayoutAttribute( QwtText::LayoutAttribute ) const;

    double heightForWidth( double width, const QFont & = QFont() ) const;
    QSizeF textSize( const QFont & = QFont() ) const;

    void draw( QPainter *painter, const QRectF &rect ) const;

    static const QwtTextEngine *textEngine( 
        const QString &text, QwtText::TextFormat = AutoText );

    static const QwtTextEngine *textEngine( QwtText::TextFormat );
    static void setTextEngine( QwtText::TextFormat, QwtTextEngine * );

private:
    QwtText &operator=( const QwtText & );
/*    class PrivateData;
    PrivateData *d_data;

    class LayoutCache;
    LayoutCache *d_layoutCache;*/
};

/*
//! \return text().isNull()
inline bool QwtText::isNull() const
{
    return text().isNull();
}

//! \return text().isEmpty()
inline bool QwtText::isEmpty() const
{
    return text().isEmpty();
}

Q_DECLARE_OPERATORS_FOR_FLAGS( QwtText::PaintAttributes )
Q_DECLARE_OPERATORS_FOR_FLAGS( QwtText::LayoutAttributes )

Q_DECLARE_METATYPE( QwtText )

*/
