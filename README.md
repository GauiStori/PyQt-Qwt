# PyQt-Qwt
Python PyQt wrapper for Qwt6

The code is only tested for python3 and Qt5 but it
is written to work for python2/3 Qt4/5

The Qwt6 library must be patched with the patch
06_python_compat.patch in order to compile the code.
Hopefully there is some error in the python wrapper
that requires the patch.

A proper configure.py file has been added. To use it on Debian
which supports coexisting Qt libraries (4 and 5) you need to 
add QT_SELECT ahead of the command line.

QT_SELECT=qt5 python3 configure.py --qwt-incdir=/usr/include/qwt

Dependencies in Debian:
pyqt5-dev pyqt5-dev-tools python3-pyqt5
