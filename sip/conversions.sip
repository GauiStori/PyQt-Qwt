/* Code borrowed from qgis */

%MappedType QVector< QVector<qreal> >
{
%TypeHeaderCode
#include <QVector>
%End
%ConvertFromTypeCode
  // Create the list.
  PyObject *l;

  if ((l = PyList_New(sipCpp->size())) == NULL)
    return NULL;

  const sipMappedType* qvector_qreal = sipFindType("QVector<qreal>");

  // Set the list elements.
  for (int i = 0; i < sipCpp->size(); ++i)
  {
    QVector<qreal>* t = new QVector<qreal>(sipCpp->at(i));
    PyObject *tobj;

    if ((tobj = sipConvertFromType(t, qvector_qreal, sipTransferObj)) == NULL)
    {
      Py_DECREF(l);
      delete t;
      return NULL;
    }
    PyList_SET_ITEM(l, i, tobj);
  }

  return l;
%End

%ConvertToTypeCode
  const sipMappedType* qvector_qreal = sipFindType("QVector<qreal>");

  // Check the type if that is all that is required.
  if (sipIsErr == NULL)
  {
    if (!PyList_Check(sipPy))
      return 0;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
      if (!sipCanConvertToType(PyList_GET_ITEM(sipPy, i), qvector_qreal, SIP_NOT_NONE))
        return 0;

    return 1;
  }


  QVector< QVector<qreal> > *ql = new QVector< QVector<qreal> >;

  for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
  {
    int state;
    //qreal *t = reinterpret_cast<qreal *>(sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_qreal, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
    QVector<qreal> * t = reinterpret_cast< QVector<qreal> * >(sipConvertToType(PyList_GET_ITEM(sipPy, i), qvector_qreal, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

    if (*sipIsErr)
    {
      sipReleaseType(t, qvector_qreal, state);
      delete ql;
      return 0;
    }
    ql->append(*t);
    sipReleaseType(t, qvector_qreal, state);
  }

  *sipCppPtr = ql;
  return sipGetState(sipTransferObj);
%End
};

