#!/usr/bin/python

import sys
import math
#import Qwt
from PyQt5 import Qwt
import numpy as np

from PyQt5.QtCore import Qt, QSize
from PyQt5.QtGui import QColor, QPalette, QBrush #,  QPixmap, QFont,  QIcon
from PyQt5.QtWidgets import QApplication,  QTabWidget, QWidget, QBoxLayout, QVBoxLayout,  QHBoxLayout, QLayout, QGridLayout, QLabel #,  QToolBar,  QToolButton, QApplication
#from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

#include <qapplication.h>
#include <qtabwidget.h>
#include "slidertab.h"
#include "wheeltab.h"
#include "knobtab.h"
#include "dialtab.h"
#include <qlabel.h>
#include <qlayout.h>
#include <qwt_slider.h>
#include <qwt_scale_engine.h>
#include <qwt_transform.h>
#include "sliderbox.h"

class SliderBox(QWidget):
    def __init__(self,sliderType,parent = None):
        QWidget.__init__(self, parent)
        self.d_slider = self.createSlider( sliderType )
        self.alignment = None #QFlags(Qt.AlignmentFlag)

        if self.d_slider.orientation() == Qt.Horizontal:
            if self.d_slider.scalePosition() == Qwt.QwtSlider.TrailingScale:
                self.alignment = Qt.AlignBottom
            else:
                self.alignment = Qt.AlignTop
            self.alignment |= Qt.AlignHCenter
        else:
            if self.d_slider.scalePosition() == Qwt.QwtSlider.TrailingScale:
                self.alignment = Qt.AlignRight
            else:
                self.alignment = Qt.AlignLeft
            self.alignment |= Qt.AlignVCenter
        self.d_label = QLabel( self )
        self.d_label.setAlignment( self.alignment )
        self.d_label.setFixedWidth( self.d_label.fontMetrics().width( "10000.9" ) )
        self.d_slider.valueChanged['double'].connect(self.setNum)

        layout = None #QBoxLayout()
        if self.d_slider.orientation() == Qt.Horizontal:
            layout = QHBoxLayout( self )
        else:
            layout = QVBoxLayout( self )
        layout.addWidget( self.d_slider )
        layout.addWidget( self.d_label )

        self.setNum( self.d_slider.value() )

    def createSlider(self, sliderType ):
        slider = Qwt.QwtSlider()
        if sliderType == 0:
            slider.setOrientation( Qt.Horizontal )
            slider.setScalePosition( Qwt.QwtSlider.TrailingScale )
            slider.setTrough( True )
            slider.setGroove( False )
            slider.setSpacing( 0 )
            slider.setHandleSize( QSize( 30, 16 ) )
            slider.setScale( 10.0, -10.0 ) 
            slider.setTotalSteps( 8 ) 
            slider.setSingleSteps( 1 ) 
            slider.setPageSteps( 1 ) 
            slider.setWrapping( True )
        elif sliderType == 1:
            slider.setOrientation( Qt.Horizontal )
            slider.setScalePosition( Qwt.QwtSlider.NoScale )
            slider.setTrough( True )
            slider.setGroove( True )
            slider.setScale( 0.0, 1.0 )
            slider.setTotalSteps( 100 )
            slider.setSingleSteps( 1 )
            slider.setPageSteps( 5 )
        elif sliderType == 2:
            slider.setOrientation( Qt.Horizontal )
            slider.setScalePosition( Qwt.QwtSlider.LeadingScale )
            slider.setTrough( False )
            slider.setGroove( True )
            slider.setHandleSize( QSize( 12, 25 ) )
            slider.setScale( 1000.0, 3000.0 )
            slider.setTotalSteps( 200.0 )
            slider.setSingleSteps( 2 )
            slider.setPageSteps( 10 )
        elif sliderType == 3:
            slider.setOrientation( Qt.Horizontal )
            slider.setScalePosition( Qwt.QwtSlider.TrailingScale )
            slider.setTrough( True )
            slider.setGroove( True )
            #scaleEngine = Qwt.QwtLinearScaleEngine( 2 )
            #scaleEngine.setTransformation( Qwt.QwtPowerTransform( 2 ) )
            #slider.setScaleEngine( scaleEngine )
            slider.setScale( 0.0, 128.0 )
            slider.setTotalSteps( 100 )
            slider.setStepAlignment( False )
            slider.setSingleSteps( 1 )
            slider.setPageSteps( 5 )
        elif sliderType == 4:
            slider.setOrientation( Qt.Vertical )
            slider.setScalePosition( Qwt.QwtSlider.TrailingScale )
            slider.setTrough( False )
            slider.setGroove( True )
            slider.setScale( 100.0, 0.0 )
            slider.setInvertedControls( True )
            slider.setTotalSteps( 100 )
            slider.setPageSteps( 5 )
            slider.setScaleMaxMinor( 5 )
        elif sliderType == 5:
            slider.setOrientation( Qt.Vertical )
            slider.setScalePosition( Qwt.QwtSlider.NoScale )
            slider.setTrough( True )
            slider.setGroove( False )
            slider.setScale( 0.0, 100.0 )
            slider.setTotalSteps( 100 )
            slider.setPageSteps( 10 )
        elif sliderType == 6:
            slider.setOrientation( Qt.Vertical )
            slider.setScalePosition( Qwt.QwtSlider.LeadingScale )
            slider.setTrough( True )
            slider.setGroove( True )
            #slider.setScaleEngine( Qwt.QwtLogScaleEngine() )
            slider.setStepAlignment( False )
            slider.setHandleSize( QSize( 20, 32 ) )
            slider.setBorderWidth( 1 )
            slider.setScale( 1.0, 1.0e4 )
            slider.setTotalSteps( 100 )
            slider.setPageSteps( 10 )
            slider.setScaleMaxMinor( 9 )
        if ( slider ):
            slider.setObjectName( "Slider %d"%sliderType )
        return slider

    def setNum(self, v ):
        self.d_label.setText( "%.2f"%v )

class SliderTab( QWidget ):
    def __init__(self,parent=None):
        QWidget.__init__(self, parent)
        self.hLayout = self.createLayout( Qt.Vertical,  self )
        for i in range(4):
            self.hLayout.addWidget( SliderBox( i ) )
        self.hLayout.addStretch()
        self.vLayout = self.createLayout( Qt.Horizontal,  self )
        for i in range(1):#7):
            self.vLayout.addWidget( SliderBox( i) )
        self.mainLayout = self.createLayout( Qt.Horizontal, self )
        self.mainLayout.addLayout( self.vLayout )
        self.mainLayout.addLayout( self.hLayout, 10 )

    def createLayout(self, orientation, widget ):
        layout = QBoxLayout( QBoxLayout.LeftToRight, widget )
        if ( orientation == Qt.Vertical ):
            layout.setDirection( QBoxLayout.TopToBottom )
        layout.setSpacing( 20 )
        layout.setContentsMargins( 0,  0,  0,  0)
        return layout

#include <qlabel.h>
#include <qlayout.h>
#include <qwt_wheel.h>
#include <qwt_thermo.h>
#include <qwt_scale_engine.h>
#include <qwt_transform.h>
#include <qwt_color_map.h>
#include "wheelbox.h"

class WheelBox( QWidget ):
    def __init__(self, orientation, typ, parent=None ):
        QWidget.__init__(self, parent)
        box = self.createBox( orientation, typ )
        self.d_label = QLabel( self )
        self.d_label.setAlignment( Qt.AlignHCenter | Qt.AlignTop )

        layout = QVBoxLayout( self )
        layout.addWidget( box )
        layout.addWidget( self.d_label )

        self.setNum( self.d_wheel.value() )

        self.d_wheel.valueChanged['double'].connect( self.setNum )

    def createBox(self, orientation, typ ): 
        self.d_wheel = Qwt.QwtWheel()
        self.d_wheel.setValue( 80 )
        self.d_wheel.setWheelWidth( 20 )
        self.d_wheel.setMass( 1.0 )
        self.d_thermo = Qwt.QwtThermo()
        self.d_thermo.setOrientation( orientation )

        if ( orientation == Qt.Horizontal ):
            self.d_thermo.setScalePosition( Qwt.QwtThermo.LeadingScale )
            self.d_wheel.setOrientation( Qt.Vertical )
        else:
            self.d_thermo.setScalePosition( Qwt.QwtThermo.TrailingScale )
            self.d_wheel.setOrientation( Qt.Horizontal )
        if typ == 0:
            colorMap = Qwt.QwtLinearColorMap() 
            colorMap.setColorInterval( Qt.blue, Qt.red )
            self.d_thermo.setColorMap( colorMap )
        elif typ == 1:
            colorMap = Qwt.QwtLinearColorMap()
            colorMap.setMode( Qwt.QwtLinearColorMap.FixedColors )
            idx = 4
            colorMap.setColorInterval( Qt.GlobalColor( idx ),
                Qt.GlobalColor( idx + 10 ) )
            for i in range(10):
                colorMap.addColorStop( i / 10.0, Qt.GlobalColor( idx + i ) )
            self.d_thermo.setColorMap( colorMap )
        elif typ == 2:
            self.d_wheel.setRange( 10, 1000 )
            self.d_wheel.setSingleStep( 1.0 )
            #self.d_thermo.setScaleEngine( Qwt.QwtLogScaleEngine )
            self.d_thermo.setScaleMaxMinor( 10 )
            self.d_thermo.setFillBrush( Qt.darkCyan )
            self.d_thermo.setAlarmBrush( Qt.magenta )
            self.d_thermo.setAlarmLevel( 500.0 )
            self.d_wheel.setValue( 800 )
        elif typ == 3:
            self.d_wheel.setRange( -1000, 1000 )
            self.d_wheel.setSingleStep( 1.0 )
            #self.d_wheel.setPalette( QColor( "Tan" ) )

            #scaleEngine = Qwt.QwtLinearScaleEngine()
            #scaleEngine.setTransformation( Qwt.QwtPowerTransform( 2 ) )

            self.d_thermo.setScaleMaxMinor( 5 )
            #self.d_thermo.setScaleEngine( scaleEngine )

            pal = QPalette()
            pal.setColor( QPalette.Base, Qt.darkGray )
            #pal.setColor( QPalette.ButtonText, QColor( "darkKhaki" ) )

            self.d_thermo.setPalette( pal )
        elif typ == 4:
            self.d_wheel.setRange( -100, 300 )
            self.d_wheel.setInverted( True )

            colorMap = Qwt.QwtLinearColorMap() 
            colorMap.setColorInterval( Qt.darkCyan, Qt.yellow )
            self.d_thermo.setColorMap( colorMap )

            self.d_wheel.setValue( 243 )
        elif typ == 5:
            self.d_thermo.setFillBrush( Qt.darkCyan )
            self.d_thermo.setAlarmBrush( Qt.magenta )
            self.d_thermo.setAlarmLevel( 60.0 )
        elif typ == 6:
            self.d_thermo.setOriginMode( Qwt.QwtThermo.OriginMinimum )
            #self.d_thermo.setFillBrush( QBrush( "DarkSlateBlue" ) )
            #self.d_thermo.setAlarmBrush( QBrush( "DarkOrange" ) )
            self.d_thermo.setAlarmLevel( 60.0 )
        elif typ == 7:
            self.d_wheel.setRange( -100, 100 )
            self.d_thermo.setOriginMode( Qwt.QwtThermo.OriginCustom )
            self.d_thermo.setOrigin( 0.0 )
            self.d_thermo.setFillBrush( Qt.darkBlue )

        dmin = self.d_wheel.minimum()
        dmax = self.d_wheel.maximum()

        if ( self.d_wheel.isInverted() ):
            tmp = dmin
            dmin = dmax
            dmax = tmp
            #swap( dmin, dmax )
        self.d_thermo.setScale( dmin, dmax )
        self.d_thermo.setValue( self.d_wheel.value() )
        self.d_wheel.valueChanged['double'].connect( self.d_thermo.setValue )

        box = QWidget()

        layout = None

        if ( orientation == Qt.Horizontal ):
            layout = QHBoxLayout( box )
        else:
            layout = QVBoxLayout( box )
        layout.addWidget( self.d_thermo, Qt.AlignCenter )
        layout.addWidget( self.d_wheel )
        return box

    def setNum(self, v ):
        self.d_label.setText( "%.2f"%v )

class WheelTab( QWidget ):
    def __init__(self,parent=None):
        QWidget.__init__(self, parent)
        numBoxes = 4
        layout1 = QGridLayout()
        for i in range(numBoxes):
            box = WheelBox( Qt.Vertical, i, self )
            layout1.addWidget( box, i // 2, i % 2 )

        layout2 = QGridLayout()
        for i in range( numBoxes ):
            box = WheelBox( Qt.Horizontal, i + numBoxes, self )
            layout2.addWidget( box, i // 2, i % 2 )

        layout = QHBoxLayout( self )
        layout.addLayout( layout1, 2 )
        layout.addLayout( layout2, 5 )

a = QApplication(sys.argv)
tabWidget = QTabWidget()

sliderTab = SliderTab()
#print(type(sliderTab))
#sliderTab.setAutoFillBackground( True )
#sliderTab.setPalette( QColor( "DimGray" ) )
sliderTab1 = SliderTab()
wheelTab = WheelTab()
#wheelTab.setAutoFillBackground( True )
#wheelTab.setPalette( QColor( "Silver" ) )

"""knobTab = KnobTab()
knobTab.setAutoFillBackground( True )
knobTab.setPalette( Qt.darkGray )

dialTab = DialTab()
dialTab.setAutoFillBackground( True )
dialTab.setPalette( Qt.darkGray )"""

tabWidget.addTab( sliderTab, "Slider" )
tabWidget.addTab( wheelTab, "Wheel/Thermo" )
#tabWidget.addTab( knobTab, "Knob" )
#tabWidget.addTab( dialTab, "Dial" )

tabWidget.resize( 800, 600 )
tabWidget.show()
sys.exit(a.exec_())



