/* 
 * PyQt-Qwt Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2021   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

template<_TYPE_>
%MappedType QStack<_TYPE_>
{
%TypeHeaderCode
#include <qstack.h>
%End

%ConvertFromTypeCode
    PyObject *l;
    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    for (int i = 0; i < sipCpp->size(); ++i)
    {
        _TYPE_ *t = new _TYPE_(sipCpp->at(i));
        PyObject *tobj;

        if ((tobj = sipConvertFromType(t, sipType__TYPE_, sipTransferObj)) == NULL)
        {
            Py_DECREF(t);
            return NULL;
        }

        // Add the wrapper to the list.
        PyList_SET_ITEM(l, i, tobj);
    }
    return l;
%End

%ConvertToTypeCode
    if (!sipIsErr)
    {
        return PyList_Check(sipPy);
    }

    QStack<_TYPE_> *tl = new QStack<_TYPE_>;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
    {
        _TYPE_ *t;
        int state;
        t = reinterpret_cast<_TYPE_ *>(
                sipForceConvertToType(PyList_GET_ITEM(sipPy, i),
                        sipType__TYPE_, 0, SIP_NOT_NONE, &state,
                        sipIsErr));
        if (*sipIsErr)
        {
            sipReleaseType(t, sipType__TYPE_, state);
            delete t;
            return 0;
        }

        tl->append(*t);
        sipReleaseType(t, sipType__TYPE_, state);
    }
    *sipCppPtr = tl;
    return sipGetState(sipTransferObj);
%End
};
