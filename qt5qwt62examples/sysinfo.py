#!/usr/bin/python

import sys
from PyQt5 import Qwt
import math
import numpy as np

from PyQt5.QtCore import pyqtSignal, Qt,  QSize, QBasicTimer
from PyQt5.QtGui import QColor,  QPixmap, QFont,  QIcon,  QPalette, QLinearGradient
from PyQt5.QtWidgets import (QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication,  QSizePolicy, 
    QVBoxLayout,  QFrame, QGroupBox, QVBoxLayout )

class ValueBar(QWidget):
    def __init__(self, orientation, text, parent, value = 0.0 ):
        QWidget.__init__(self, parent)
        self.d_label = QLabel( text, self )
        self.d_label.setFont( QFont( "Helvetica", 10 ) )

        self.d_thermo = Qwt.QwtThermo( self )
        self.d_thermo.setOrientation( orientation )
        self.d_thermo.setScale( 0.0, 100.0 )
        self.d_thermo.setValue( value )
        self.d_thermo.setFont( QFont( "Helvetica", 8 ) )
        self.d_thermo.setPipeWidth( 6 )
        self.d_thermo.setScaleMaxMajor( 6 )
        self.d_thermo.setScaleMaxMinor( 5 )
        self.d_thermo.setFillBrush( Qt.darkMagenta )

        #if 0
        colorMap = Qwt.QwtLinearColorMap( Qt.blue, Qt.red )

        colorMap.addColorStop( 0.2, Qt.yellow )
        colorMap.addColorStop( 0.3, Qt.cyan )
        colorMap.addColorStop( 0.4, Qt.green )
        colorMap.addColorStop( 0.5, Qt.magenta )
        colorMap.setMode( Qwt.QwtLinearColorMap.FixedColors )
        self.d_thermo.setColorMap( colorMap )
        #endif"""

        self.layout = QVBoxLayout( self )
        #self.layout.setCanvasMargin( 0 )
        self.layout.setSpacing( 0 )

        if ( orientation == Qt.Horizontal ):
            self.d_label.setAlignment( Qt.AlignCenter )
            self.d_thermo.setScalePosition( Qwt.QwtThermo.LeadingScale )
            self.layout.addWidget( self.d_label )
            self.layout.addWidget( self.d_thermo )
        else:
            self.d_label.setAlignment( Qt.AlignRight )
            self.d_thermo.setScalePosition( Qwt.QwtThermo.TrailingScale )
            self.layout.addWidget( self.d_thermo, 10, Qt.AlignHCenter )
            self.layout.addWidget( self.d_label, 0 )

    def setValue(self, value ):
        self.d_thermo.setValue( value )

class SysInfo(QFrame):
    def __init__(self, parent = None):
        QFrame.__init__(self, parent )
        self.memBox = QGroupBox( "Memory Usage", self )
        self.memBox.setFont( QFont( "Helvetica", 10 ) )

        self.memLayout = QVBoxLayout( self.memBox )
        #self.memLayout.setMargin( 15 )
        self.memLayout.setSpacing( 5 )

        o = Qt.Horizontal
        self.memLayout.addWidget( ValueBar( o, "Used", self.memBox, 57 ) )
        self.memLayout.addWidget( ValueBar( o, "Shared", self.memBox, 17 ) )
        self.memLayout.addWidget( ValueBar( o, "Cache", self.memBox, 30 ) )
        self.memLayout.addWidget( ValueBar( o, "Buffers", self.memBox, 22 ) )
        self.memLayout.addWidget( ValueBar( o, "Swap Used", self.memBox, 57 ) )
        self.memLayout.addWidget( QWidget( self.memBox ), 10 ) # spacer

        self.cpuBox = QGroupBox( "Cpu Usage", self )
        self.cpuBox.setFont( QFont( "Helvetica", 10 ) )

        self.cpuLayout = QHBoxLayout( self.cpuBox )
        self.cpuLayout.setContentsMargins( 15,15,15,15 )
        self.cpuLayout.setSpacing( 5 )

        o = Qt.Vertical
        self.cpuLayout.addWidget( ValueBar( o, "User", self.cpuBox, 57 ) )
        self.cpuLayout.addWidget( ValueBar( o, "Total", self.cpuBox, 73 ) )
        self.cpuLayout.addWidget( ValueBar( o, "System", self.cpuBox, 16 ) )
        self.cpuLayout.addWidget( ValueBar( o, "Idle", self.cpuBox, 27 ) )

        self.layout = QHBoxLayout( self )
        self.layout.setContentsMargins( 10, 10, 10, 10 )
        self.layout.addWidget( self.memBox, 10 )
        self.layout.addWidget( self.cpuBox, 0 )


a = QApplication(sys.argv)
info = SysInfo()
info.resize( info.sizeHint().expandedTo( QSize( 600, 400 ) ) )
info.show()

sys.exit(a.exec_())
