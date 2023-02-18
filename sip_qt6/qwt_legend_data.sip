/* -*- mode: C++ ; c-file-style: "stroustrup" -*- *****************************
 * Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtLegendData
{
%TypeHeaderCode
#include <qwt_legend_data.h>
%End
public:
    //! Mode defining how a legend entry interacts
    enum Mode
    {
        //! The legend item is not interactive, like a label
        ReadOnly,

        //! The legend item is clickable, like a push button
        Clickable,

        //! The legend item is checkable, like a checkable button
        Checkable
    };

    //! Identifier how to interprete a QVariant
    enum Role
    {
        // The value is a Mode
        ModeRole, 

        // The value is a title
        TitleRole, 

        // The value is an icon
        IconRole, 

        // Values < UserRole are reserved for internal use
        UserRole  = 32
    };

    QwtLegendData();
    ~QwtLegendData();

    void setValues( const QMap<int, QVariant> & );
    const QMap<int, QVariant> &values() const;

    void setValue( int role, const QVariant & );
    QVariant value( int role ) const;

    bool hasRole( int role ) const;
    bool isValid() const;

    QwtGraphic icon() const;
    QwtText title() const;
    Mode mode() const;

//private:
//    QMap<int, QVariant> d_map;
};
