"""The build configuration file for PyQt-Qwt, used by sip."""

import os
from os.path import abspath, join
from sipbuild import Option
from pyqtbuild import PyQtBindings, PyQtProject
#import PyQt6

def read_define(filename, define):
    """ Read the value of a #define from a file.  filename is the name of the
    file.  define is the name of the #define.  None is returned if there was no
    such #define.
    """

    f = open(filename)

    for l in f:
        wl = l.split()
        if len(wl) >= 3 and wl[0] == "#define" and wl[1] == define:
            # Take account of embedded spaces.
            value = ' '.join(wl[2:])[1:-1]
            break
    else:
        value = None

    f.close()

    return value

class QwtProject(PyQtProject):
    """The Qwt Project class."""

    def __init__(self):
        super().__init__()
        self.bindings_factories = [QwtBindings]

    #def update(self, tool):
    #    """Allows SIP to find PyQt6 .sip files."""
    #    super().update(tool)
    #    self.sip_include_dirs.append(join(PyQt6.__path__[0], 'bindings'))

    def apply_user_defaults(self, tool):
        """ Set default values for user options that haven't been set yet. """

        super().apply_user_defaults(tool)


class QwtBindings(PyQtBindings):
    """The Qwt Bindings class."""

    def __init__(self, project):
        super().__init__(project, 'Qwt')

    def apply_user_defaults(self, tool):
        """Apply values from user-configurable options."""
        project = self.project
        qt6 = (project.builder.qt_version >= 0x060000)

        # Set the name of the .sip file now that we know the Qt version number.
        self.sip_file = 'Qwt_Qt6.sip' if qt6 else 'Qwt_Qt5.sip'

        if self.qwt_incdir is not None:
            self.include_dirs.append(self.qwt_incdir)
        if self.qwt_featuresdir is not None:
            os.environ['QMAKEFEATURES'] = abspath(self.qsci_features_dir)
        if self.qwt_libdir is not None:
            self.library_dirs.append(self.qwt_libdir)
        if self.qwt_lib is not None:
            self.libraries.append(self.qwt_lib)
        self.define_macros.append('QWT_PYTHON_WRAPPER')
        # Add Qwt version tag. Used for Timeline
        qwtglobal = os.path.join(self.qwt_incdir, '', 'qwt_global.h')
        qwt_version = read_define(qwtglobal, 'QWT_VERSION_STR')
        if qwt_version is None:
            print("The Qwt version number could not be determined by "
                  "reading %s." % qwtglobal)
        tag = "Qwt_"+qwt_version.replace('.','_')
        self.tags.append(tag)
        print("Tag = ")
        print(tag)
        super().apply_user_defaults(tool)

    def get_options(self):
        """Our custom options that a user can pass to sip-build."""
        options = super().get_options()
        options.append(
            Option('qwt_incdir',
                   help='the directory containing the Qwt header file',
                   metavar='DIR'))
        options.append(
            Option('qwt_featuresdir',
                   help='the directory containing the qwt.prf features file',
                   metavar='DIR'))
        options.append(
            Option('qwt_libdir',
                   help='the directory containing the Qwt library',
                   metavar='DIR'))
        options.append(
            Option('qwt_lib',
                   help='the Qwt library',
                   metavar='LIB',
                   default='qwt'))
        return options
