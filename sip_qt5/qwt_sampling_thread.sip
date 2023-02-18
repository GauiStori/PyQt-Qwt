/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtSamplingThread: QThread
{
%TypeHeaderCode
#include <qwt_sampling_thread.h>
%End

public:
    virtual ~QwtSamplingThread();

    double interval() const;
    double elapsed() const;

public Q_SLOTS:
    void setInterval( double interval );
    void stop();

protected:
    explicit QwtSamplingThread( QObject *parent /TransferThis/ = NULL );

    virtual void run();

    virtual void sample( double elapsed ) = 0;

/*private:
    class PrivateData;
    PrivateData *d_data;*/
};
