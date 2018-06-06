# PyQt-Qwt
Python PyQt wrapper for Qwt6

The code is tested for python2/3 and Qt4/5.
oscilloscope.py is unfinished.
animation.py works only for qt5.
All the other examples have been tested to work on 
Debian Linux.
The qwt include files must be patched to build PyQt-Qwt.



BUILD:

******* IMPORTANT *********

The PyQt-Qwt doesn't build against unpatched Qwt version 6.1.3.
The header files need to be patched with 06_python_compat.patch
but for convenience the patched files are kept in the header
directory.
Do the following before compiling:

cp -a /usr/include/qwt header

cp header/qwt*.h header/qwt/

Linux:

Dependencies in Debian:

$ sudo apt-get install pyqt5-dev pyqt5-dev-tools python3-pyqt5 libqwt-qt5-dev libqwt-headers

A proper configure.py file has been added. To use it on Debian
which supports coexisting Qt libraries (4 and 5) you need to 
add QT_SELECT ahead of the command line.



$ QT_SELECT=qt5 python configure.py --qwt-incdir=header/qwt --qwt-libdir=/usr/lib --qwt-lib=qwt-qt5

$ QT_SELECT=qt5 python3 configure.py --qwt-incdir=header/qwt --qwt-libdir=/usr/lib --qwt-lib=qwt-qt5

$ QT_SELECT=qt4 python configure_new.py --qwt-incdir=header/qwt --qwt-libdir=/usr/lib --pyqt=PyQt4

$ QT_SELECT=qt4 python3 configure_new.py --qwt-incdir=header/qwt --qwt-libdir=/usr/lib --pyqt=PyQt4

$ make

$ sudo make install

$ cd qt5examples

$ python3 bode.py

$ for name in *.py; do python3 $name; done

Windows:

MSVC2015

Assuming the default installation directory, c:\qwt-6.1.3

Compile Qwt with the following parts in qwtconfig.pri commented out:

#QWT_CONFIG += QwtDll

#QWT_CONFIG += QwtSvg

#QWT_CONFIG += QwtOpenGL

#QWT_CONFIG += QwtMathML


Open "Qt 5.9.2 32-bit for Desktop (MSVC2015)" command prompt
run

"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"

copy header\qwt*.h c:\qwt-6.1.3\include

python configure.py --qwt-incdir=c:\qwt-6.1.3\include --qwt-libdir=c:\qwt-6.1.3\lib

nmake

