# PyQt-Qwt
Python PyQt wrapper for Qwt6

The code is only tested for python3 and Qt5 but it
is written to work for python2/3 Qt4/5

The qwt include files must be patched to build PyQt-Qwt.



BUILD:

Dependencies in Debian:
pyqt5-dev pyqt5-dev-tools python3-pyqt5

A proper configure.py file has been added. To use it on Debian
which supports coexisting Qt libraries (4 and 5) you need to 
add QT_SELECT ahead of the command line.

cp -a /usr/include/qwt .
cd qwt
patch -p2  < ../06_python_compat.patch
cd ..
QT_SELECT=qt5 python3 configure.py --qwt-incdir=qwt
make
cp Qwt.so  qt5examples/
cd qt5examples
python3 bode.py
