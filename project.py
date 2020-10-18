"""The build configuration file for PyQt-Qwt, used by sip."""

import os
from os.path import abspath, join
from sipbuild import Option
from pyqtbuild import PyQtBindings, PyQtProject
import PyQt5


class QwtProject(PyQtProject):
    """The Qwt Project class."""

    def __init__(self):
        super().__init__()
        self.bindings_factories = [QwtBindings]

    def update(self, tool):
        """Allows SIP to find PyQt5 .sip files."""
        super().update(tool)
        self.sip_include_dirs.append(join(PyQt5.__path__[0], 'bindings'))


class QwtBindings(PyQtBindings):
    """The Qwt Bindings class."""

    def __init__(self, project):
        super().__init__(project, name='Qwt',
                         sip_file='qwt.sip',
                         qmake_QT=['widgets'])

    def get_options(self):
        """Our custom options that a user can pass to sip-build."""
        options = super().get_options()
        options += [
            Option('qwt_incdir',
                   help='the directory containing the Qwt header file',
                   metavar='DIR'),
            Option('qwt_featuresdir',
                   help='the directory containing the qwt.prf features file',
                   metavar='DIR'),
            Option('qwt_libdir',
                   help='the directory containing the Qwt library',
                   metavar='DIR'),
            Option('qwt_lib',
                   help='the Qwt library',
                   metavar='LIB',
                   default='qwt'),
        ]
        return options

    def apply_user_defaults(self, tool):
        """Apply values from user-configurable options."""
        if self.qwt_incdir is not None:
            self.include_dirs.append(self.qwt_incdir)
        if self.qwt_featuresdir is not None:
            os.environ['QMAKEFEATURES'] = abspath(self.qsci_features_dir)
        if self.qwt_libdir is not None:
            self.library_dirs.append(self.qwt_libdir)
        if self.qwt_lib is not None:
            self.libraries.append(self.qwt_lib)
        self.define_macros.append('QWT_PYTHON_WRAPPER')
        super().apply_user_defaults(tool)
