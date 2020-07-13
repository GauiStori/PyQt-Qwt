// QMap<double, QString> is implemented as a Python dictionary.

%MappedType QMap<double,QString> /TypeHint="Dict[double,QString]", TypeHintValue="{}"/
{
%TypeHeaderCode
#include <qwt_compass.h>
%End

%ConvertFromTypeCode
    // Create the dictionary.
    PyObject *d = PyDict_New();

    if (!d)
        return NULL;

    // Set the dictionary elements.
    QMap<double,QString>::const_iterator i = sipCpp->constBegin();

    while (i != sipCpp->constEnd())
    {
        QString *t = new QString(i.value());

        PyObject *kobj = PyFloat_FromDouble(i.key());
        PyObject *tobj = sipConvertFromType(t, sipType_QString, sipTransferObj);

        if (kobj == NULL || tobj == NULL || PyDict_SetItem(d, kobj, tobj) < 0)
        {
            Py_DECREF(d);
            if (kobj)
            {
                Py_DECREF(kobj);
            }
            if (tobj)
            {
                Py_DECREF(tobj);
            }
            else
            {
                delete t;
            }
            return NULL;
        }
        Py_DECREF(kobj);
        Py_DECREF(tobj);
        ++i;
    }
    return d;
%End

%ConvertToTypeCode
    PyObject *kobj, *tobj;
    SIP_SSIZE_T i = 0;
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyDict_Check(sipPy))
            return 0;
        while (PyDict_Next(sipPy, &i, &kobj, &tobj))
            if (!sipCanConvertToType(tobj, sipType_QString, SIP_NOT_NONE))
                return 0;
        return 1;
    }
    QMap<double,QString> *qm = new QMap<double,QString>;
    while (PyDict_Next(sipPy, &i, &kobj, &tobj))
    {
        int state;
        double k = PyFloat_AS_DOUBLE(kobj);
        QString *t = reinterpret_cast<QString *>(sipConvertToType(tobj, sipType_QString, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
        if (*sipIsErr)
        {
            sipReleaseType(t, sipType_QString, state);
            delete qm;
            return 0;
        }
        qm->insert(k, *t);
        sipReleaseType(t, sipType_QString, state);
    }
    *sipCppPtr = qm;
    return sipGetState(sipTransferObj);
%End
};

