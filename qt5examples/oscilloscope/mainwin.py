#!/usr/bin/python

from PyQt5.QtWidgets import QVBoxLayout, QHBoxLayout,QWidget,QLabel,QSizePolicy,QApplication,QLCDNumber,QLabel
from PyQt5.QtGui import QFont,QWheelEvent,QPalette,QColor
from PyQt5.QtCore import Qt,QSize,QPoint,QEvent,QObject,pyqtSignal,QPointF,pyqtProperty
from PyQt5 import Qwt
from plotqwt import Plot
from numpy import maximum, ceil

class Knob(QWidget):
    valueChanged = pyqtSignal('double', name="valueChanged")
   
    def __init__(self,title,min,max,parent):
        super().__init__(parent)
        QWidget = parent
        font = QFont( "Helvetica", 10 )

        self.__d_knob = Qwt.QwtKnob( self )
        self.__d_knob.setFont( font )

        scaleDiv = self.__d_knob.scaleEngine().divideScale( min, max, 5, 3 )

        ticks = scaleDiv.ticks( Qwt.QwtScaleDiv.MajorTick )
        if ( len(ticks) > 0 and ticks[0] > min ):
            if ( ticks[0] > min ):
                ticks.insert(0, min )
            if ( ticks[-1] < max ):
                ticks.append( max )
    
        scaleDiv.setTicks( Qwt.QwtScaleDiv.MajorTick, ticks )
        self.__d_knob.setScale( scaleDiv )

        self.__d_knob.setKnobWidth( 50 )

        font.setBold( True )
        self.__d_label = QLabel( title, self)
        self.__d_label.setFont( font )
        self.__d_label.setAlignment( Qt.AlignTop | Qt.AlignHCenter )

        self.setSizePolicy( QSizePolicy.MinimumExpanding, QSizePolicy.MinimumExpanding )
        
        
        self.__d_knob.valueChanged.connect(self.valueChanged)
        

    
    
    def sizeHint(self):
        sz1 = self.__d_knob.sizeHint()
        sz2 = self.__d_label.sizeHint()

        w = maximum( sz1.width(), sz2.width() )
        h = sz1.height() + sz2.height()

        off = ceil( self.__d_knob.scaleDraw().extent( self.__d_knob.font() ) )
        off -= 15 # spacing

        return QSize( w, h - off )

    def setValue( self,value ):
        self.__d_knob.setValue( value )


    def value(self):
        return self.__d_knob.value()
    
    
    def theme(self):
        return self.__d_knob.palette().color( QPalette.Window )
    
    
    def setTheme( self, color ):
        self.__d_knob.setPalette( QPalette(color) )

    
    def resizeEvent( self,event ):
        sz = event.size()
        hint = self.__d_label.sizeHint()

        self.__d_label.setGeometry( 0, sz.height() - hint.height(), sz.width(), hint.height() )

        knobHeight = self.__d_knob.sizeHint().height()

        off = ceil( self.__d_knob.scaleDraw().extent( self.__d_knob.font() ) )
        off -= 15 # spacing

        self.__d_knob.setGeometry( 0, self.__d_label.pos().y() - knobHeight + off, sz.width(), knobHeight )
 
    theme = pyqtProperty(QColor, theme, setTheme)

class Wheel(Qwt.QwtWheel):
    def __init__(self,parent):
        super().__init__(parent)
        Qwt.QwtWheel = parent
        self.__d_ignoreWheelEvent = False 
        self.setFocusPolicy( Qt.WheelFocus )
        parent.installEventFilter( self )

    def eventFilter( self, object, event ):
        if ( event.type() == QEvent.Wheel and not self.__d_ignoreWheelEvent ):
        
            we = QWheelEvent(event)
            
            pos = self.wheelRect().center()

            wheelEvent = QWheelEvent( pos , QWidget.mapToGlobal(self,pos), we.pixelDelta(), we.angleDelta(),
                    we.buttons(), we.modifiers(),we.phase(), we.inverted(),we.source())

            self.__d_ignoreWheelEvent = True
            QApplication.sendEvent( self, wheelEvent )
            self.__d_ignoreWheelEvent = False

            return True
        
        return Qwt.QwtWheel.eventFilter( object, event)


class WheelBox(QWidget):
    valueChanged = pyqtSignal('double', name="valueChanged")
    def __init__(self, title, min, max, stepSize, parent):
        super().__init__(parent)
        
        self.__d_number = QLCDNumber( self )
        self.__d_number.setSegmentStyle( QLCDNumber.Filled )
        self.__d_number.setAutoFillBackground( True )
        self.__d_number.setFixedHeight( self.__d_number.sizeHint().height() * 2 )
        self.__d_number.setFocusPolicy( Qt.WheelFocus )

        pal = QPalette( Qt.black )
        pal.setColor( QPalette.WindowText, Qt.green )
        self.__d_number.setPalette( pal )

        self.__d_wheel = Wheel( self )
        self.__d_wheel.setOrientation( Qt.Vertical )
        self.__d_wheel.setInverted( True )
        self.__d_wheel.setRange( min, max )
        self.__d_wheel.setSingleStep( stepSize )
        self.__d_wheel.setPageStepCount( 5 )
        self.__d_wheel.setFixedHeight( self.__d_number.height() )

        self.__d_number.setFocusProxy( self.__d_wheel )

        font = QFont( "Helvetica", 10 )
        font.setBold( True )

        self.__d_label = QLabel( title, self )
        self.__d_label.setFont( font )

        hLayout = QHBoxLayout()
        hLayout.setContentsMargins( 0, 0, 0, 0 )
        hLayout.setSpacing( 2 )
        hLayout.addWidget( self.__d_number, 10 )
        hLayout.addWidget( self.__d_wheel )

        vLayout = QVBoxLayout( self )
        vLayout.addLayout( hLayout, 10 )
        vLayout.addWidget( self.__d_label, 0, Qt.AlignTop | Qt.AlignHCenter )
                       
        self.__d_wheel.valueChanged.connect(self.display)
        
        self.__d_wheel.valueChanged.connect(self.valueChanged)
        
        
  
        


    def display(self,value):
        self.__d_number.display(value)

 
       
    def theme(self):
        return self.__d_wheel.palette().color( QPalette.Window )
    
    
    def setTheme( self, color ):
        self.__d_wheel.setPalette( QPalette(color) )

    
    
    def setValue( self, value ):
        self.__d_wheel.setValue( value )
        self.__d_number.display( value )


    def value(self):
        return self.__d_wheel.value()

    theme = pyqtProperty(QColor, theme, setTheme)


class MainWindow(QWidget):
    amplitudeChanged = pyqtSignal('double', name="amplitudeChanged")
    frequencyChanged = pyqtSignal('double', name="frequencyChanged")
    signalIntervalChanged =  pyqtSignal('double', name="signalIntervalChanged")

    def __init__(self,parent=None):
        super().__init__(parent)
        QWidget = parent
        intervalLength = 10.0
        self.__d_plot = Plot( self )
        self.__d_plot.setIntervalLength( intervalLength )
        self.__d_amplitudeKnob = Knob( "Amplitude", 0.0, 200.0,self)
        self.__d_amplitudeKnob.setValue( 160.0 )

        self.__d_frequencyKnob = Knob( "Frequency [Hz]", 0.1, 20.0,self)
        self.__d_frequencyKnob.setValue( 17.8 )

        self.__d_intervalWheel = WheelBox( "Displayed [s]", 1.0, 100.0, 1.0, self )
        self.__d_intervalWheel.setValue( intervalLength )

        self.__d_timerWheel = WheelBox( "Sample Interval [ms]", 0.0, 20.0, 0.1, self )
        self.__d_timerWheel.setValue( 10.0 )
        

        vLayout1 = QVBoxLayout()

        vLayout1.addWidget( self.__d_intervalWheel )
        vLayout1.addWidget( self.__d_timerWheel )
        vLayout1.addStretch( 10 )
        vLayout1.addWidget( self.__d_amplitudeKnob )
        vLayout1.addWidget( self.__d_frequencyKnob )

        layout = QHBoxLayout(self)
        layout.addWidget( self.__d_plot, 10 )
        layout.addLayout( vLayout1 )


        
               
       
        
        self.__d_amplitudeKnob.valueChanged.connect(self.amplitudeChanged)
               
        self.__d_frequencyKnob.valueChanged.connect(self.frequencyChanged)
        
        self.__d_timerWheel.valueChanged.connect(self.signalIntervalChanged)

        self.__d_intervalWheel.valueChanged.connect(self.setIntervalLength)
        

    def setIntervalLength(self,value):
        self.__d_plot.setIntervalLength(value)

    def start(self):
        self.__d_plot.start()
        

    def frequency(self):
        return self.__d_frequencyKnob.value()


    def amplitude(self):
        return self.__d_amplitudeKnob.value()


    def signalInterval(self):
        return self.__d_timerWheel.value()

        
