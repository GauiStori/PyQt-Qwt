/* Code borrowed from qgis */

%MappedType QList< QList<qreal> >
{
%TypeHeaderCode
#include <QList>
%End
%ConvertFromTypeCode
  // Create the list.
  PyObject *l;

  if ((l = PyList_New(sipCpp->size())) == NULL)
    return NULL;

  const sipTypeDef* qvector_qreal = sipFindType("QList<qreal>");

  // Set the list elements.
  for (int i = 0; i < sipCpp->size(); ++i)
  {
    QList<qreal>* t = new QList<qreal>(sipCpp->at(i));
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
  const sipTypeDef* qvector_qreal = sipFindType("QList<qreal>");

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


  QList< QList<qreal> > *ql = new QList< QList<qreal> >;

  for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
  {
    int state;
    //qreal *t = reinterpret_cast<qreal *>(sipConvertToInstance(PyList_GET_ITEM(sipPy, i), sipClass_qreal, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));
    QList<qreal> * t = reinterpret_cast< QList<qreal> * >(sipConvertToType(PyList_GET_ITEM(sipPy, i), qvector_qreal, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

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

