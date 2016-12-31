#!/usr/bin/python3

import sys
sys.path.append('../sip/')
import math
import Qwt
#import numpy as np

from PyQt5.QtCore import Qt,  QSize,  QObject,  QEvent,  QPointF,  QMutex,  QReadWriteLock,  QRectF
from PyQt5.QtGui import QColor, QFont,   QPalette,  QLinearGradient,  QBrush,  QGradient,  QWheelEvent
#QIcon, QPixmap
from PyQt5.QtWidgets import QWidget, QHBoxLayout,  QLabel,  QApplication,  QLCDNumber,  QVBoxLayout,  QSizePolicy
# QMainWindow,  QToolButton, QToolBar
#from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

M_PI = 3.14157

"""class Canvas(Qwt.QwtPlotCanvas):
    def __init__(self,  plot = None):
        Qwt.QwtPlotCanvas.__init__( self,  plot)
        # The backing store is important, when working with widget
        # overlays ( f.e rubberbands for zooming ).
        # Here we don't have them and the internal
        # backing store of QWidget is good enough.
        self.setPaintAttribute( Qwt.QwtPlotCanvas.BackingStore, False )
        self.setBorderRadius( 10 )

        if ( Qwt.QwtPainter.isX11GraphicsSystem() ):
            #if QT_VERSION < 0x050000
            # Even if not liked by the Qt development, Qt.WA_PaintOutsidePaintEvent
            # works on X11. This has a nice effect on the performance.
            #self.setAttribute( Qt.WA_PaintOutsidePaintEvent, true );
            #endif
            # Disabling the backing store of Qt improves the performance
            # for the direct painter even more, but the canvas becomes
            # a native window of the window system, receiving paint events
            # for resize and expose operations. Those might be expensive
            # when there are many points and the backing store of
            # the canvas is disabled. So in this application
            # we better don't disable both backing stores.

            if ( self.testPaintAttribute( Qwt.QwtPlotCanvas.BackingStore ) ):
                self.setAttribute( Qt.WA_PaintOnScreen, True )
                self.setAttribute( Qt.WA_NoSystemBackground, True )
        self.setupPalette()

    def setupPalette(self):
        pal = QPalette()
        #if QT_VERSION >= 0x040400
        gradient = QLinearGradient()
        gradient.setCoordinateMode( QGradient.StretchToDeviceMode )
        gradient.setColorAt( 0.0, QColor( 0, 49, 110 ) )
        gradient.setColorAt( 1.0, QColor( 0, 87, 174 ) )
        pal.setBrush( QPalette.Window, QBrush( gradient ) )
        #else
        #pal.setBrush( QPalette.Window, QBrush( color ) )
        #endif
        # QPalette.WindowText is used for the curve color
        pal.setColor( QPalette.WindowText, Qt.green )
        self.setPalette( pal )
"""
class SamplingThread( QObject ):
    def __init__(self, parent = None):
        Qwt.QwtSamplingThread(self, parent )
        self.d_frequency = 5.0
        self.d_amplitude = 20.0

    def setFrequency( self, frequency ):
        self.d_frequency = frequency

    def frequency(self):
        return self.d_frequency

    def setAmplitude( self, amplitude ):
        self.d_amplitude = amplitude

    def amplitude(self):
        return self.d_amplitude

    def sample( self, elapsed ):
        if ( self.d_frequency > 0.0 ):
            s = QPointF( elapsed, self.value( elapsed ) )
            self.instance().append( s )

    def value( self, timeStamp ):
        period = 1.0 / self.d_frequency
        x = math.fmod( timeStamp, period )
        v = self.d_amplitude * math.sin( x / period * 2 * M_PI )
        return v

class PrivateData():
        def __init__(self):
            self.boundingRect = QRectF( 1.0, 1.0, -2.0, -2.0 ) # invalid
            self.values.reserve( 1000 )
            
        def append( self,  sample ):
            self.values.append( sample )
            # adjust the bounding rectangle
            if ( self.boundingRect.width() < 0 or self.boundingRect.height() < 0 ):
                self.boundingRect.setRect( sample.x(), sample.y(), 0.0, 0.0 )
            else:
                self.boundingRect.setRight( sample.x() )
                if ( sample.y() > self.boundingRect.bottom() ):
                    self.boundingRect.setBottom( sample.y() )
                if ( sample.y() < self.boundingRect.top() ):
                    self.boundingRect.setTop( sample.y() )
        lock = QReadWriteLock()
        #self.values = QVector<QPointF>
        #self.boundingRect = QRectF()
        mutex = QMutex() # protecting pendingValues
        #pendingValues = QVector<QPointF>


class SignalData( PrivateData):
    def __init__(self):
        self.d_data = PrivateData()


    def values( self ):
        return self.instance()

    def sample( self,  i ):
        return self.instance().value( i )

    def size(self):
        return self.instance().size()

    def boundingRect(self):
        return self.PrivateData.boundingRect()

    def value( self,  index ):
        return self.d_data.values[index]

    def ock( self ):
        self.d_data.lock.lockForRead()

    def unlock( self ):
        self.d_data.lock.unlock()

    def append( self,  sample ):
        self.d_data.mutex.lock()
        self.d_data.pendingValues += sample
        isLocked = self.d_data.lock.tryLockForWrite()
        if ( isLocked ):
            numValues = self.d_data.pendingValues.size()
            pendingValues = self.d_data.pendingValues.data()
            for i in range(numValues):
                self.d_data.append( pendingValues[i] )
            self.d_data.pendingValues.clear()
            self.d_data.lock.unlock()
        self.d_data.mutex.unlock()

    def clearStaleValues( self,  limit ):
        self.d_data.lock.lockForWrite()
        self.d_data.boundingRect = QRectF( 1.0, 1.0, -2.0, -2.0 ) # invalid
        values = self.d_data.values
        self.d_data.values.clear()
        self.d_data.values.reserve( values.size() )

        index = 0
        for index in range(values.size() - 1,  0,  -1 ):
            if ( values[index].x() < limit ):
                break
        if ( index > 0 ):
            self.d_data.append( values[index] )
            index += 1

        while ( index < values.size() - 1 ):
            self.d_data.append( values[index] )
            index += 1
        self.d_data.lock.unlock()

    def instance( self ):
        valueVector = SignalData()
        return valueVector

class Wheel(Qwt.QwtWheel):
    def __init__(self, parent):
        Qwt.QwtWheel.__init__(self, parent)
        self.setFocusPolicy( Qt.WheelFocus )
        parent.installEventFilter( self )

    def eventFilter(self, eobject, event ):
        if ( event.type() == QEvent.Wheel ):
            we = QWheelEvent ( event )
            wheelEvent = QWheelEvent( QPointF( 5, 5 ), we.delta(), we.buttons(), we.modifiers(), we.orientation() )
            QApplication.sendEvent( self, wheelEvent )
            return True
        return Qwt.QwtWheel.eventFilter( self,  eobject, event )
    
    def valueChanged(self, value):
        pass

class WheelBox(QWidget):
    def __init__(self, title, min, max, stepSize, parent ):
        QWidget.__init__( self, parent )
        self.d_number = QLCDNumber( self )
        self.d_number.setSegmentStyle( QLCDNumber.Filled )
        self.d_number.setAutoFillBackground( True )
        self.d_number.setFixedHeight( self.d_number.sizeHint().height() * 2 )
        self.d_number.setFocusPolicy( Qt.WheelFocus )

        pal = QPalette( Qt.black )
        pal.setColor( QPalette.WindowText, Qt.green )
        self.d_number.setPalette( pal )

        self.d_wheel = Wheel( self )
        self.d_wheel.setOrientation( Qt.Vertical )
        self.d_wheel.setInverted(True )
        self.d_wheel.setRange( min, max )
        self.d_wheel.setSingleStep( stepSize )
        self.d_wheel.setPageStepCount( 5 )
        self.d_wheel.setFixedHeight( self.d_number.height() )

        self.d_number.setFocusProxy( self.d_wheel )

        font = QFont( "Helvetica", 10 )
        font.setBold( True )
        self.d_label = QLabel( title, self )
        self.d_label.setFont( font )

        hLayout = QHBoxLayout()
        hLayout.setContentsMargins( 0, 0, 0, 0 )
        hLayout.setSpacing( 2 )
        hLayout.addWidget( self.d_number, 10 )
        hLayout.addWidget( self.d_wheel )

        vLayout = QVBoxLayout( self )
        vLayout.addLayout( hLayout, 10 )
        vLayout.addWidget( self.d_label, 0, Qt.AlignTop | Qt.AlignHCenter )

        #connect( d_wheel, SIGNAL( valueChanged( double ) ), d_number, SLOT( display( double ) ) )
        #connect( d_wheel, SIGNAL( valueChanged( double ) ), self, SIGNAL( valueChanged( double ) ) )
        #self.d_wheel.valueChanged['double'].connect( self.d_number.display ) #FIXME
        # self.d_wheel.valueChanged['double'].connect( self.valueChanged ) FIXME

    def setTheme( self, color ):
        self.d_wheel.setPalette( color )

    def theme( self ):
        return self.d_wheel.palette().color( QPalette.Window )

    def setValue( self, value ):
        self.d_wheel.setValue( value )
        self.d_number.display( value )

    def value(self):
        return self.d_wheel.value()


class Knob(QWidget):
    def __init__( self, title, min, max, parent = None):
        QWidget.__init__( self,  parent )
        font = QFont( "Helvetica", 10 )
        self.d_knob = Qwt.QwtKnob( self )
        self.d_knob.setFont( font )
        scaleDiv = self.d_knob.scaleEngine().divideScale( min, max, 5, 3 )
        ticks = scaleDiv.ticks( Qwt.QwtScaleDiv.MajorTick )
        if ( len(ticks) > 0 and ticks[0] > min ):
            if ( ticks[0] > min ):
                ticks = [min] + ticks
            if ( ticks[len(ticks)-1] < max ):
                ticks.append( max )
        scaleDiv.setTicks( Qwt.QwtScaleDiv.MajorTick, ticks )
        self.d_knob.setScale( scaleDiv )
        self.d_knob.setKnobWidth( 50 )
        font.setBold(True )
        self.d_label = QLabel( title, self )
        self.d_label.setFont( font )
        self.d_label.setAlignment( Qt.AlignTop | Qt.AlignHCenter )
        self.setSizePolicy( QSizePolicy.MinimumExpanding, QSizePolicy.MinimumExpanding )
        #connect( d_knob, SIGNAL( valueChanged( double ) ), self, SIGNAL( valueChanged( double ) ) )
        self.d_knob.valueChanged['double'].connect( self.valueChanged )

    def sizeHint(self):
        sz1 = self.d_knob.sizeHint()
        sz2 = self.d_label.sizeHint()
        w = math.max( sz1.width(), sz2.width() )
        h = sz1.height() + sz2.height()
        off = math.ceil( self.d_knob.scaleDraw().extent( self.d_knob.font() ) )
        off -= 15 # spacing
        return QSize( w, h - off )

    def valueChanged(self, value):
        pass

    def setValue( self,  value ):
        self.d_knob.setValue( value )

    def value( self ): 
        return self.d_knob.value()

    def setTheme( self,  color ):
        self.d_knob.setPalette( color )

    def theme( self ):
        return self.d_knob.palette().color( QPalette.Window )

    def resizeEvent( self,  event ):
        sz = event.size()
        hint = self.d_label.sizeHint()
        self.d_label.setGeometry( 0, sz.height() - hint.height(), sz.width(), hint.height() )
        knobHeight = self.d_knob.sizeHint().height()
        off = math.ceil( self.d_knob.scaleDraw().extent( self.d_knob.font() ) )
        off -= 15 # spacing
        self.d_knob.setGeometry( 0, self.d_label.pos().y() - knobHeight + off, sz.width(), knobHeight )

class Canvas(Qwt.QwtPlotCanvas):
    def __init( self, plot = None):
        Qwt.QwtPlotCanvas.__init__( plot )
        # The backing store is important, when working with widget
        # overlays ( f.e rubberbands for zooming ).
        # Here we don't have them and the internal
        # backing store of QWidget is good enough.

        self.setPaintAttribute( Qwt.QwtPlotCanvas.BackingStore, False)
        self.setBorderRadius( 10 )

        if ( Qwt.QwtPainter.isX11GraphicsSystem() ):
            #if QT_VERSION < 0x050000
            # Even if not liked by the Qt development, Qt.WA_PaintOutsidePaintEvent
            # works on X11. This has a nice effect on the performance.

            #setAttribute( Qt.WA_PaintOutsidePaintEvent,True )
            #endif

            # Disabling the backing store of Qt improves the performance
            # for the direct painter even more, but the canvas becomes
            # a native window of the window system, receiving paint events
            # for resize and expose operations. Those might be expensive
            # when there are many points and the backing store of
            # the canvas is disabled. So in self application
            # we better don't disable both backing stores.

            if ( self.testPaintAttribute( Qwt.QwtPlotCanvas.BackingStore ) ):
                self.setAttribute( Qt.WA_PaintOnScreen,True )
                self.setAttribute( Qt.WA_NoSystemBackground,True )
        self.setupPalette()

    def setupPalette( self ):
        pal = QPalette()
        #if QT_VERSION >= 0x040400
        gradient = QLinearGradient()
        gradient.setCoordinateMode( QGradient.StretchToDeviceMode )
        gradient.setColorAt( 0.0, QColor( 0, 49, 110 ) )
        gradient.setColorAt( 1.0, QColor( 0, 87, 174 ) )
        pal.setBrush( QPalette.Window, QBrush( gradient ) )
        #else
        #pal.setBrush( QPalette.Window, QBrush( color ) )
        #endif
        # QPalette.WindowText is used for the curve color
        pal.setColor( QPalette.WindowText, Qt.green )
        self.setPalette( pal )

class Plot( Qwt.QwtPlot ):
    def __init__(self, parent):
        Qwt.QwtPlot.__init__(self, parent )
        self.d_paintedPoints = 0
        self.d_interval = Qwt.QwtInterval( 0.0, 10.0 )
        self.d_timerId = -1
        self.d_directPainter = Qwt.QwtPlotDirectPainter()
        self.setAutoReplot( False )
        self.setCanvas( Canvas() )
        self.plotLayout().setAlignCanvasToScales(True )

        self.setAxisTitle( Qwt.QwtPlot.xBottom, "Time [s]" )
        self.setAxisScale( Qwt.QwtPlot.xBottom, self.d_interval.minValue(), self.d_interval.maxValue() )
        self.setAxisScale( Qwt.QwtPlot.yLeft, -200.0, 200.0 )

        grid = Qwt.QwtPlotGrid()
        grid.setPen( Qt.gray, 0.0, Qt.DotLine )
        grid.enableX(True )
        grid.enableXMin(True )
        grid.enableY(True )
        grid.enableYMin( False)
        grid.attach( self )

        self.d_origin = Qwt.QwtPlotMarker()
        self.d_origin.setLineStyle( Qwt.QwtPlotMarker.Cross )
        self.d_origin.setValue( self.d_interval.minValue() + self.d_interval.width() / 2.0, 0.0 )
        self.d_origin.setLinePen( Qt.gray, 0.0, Qt.DashLine )
        self.d_origin.attach( self )

        self.d_curve = Qwt.QwtPlotCurve()
        self.d_curve.setStyle( Qwt.QwtPlotCurve.Lines )
        self.d_curve.setPen( self.canvas().palette().color( QPalette.WindowText ) )
        self.d_curve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased,True )
        self.d_curve.setPaintAttribute( Qwt.QwtPlotCurve.ClipPolygons, False)
        #self.d_curve.setData( Qwt.CurveData() ) #FIXME
        self.d_curve.attach( self )

        #Plot.~Plot()
        #{
        #delete d_directPainter
        #}

    def start(self):
        self.d_clock.start()
        self.d_timerId = self.startTimer( 10 )

    def replot(self):
        data = Qwt.CurveData ( self.d_curve.data() )
        data.values().lock()
        Qwt.QwtPlot.replot()
        self.d_paintedPoints = data.size()
        data.values().unlock()

    def setIntervalLength( self, interval ):
        if ( interval > 0.0 and interval  != self.d_interval.width() ):
            self.d_interval.setMaxValue( self.d_interval.minValue() + interval )
            self.setAxisScale( Qwt.QwtPlot.xBottom, self.d_interval.minValue(), self.d_interval.maxValue() )
            self.replot()

    def updateCurve(self):
        data = Qwt.CurveData( self.d_curve.data() )
        data.values().lock()
        numPoints = data.size()
        if ( numPoints > self.d_paintedPoints ):
            doClip =  not self.canvas().testAttribute( Qt.WA_PaintOnScreen )
            if ( doClip ):
                # Depending on the platform setting a clip might be an important
                # performance issue. F.e. for Qt Embedded self reduces the
                # part of the backing store that has to be copied out - maybe
                # to an unaccelerated frame buffer device.
                xMap = Qwt.QwtScaleMap.canvasMap( self.d_curve.xAxis() )
                yMap = Qwt.QwtScaleMap.canvasMap( self.d_curve.yAxis() )
                br = Qwt.qwtBoundingRect( data, self.d_paintedPoints - 1, numPoints - 1 )
                clipRect = Qwt.QwtScaleMap.transform( xMap, yMap, br ).toRect()
                self.d_directPainter.setClipRegion( clipRect )

            self.d_directPainter.drawSeries( self.d_curve, self.d_paintedPoints - 1, numPoints - 1 )
            self.d_paintedPoints = numPoints

        data.values().unlock()

    def incrementInterval(self):
        self.d_interval = Qwt.QwtInterval( self.d_interval.maxValue(), self.d_interval.maxValue() + self.d_interval.width() )
        self.data = Qwt.CurveData( self.d_curve.data() )
        self.data.values().clearStaleValues( self.d_interval.minValue() )
        # To avoid, that the grid is jumping, we disable
        # the autocalculation of the ticks and shift them
        # manually instead.
        self.scaleDiv = self.axisScaleDiv( Qwt.QwtPlot.xBottom )
        self.scaleDiv.setInterval( self.d_interval )
        for i in range(Qwt.QwtScaleDiv.NTickTypes ):
            ticks = self.scaleDiv.ticks( i )
            for j in range(ticks.size()):
                ticks[j] += self.d_interval.width()
            self.scaleDiv.setTicks( i, ticks )
        self.setAxisScaleDiv( Qwt.QwtPlot.xBottom, self.scaleDiv )
        self.d_origin.setValue( self.d_interval.minValue() + self.d_interval.width() / 2.0, 0.0 )
        self.d_paintedPoints = 0
        self.replot()

    def timerEvent( self, event ):
        if ( event.timerId() == self.d_timerId ):
            self.updateCurve()
            elapsed = self.d_clock.elapsed() / 1000.0
            if ( elapsed > self.d_interval.maxValue() ):
                self.incrementInterval()
            return
        Qwt.QwtPlot.timerEvent( event )

    def resizeEvent( self, event ):
        self.d_directPainter.reset()
        Qwt.QwtPlot.resizeEvent( event )

    def showEvent( self ):
        self.replot()

    def eventFilter( self,  object, event ):
        if ( object == self.canvas() and event.type() == QEvent.PaletteChange ):
            self.d_curve.setPen( self.canvas().palette().color( QPalette.WindowText ) )
        return Qwt.QwtPlot.eventFilter( self,  object, event )

class MainWindow( QWidget ):
    def __init__(self, parent=None):
        QWidget.__init__(self, parent)
        self.intervalLength = 10.0 # seconds
        self.d_plot = Plot( self )
        self.d_plot.setIntervalLength( self.intervalLength )
        self.d_amplitudeKnob = Knob( "Amplitude", 0.0, 200.0, self )
        self.d_amplitudeKnob.setValue( 160.0 )
        self.d_frequencyKnob = Knob( "Frequency [Hz]", 0.1, 20.0, self )
        self.d_frequencyKnob.setValue( 17.8 )
        self.d_intervalWheel = WheelBox( "Displayed [s]", 1.0, 100.0, 1.0, self )
        self.d_intervalWheel.setValue( self.intervalLength )
        self.d_timerWheel = WheelBox( "Sample Interval [ms]", 0.0, 20.0, 0.1, self )
        self.d_timerWheel.setValue( 10.0 )
        self.vLayout1 = QVBoxLayout()
        self.vLayout1.addWidget( self.d_intervalWheel )
        self.vLayout1.addWidget( self.d_timerWheel )
        self.vLayout1.addStretch( 10 )
        self.vLayout1.addWidget( self.d_amplitudeKnob )
        self.vLayout1.addWidget( self.d_frequencyKnob )
        self.layout = QHBoxLayout( self )
        self.layout.addWidget( self.d_plot, 10 )
        self.layout.addLayout( self.vLayout1 )

        #connect( d_amplitudeKnob, SIGNAL( valueChanged( double ) ), SIGNAL( amplitudeChanged( double ) ) )
        #FIXME self.d_amplitudeKnob.valueChanged['double'].connect( window.amplitudeChanged )
        #connect( d_frequencyKnob, SIGNAL( valueChanged( double ) ), SIGNAL( frequencyChanged( double ) ) )
        #FIXME self.d_frequencyKnob.valueChanged['double'].connect( window.frequencyChanged )
        #connect( d_timerWheel, SIGNAL( valueChanged( double ) ), SIGNAL( signalIntervalChanged( double ) ) )
        #FIXME self.d_timerWheel.valueChanged['double'].connect( window.signalIntervalChanged )
        #connect( d_intervalWheel, SIGNAL( valueChanged( double ) ), d_plot, SLOT( setIntervalLength( double ) ) )
        #FIXME self.d_intervalWheel.valueChanged['double'].connect( self.d_plot.setIntervalLength )

    def start(self):
        self.d_plot.start()

    def frequency( self ):
        return self.d_frequencyKnob.value()

    def amplitude( self ):
        return self.d_amplitudeKnob.value()

    def signalInterval( self ):
        return self.d_timerWheel.value()

### Main ##############################3
app = QApplication( sys.argv )
###app.setPalette(Qt.darkGray )

window = MainWindow()
window.resize( 800, 400 )

samplingThread = SamplingThread()
samplingThread.setFrequency( window.frequency() )
samplingThread.setAmplitude( window.amplitude() )
samplingThread.setInterval( window.signalInterval() )

window.frequencyChanged['double'].connect( samplingThread.setFrequency )
window.amplitudeChanged['double'].connect( samplingThread.setAmplitude )
window.signalIntervalChanged['double'].connect( samplingThread.setInterval )
window.show()
samplingThread.start()
window.start()
ok = app.exec()
samplingThread.stop()
samplingThread.wait( 1000 )
