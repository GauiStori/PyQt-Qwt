#!/usr/bin/python

import sys
import math
#import Qwt
from PyQt5 import Qwt
import numpy as np

from PyQt5.QtCore import Qt, QSize
from PyQt5.QtGui import QColor #,  QPixmap, QFont,  QIcon
from PyQt5.QtWidgets import QApplication,  QTabWidget, QWidget, QBoxLayout, QVBoxLayout,  QHBoxLayout, QLayout, QLabel #,  QToolBar,  QToolButton, QApplication
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

        self.layout = None #QBoxLayout()
        if self.d_slider.orientation() == Qt.Horizontal:
            self.layout = QHBoxLayout( self )
        else:
            self.layout = QVBoxLayout( self )
        self.layout.addWidget( self.d_slider )
        self.layout.addWidget( self.d_label )

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
            slider.setScaleEngine( Qwt.QwtLogScaleEngine() )
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
    def __init__(self,parent):
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

a = QApplication(sys.argv)
tabWidget = QTabWidget()

sliderTab = SliderTab(tabWidget)
#print(type(sliderTab))
#sliderTab.setAutoFillBackground( True )
#sliderTab.setPalette( QColor( "DimGray" ) )

"""wheelTab = new WheelTab()
wheelTab.setAutoFillBackground( True )
wheelTab.setPalette( QColor( "Silver" ) )

knobTab = KnobTab()
knobTab.setAutoFillBackground( True )
knobTab.setPalette( Qt.darkGray )

dialTab = DialTab()
dialTab.setAutoFillBackground( True )
dialTab.setPalette( Qt.darkGray )"""

tabWidget.addTab( sliderTab, "Slider" )
#tabWidget.addTab( WheelTab, "Wheel/Thermo" )
#tabWidget.addTab( knobTab, "Knob" )
#tabWidget.addTab( dialTab, "Dial" )

tabWidget.resize( 800, 600 )
tabWidget.show()
sys.exit(a.exec_())



