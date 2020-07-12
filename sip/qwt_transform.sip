/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

class QwtTransform
{
%TypeHeaderCode
#include <qwt_transform.h>
%End
public:
    QwtTransform();
    virtual ~QwtTransform();

    /*!
       Modify value to be a valid value for the transformation.
       The default implementation does nothing.
     */
    virtual double bounded( double value ) const;

    /*!
        Transformation function

        \param value Value
        \return Modified value

        \sa invTransform()
     */
    virtual double transform( double value ) const = 0;

    /*!
        Inverse transformation function

        \param value Value
        \return Modified value

        \sa transform()
     */
    virtual double invTransform( double value ) const = 0;

    //! Virtualized copy operation
    virtual QwtTransform *copy() const = 0;
};

/*!
   \brief Null transformation

   QwtNullTransform returns the values unmodified.
   
 */
class QwtNullTransform: QwtTransform
{
%TypeHeaderCode
#include <qwt_transform.h>
%End
public:
    QwtNullTransform();
    virtual ~QwtNullTransform();

    virtual double transform( double value ) const;
    virtual double invTransform( double value ) const;

    virtual QwtTransform *copy() const;
};
/*!
   \brief Logarithmic transformation

   QwtLogTransform modifies the values using log() and exp().

   \note In the calculations of QwtScaleMap the base of the log function
         has no effect on the mapping. So QwtLogTransform can be used 
         for log2(), log10() or any other logarithmic scale.
 */
class QwtLogTransform: QwtTransform
{   
%TypeHeaderCode
#include <qwt_transform.h>
%End
public:
    QwtLogTransform();
    virtual ~QwtLogTransform();
    
    virtual double transform( double value ) const;
    virtual double invTransform( double value ) const;

    virtual double bounded( double value ) const;

    virtual QwtTransform *copy() const;

//#if QT_VERSION >= 0x050400
    static const double LogMin;
    static const double LogMax;
/*#else
    QT_STATIC_CONST double LogMin;
    QT_STATIC_CONST double LogMax;
#endif*/
};

/*!
   \brief A transformation using pow()

   QwtPowerTransform preserves the sign of a value. 
   F.e. a transformation with a factor of 2
   transforms a value of -3 to -9 and v.v. Thus QwtPowerTransform
   can be used for scales including negative values.
 */
class QwtPowerTransform: QwtTransform
{
%TypeHeaderCode
#include <qwt_transform.h>
%End
public:
    QwtPowerTransform( double exponent );
    virtual ~QwtPowerTransform();

    virtual double transform( double value ) const;
    virtual double invTransform( double value ) const;

    virtual QwtTransform *copy() const;

private:
    QwtPowerTransform& operator=(const QwtPowerTransform&);
};
