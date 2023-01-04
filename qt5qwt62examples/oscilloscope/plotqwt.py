#!/usr/bin/python

from PyQt5 import Qwt
from PyQt5.QtCore import Qt,QT_VERSION_STR,QEvent
from PyQt5.QtGui import QLinearGradient, QGradient,QColor,QBrush,QPalette,QRegion
from sampledata import SignalData

class Canvas(Qwt.QwtPlotCanvas):
    def __init__(self, plot=None):
        super().__init__(plot)
        QwtPlotCanvas = plot
        self.setPaintAttribute( Qwt.QwtPlotCanvas.BackingStore, False )
        self.setBorderRadius( 10 )
        if ( Qwt.QwtPainter.isX11GraphicsSystem() ):
            #self.setAttribute( Qt.WA_PaintOutsidePaintEvent, True )
            if ( self.testPaintAttribute( Qwt.QwtPlotCanvas.BackingStore ) ):
                self.setAttribute( Qt.WA_PaintOnScreen, True )
                self.setAttribute( Qt.WA_NoSystemBackground, True )
            

        self.__setupPalette()


    def __setupPalette(self):
        pal = self.palette()
        gradient = QLinearGradient()
        gradient.setCoordinateMode( QGradient.StretchToDeviceMode )
        gradient.setColorAt( 0.0, QColor( 0, 49, 110 ) )
        gradient.setColorAt( 1.0, QColor( 0, 87, 174 ) )

        pal.setBrush( QPalette.Window, QBrush( gradient ) )
        #QPalette::WindowText is used for the curve color
        pal.setColor( QPalette.WindowText, Qt.green )

        self.setPalette( pal )

class CurveData(Qwt.QwtSeriesDataQPointF):
    def __init__(self):
        super().__init__()
        
    def values(self):
        return SignalData.instance()

    def sample( self, i ):
        return SignalData.instance().value( i )
    
    def size(self): 
        return SignalData.instance().size()

    def boundingRect(self):
        return SignalData.instance().boundingRect()




class Plot(Qwt.QwtPlot):
    def __init__(self,parent):
        super().__init__(parent)
        self.__d_interval = Qwt.QwtInterval( 0.0, 10.0 )
        self.__d_timerId = -1
        self.__d_directPainter = Qwt.QwtPlotDirectPainter()
        self.__d_clock = Qwt.QwtSystemClock()
        self.__d_paintedPoints = 0 
        
        self.setAutoReplot( False )
        self.setCanvas( Canvas() )
        self.plotLayout().setAlignCanvasToScales( True )

        self.setAxisTitle( Qwt.QwtPlot.xBottom, "Time [s]" )
        self.setAxisScale( Qwt.QwtPlot.xBottom, self.__d_interval.minValue(), self.__d_interval.maxValue() )
        self.setAxisScale( Qwt.QwtPlot.yLeft, -200.0, 200.0 )
        self.grid = Qwt.QwtPlotGrid()
        self.grid.setPen( Qt.gray, 0.0, Qt.DotLine )
        self.grid.enableX( True )
        self.grid.enableXMin( True )
        self.grid.enableY( True )
        self.grid.enableYMin( False )
        self.grid.attach( self )

        self.__d_origin = Qwt.QwtPlotMarker()
        self.__d_origin.setLineStyle( Qwt.QwtPlotMarker.Cross )
        self.__d_origin.setValue( self.__d_interval.minValue() + self.__d_interval.width() / 2.0, 0.0 )
        self.__d_origin.setLinePen( Qt.gray, 0.0, Qt.DashLine )
        self.__d_origin.attach( self )

        self.__d_curve = Qwt.QwtPlotCurve()
        self.__d_curve.setStyle( Qwt.QwtPlotCurve.Lines )
        self.__d_curve.setPen( self.canvas().palette().color( QPalette.WindowText ) )
        self.__d_curve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased, True )
        self.__d_curve.setPaintAttribute( Qwt.QwtPlotCurve.ClipPolygons, False )
        self.__cdata = CurveData()
        self.__d_curve.setData( self.__cdata )
        self.__d_curve.attach( self )

                        

    def start(self):
        self.__d_clock.start()
        self.__d_timerId = self.startTimer( 10 )

    def replot(self):
        curveData = self.__d_curve.data()
        curveData.values().lock()

        Qwt.QwtPlot.replot(self)
        self.__d_paintedPoints = curveData.size()

        curveData.values().unlock()
    
    def setIntervalLength( self, interval ):
        if ( interval > 0.0 and interval != self.__d_interval.width() ):
            self.__d_interval.setMaxValue( self.__d_interval.minValue() + interval )
            self.setAxisScale( Qwt.QwtPlot.xBottom,
                self.__d_interval.minValue(), self.__d_interval.maxValue() )

            self.replot()
    
    def __updateCurve(self):
        curveData = self.__d_curve.data() 
        curveData.values().lock()

        numPoints = curveData.size()
        if ( numPoints > self.__d_paintedPoints ):
            doClip = not self.canvas().testAttribute( Qt.WA_PaintOnScreen )
            if ( doClip ):
        
            
            #    Depending on the platform setting a clip might be an important
            #    performance issue. F.e. for Qt Embedded this reduces the
            #    part of the backing store that has to be copied out - maybe
            #    to an unaccelerated frame buffer device.
            

                xMap = self.canvasMap( self.__d_curve.xAxis() )
                yMap = self.canvasMap( self.__d_curve.yAxis() )

                br = Qwt.qwtBoundingRect( curveData,
                    self.__d_paintedPoints - 1, numPoints - 1 )

                clipRect = Qwt.QwtScaleMap.transform( xMap, yMap, br ).toRect()
                self.__d_directPainter.setClipRegion( QRegion(clipRect) )
        

            self.__d_directPainter.drawSeries( self.__d_curve,
                self.__d_paintedPoints - 1, numPoints - 1 )
            self.__d_paintedPoints = numPoints
    

        curveData.values().unlock()


    def __incrementInterval(self):
        self.__d_interval = Qwt.QwtInterval( self.__d_interval.maxValue(),
            self.__d_interval.maxValue() + self.__d_interval.width() )

        curveData = self.__d_curve.data() 
        curveData.values().clearStaleValues( self.__d_interval.minValue() )

        #To avoid, that the grid is jumping, we disable
        #the autocalculation of the ticks and shift them
        #manually instead.

        scaleDiv = self.axisScaleDiv( Qwt.QwtPlot.xBottom )
        scaleDiv.setInterval( self.__d_interval )

        for i in range( 0, Qwt.QwtScaleDiv.NTickTypes):
    
            ticks = scaleDiv.ticks( i )
            for j in range(0 , len(ticks)):
                ticks[j] += self.__d_interval.width()
            scaleDiv.setTicks( i, ticks )
    
        self.setAxisScaleDiv( Qwt.QwtPlot.xBottom, scaleDiv )

        self.__d_origin.setValue( self.__d_interval.minValue() + self.__d_interval.width() / 2.0, 0.0 )

        self.__d_paintedPoints = 0
        self.replot()

    def timerEvent( self, event ):

        if ( event.timerId() == self.__d_timerId ):
    
            self.__updateCurve()

            elapsed = self.__d_clock.elapsed() / 1000.0
            if ( elapsed > self.__d_interval.maxValue() ):
                self.__incrementInterval()

            return
    
        Qwt.QwtPlot.timerEvent( self,event )


    def resizeEvent( self, event ):
        self.__d_directPainter.reset()
        Qwt.QwtPlot.resizeEvent( self,event )


    def showEvent( self, event ):
        self.replot()


    def eventFilter( self, object, event ):

        if ( object == self.canvas() and event.type() == QEvent.PaletteChange ):   
            self.__d_curve.setPen( self.canvas().palette().color( QPalette.WindowText ) )
    
        return Qwt.QwtPlot.eventFilter( self, object, event )


    def __del__(self):
        del self.__d_directPainter
