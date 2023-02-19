/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtCounter: QWidget
{
%TypeHeaderCode
#include <qwt_counter.h>
%End
    //Q_OBJECT

    /*Q_PROPERTY( double value READ value WRITE setValue )
    Q_PROPERTY( double minimum READ minimum WRITE setMinimum )
    Q_PROPERTY( double maximum READ maximum WRITE setMaximum )
    Q_PROPERTY( double singleStep READ singleStep WRITE setSingleStep )

    Q_PROPERTY( int numButtons READ numButtons WRITE setNumButtons )
    Q_PROPERTY( int stepButton1 READ stepButton1 WRITE setStepButton1 )
    Q_PROPERTY( int stepButton2 READ stepButton2 WRITE setStepButton2 )
    Q_PROPERTY( int stepButton3 READ stepButton3 WRITE setStepButton3 )

    Q_PROPERTY( bool readOnly READ isReadOnly WRITE setReadOnly )
    Q_PROPERTY( bool wrapping READ wrapping WRITE setWrapping )*/

public:
    //! Button index
    enum Button
    {
        //! Button intended for minor steps
        Button1,

        //! Button intended for medium steps
        Button2,

        //! Button intended for large steps
        Button3,

        //! Number of buttons
        ButtonCnt
    };

    explicit QwtCounter( QWidget *parent = NULL );
    virtual ~QwtCounter();

    void setValid( bool );
    bool isValid() const;

    void setWrapping( bool );
    bool wrapping() const;

    bool isReadOnly() const;
    void setReadOnly( bool );

    void setNumButtons( int n );
    int numButtons() const;

    void setIncSteps( QwtCounter::Button btn, int nSteps );
    int incSteps( QwtCounter::Button btn ) const;

    virtual QSize sizeHint() const;

    double singleStep() const;
    void setSingleStep( double s );

    void setRange( double min, double max );
    
    double minimum() const;
    void setMinimum( double min );

    double maximum() const;
    void setMaximum( double max );

    void setStepButton1( int nSteps );
    int stepButton1() const;

    void setStepButton2( int nSteps );
    int stepButton2() const;

    void setStepButton3( int nSteps );
    int stepButton3() const;

    double value() const;

public Q_SLOTS:
    void setValue( double );


Q_SIGNALS:
    void buttonReleased ( double value );
    void valueChanged ( double value );

protected:
    virtual bool event( QEvent *);
    virtual void wheelEvent( QWheelEvent *);
    virtual void keyPressEvent( QKeyEvent *);

/*private Q_SLOTS:
    void btnReleased();
    void btnClicked();
    void textChanged();

private:
    void incrementValue( int numSteps );
    void initCounter();
    void updateButtons();
    void showNumber( double );

    class PrivateData;
    PrivateData *d_data;*/
};
