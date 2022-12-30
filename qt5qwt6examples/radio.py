#!/usr/bin/python3

# python radio.py <qtversion (4 or 5)>
# Tested for python3 Qt5. Crashes if mouse is over plot canvas

import sys
import math
#import Qwt
from PyQt5 import Qwt
import numpy as np

from PyQt5.QtCore import pyqtSignal, Qt,  QSize, QBasicTimer
from PyQt5.QtGui import QColor,  QPixmap, QFont,  QIcon,  QPalette, QLinearGradient
from PyQt5.QtWidgets import (QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication,  QSizePolicy, 
    QVBoxLayout,  QFrame )
#from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

M_PI = 3.14159

class Knob(QWidget):
    def __init__(self, title, min, max, parent ):
        QWidget.__init__(self, parent)
        self.d_knob = Qwt.QwtKnob( self )
        self.d_knob.setScale( min, max )
        self.d_knob.setTotalSteps( 0 ) # disable
        self.d_knob.setScaleMaxMajor( 10 )

        self.d_knob.setKnobStyle( Qwt.QwtKnob.Raised )
        self.d_knob.setKnobWidth( 50 )
        self.d_knob.setBorderWidth( 2 )
        self.d_knob.setMarkerStyle( Qwt.QwtKnob.Notch )
        self.d_knob.setMarkerSize( 8 )

        self.d_knob.scaleDraw().setTickLength( Qwt.QwtScaleDiv.MinorTick, 4 )
        self.d_knob.scaleDraw().setTickLength( Qwt.QwtScaleDiv.MediumTick, 4 )
        self.d_knob.scaleDraw().setTickLength( Qwt.QwtScaleDiv.MajorTick, 6 )

        self.d_label = QLabel( title, self )
        self.d_label.setAlignment( Qt.AlignTop | Qt.AlignHCenter )

        self.setSizePolicy( QSizePolicy.MinimumExpanding, QSizePolicy.MinimumExpanding )

    def sizeHint(self):
        sz1 = self.d_knob.sizeHint()
        sz2 = self.d_label.sizeHint()

        w = max( sz1.width(), sz2.width() )
        h = sz1.height() + sz2.height()

        off = math.ceil( self.d_knob.scaleDraw().extent( self.d_knob.font() ) )
        off -= 10 # spacing

        return QSize( w, h - off )

    def setValue( self, value ):
        self.d_knob.setValue( value )

    def value(self):
        return self.d_knob.value()

    def resizeEvent( self, e ):
        sz = e.size()

        h = self.d_label.sizeHint().height()

        self.d_label.setGeometry( 0, sz.height() - h, sz.width(), h )

        h = self.d_knob.sizeHint().height()
        off = math.ceil( self.d_knob.scaleDraw().extent( self.d_knob.font() ) )
        off -= 10 # spacing

        self.d_knob.setGeometry( 0, self.d_label.pos().y() - h + off, sz.width(), h )

class Thermo(QWidget):
    def __init__( self, title, parent ):
        QWidget.__init__(self, parent)
        self.d_thermo = Qwt.QwtThermo( self )
        self.d_thermo.setPipeWidth( 6 )
        self.d_thermo.setScale( -40, 10 )
        self.d_thermo.setFillBrush( Qt.green )
        self.d_thermo.setAlarmBrush( Qt.red )
        self.d_thermo.setAlarmLevel( 0.0 )
        self.d_thermo.setAlarmEnabled( True )

        label = QLabel( title, self )
        label.setAlignment( Qt.AlignTop | Qt.AlignLeft )

        self.layout = QVBoxLayout( self )
        #self.layout.setMargin( 0 )
        self.layout.setSpacing( 0 )
        self.layout.addWidget( self.d_thermo, 10 )
        self.layout.addWidget( label )

    def setValue( self, value ):
        self.d_thermo.setValue( value )

class AmpFrame( QFrame ):
    def __init__(self, p):
        QFrame.__init__( self, p )
        self.phs = 0
        self.d_knbVolume  = Knob( "Volume", 0.0, 10.0, self )
        self.d_knbBalance = Knob( "Balance", -10.0, 10.0, self )
        self.d_knbTreble  = Knob( "Treble", -10.0, 10.0, self )
        self.d_knbBass    = Knob( "Bass", -10.0, 10.0, self )

        self.d_thmLeft  = Thermo( "Left [dB]", self )
        self.d_thmRight = Thermo( "Right [dB]", self )

        self.layout = QHBoxLayout( self )
        self.layout.setSpacing( 0 )
        #self.layout.setMargin( 10 )
        self.layout.addWidget( self.d_knbVolume )
        self.layout.addWidget( self.d_knbBalance)
        self.layout.addWidget( self.d_knbTreble)
        self.layout.addWidget( self.d_knbBass )
        self.layout.addSpacing( 20 )
        self.layout.addStretch( 10 )
        self.layout.addWidget( self.d_thmLeft )
        self.layout.addSpacing( 10 )
        self.layout.addWidget( self.d_thmRight )

        self.d_knbVolume.setValue( 7.0 )
        self.startTimer( 50 )
        self.d_master = 0

    def timerEvent( self, event ):
        #self.phs = 0.0
        #  This amplifier generates its own input signal...
        sig_bass = ( 1.0 + 0.1 * self.d_knbBass.value() ) * math.sin( 13.0 * self.phs )
        sig_mid_l = math.sin( 17.0 * self.phs )
        sig_mid_r = math.cos( 17.5 * self.phs )
        sig_trbl_l = 0.5 * ( 1.0 + 0.1 * self.d_knbTreble.value() ) * math.sin( 35.0 * self.phs )
        sig_trbl_r = 0.5 * ( 1.0 + 0.1 * self.d_knbTreble.value() ) * math.sin( 34.0 * self.phs )

        sig_l = 0.05 * self.d_master * self.d_knbVolume.value() * ( sig_bass + sig_mid_l + sig_trbl_l )*( sig_bass + sig_mid_l + sig_trbl_l )
        sig_r = 0.05 * self.d_master * self.d_knbVolume.value() * ( sig_bass + sig_mid_r + sig_trbl_r )*( sig_bass + sig_mid_r + sig_trbl_r )

        balance = 0.1 * self.d_knbBalance.value()
        if ( balance > 0 ):
            sig_l *= ( 1.0 - balance )
        else:
            sig_r *= ( 1.0 + balance )

        if ( sig_l > 0.01 ):
            sig_l = 20.0 * math.log10( sig_l )
        else:
            sig_l = -40.0

        if ( sig_r > 0.01 ):
            sig_r = 20.0 * math.log10( sig_r )
        else:
            sig_r = - 40.0

        self.d_thmLeft.setValue( sig_l )
        self.d_thmRight.setValue( sig_r )

        self.phs += M_PI / 100
        if ( self.phs > M_PI ):
            self.phs = 0

    def setMaster( self,  v ):
        self.d_master = v

class TuningThermo(QWidget):
    def __init__(self, parent):
        QWidget.__init__( self,  parent )
        self.d_thermo = Qwt.QwtThermo( self )
        self.d_thermo.setOrientation( Qt.Horizontal )
        self.d_thermo.setScalePosition( Qwt.QwtThermo.NoScale )
        self.d_thermo.setScale( 0.0, 1.0 )
        self.d_thermo.setFillBrush( Qt.green )

        self.label = QLabel( "Tuning", self )
        self.label.setAlignment( Qt.AlignCenter )

        self.layout = QVBoxLayout( self )
        #self.layout.setMargin( 0 ) FIXME
        self.layout.addWidget( self.d_thermo )
        self.layout.addWidget( self.label )

        self.setFixedWidth( 3 * self.label.sizeHint().width() )

    def setValue( self,  value ):
        self.d_thermo.setValue( value )

class TunerFrame( QWidget ):
    fieldChanged = pyqtSignal(float)
    def __init__(self, parent):
        QWidget.__init__(self, parent )
        self.freqMin = 87.5
        self.freqMax = 108

        self.d_sliderFrequency = Qwt.QwtSlider( self )
        self.d_sliderFrequency.setOrientation( Qt.Horizontal )
        self.d_sliderFrequency.setScalePosition( Qwt.QwtSlider.TrailingScale )
        self.d_sliderFrequency.setScale( self.freqMin, self.freqMax )
        #self.d_sliderFrequency.setTotalSteps( math.round( ( self.freqMax - self.freqMin ) / 0.01 ) ) FIXME
        self.d_sliderFrequency.setTotalSteps( int(math.ceil( ( self.freqMax - self.freqMin ) / 0.01 ) ) )
        self.d_sliderFrequency.setSingleSteps( 1 )
        self.d_sliderFrequency.setPageSteps( 10 )
        self.d_sliderFrequency.setScaleMaxMinor( 5 )
        self.d_sliderFrequency.setScaleMaxMajor( 12 )
        self.d_sliderFrequency.setHandleSize( QSize( 80, 20 ) )
        self.d_sliderFrequency.setBorderWidth( 1 )

        self.d_thermoTune = TuningThermo( self )

        self.d_wheelFrequency = Qwt.QwtWheel( self )
        self.d_wheelFrequency.setMass( 0.5 )
        self.d_wheelFrequency.setRange( 87.5, 108 )
        self.d_wheelFrequency.setSingleStep( 0.01 )
        self.d_wheelFrequency.setPageStepCount( 10 )
        self.d_wheelFrequency.setTotalAngle( 3600.0 )
        self.d_wheelFrequency.setFixedHeight( 30 )


        self.d_wheelFrequency.valueChanged['double'].connect(self.adjustFreq )
        self.d_sliderFrequency.valueChanged['double'].connect(self.adjustFreq )

        self.mainLayout = QVBoxLayout( self )
        #self.mainLayout.setMargin( 10 )
        self.mainLayout.setSpacing( 5 )
        self.mainLayout.addWidget( self.d_sliderFrequency )

        self.hLayout = QHBoxLayout()
        #self.hLayout.setMargin( 0 )
        #self.hLayout.addWidget( self.d_thermoTune, 0 )
        self.hLayout.addStretch( 5 )
        self.hLayout.addWidget( self.d_wheelFrequency, 2 )

        self.mainLayout.addLayout( self.hLayout )
    
    def adjustFreq( self, frq ):
        factor = 13.0 / ( 108 - 87.5 )
        x = ( frq - 87.5 ) * factor
        field = ( math.sin( x ) * math.cos( 4.0 * x ) )*( math.sin( x ) * math.cos( 4.0 * x ) )
        self.d_thermoTune.setValue( field )
        if ( self.d_sliderFrequency.value() != frq ):
            self.d_sliderFrequency.setValue( frq )
        if ( self.d_wheelFrequency.value() != frq ):
            self.d_wheelFrequency.setValue( frq )
        self.fieldChanged.emit( field )

    def setFreq( self, frq ):
        self.d_wheelFrequency.setValue( frq )

class MainWindow(QWidget):
    def __init__(self):
        QWidget.__init__(self)
        self.frmTuner = TunerFrame( self )
        #self.frmTuner.setFrameStyle( QFrame.Panel | QFrame.Raised )

        self.frmAmp = AmpFrame( self )
        self.frmAmp.setFrameStyle( QFrame.Panel | QFrame.Raised )

        self.layout = QVBoxLayout( self )
        #self.layout.setMargin( 0 )
        self.layout.setSpacing( 0 )
        self.layout.addWidget( self.frmTuner )
        self.layout.addWidget( self.frmAmp )

        self.frmTuner.fieldChanged['double'].connect(self.frmAmp.setMaster)

        self.frmTuner.setFreq( 90.0 )

        self.setPalette( QPalette( QColor( 192, 192, 192 ) ) )
        self.updateGradient()

    def resizeEvent(self, QResizeEvent  ):
        # Qt 4.7.1: QGradient.StretchToDeviceMode is buggy on X11
        self.updateGradient()

    def updateGradient(self):
        self.pal = QPalette()

        self.buttonColor = self.pal.color( QPalette.Button )
        self.midLightColor = self.pal.color( QPalette.Midlight )

        #self.gradient = QLinearGradient( rect().topLeft(), rect().topRight() ) FIXME
        self.gradient = QLinearGradient(  )
        self.gradient.setColorAt( 0.0, self.midLightColor )
        self.gradient.setColorAt( 0.7, self.buttonColor )
        self.gradient.setColorAt( 1.0, self.buttonColor )

        self.pal.setBrush( QPalette.Window, self.gradient )
        self.setPalette( self.pal )

a = QApplication(sys.argv)
m = MainWindow()
m.show()

sys.exit(a.exec_())
