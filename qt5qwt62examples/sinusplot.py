#!/usr/bin/python
#-----------------------------------------------------------------
#      A simple example which shows how to use QwtPlot connected
#      to a data class without any storage, calculating each values
#      on the fly.
#-----------------------------------------------------------------
from PyQt5 import Qwt
from PyQt5.QtGui import QColor, QPalette, QLinearGradient, QPen, QPainterPath, QTransform
from PyQt5.QtCore import Qt, QPointF
from PyQt5.QtWidgets import QWidget, QApplication, QHBoxLayout, QFrame
from numpy import sin, cos, pi
import sys

class FunctionData(Qwt.QwtSyntheticPointData):
    def __init__(self,fy):
        super().__init__(1000)
        self.d_y = fy
        
    def y(self,x):
        return self.d_y( x )
    
class ArrowSymbol(Qwt.QwtSymbol):
    def __init__(self):
        super().__init__()
        self.pen = QPen(Qt.black,0)
        self.pen.setJoinStyle( Qt.MiterJoin )
        self.setPen( self.pen )
        self.setBrush( Qt.red )
        
        self.path = QPainterPath()
        self.path.moveTo( 0, 8 )
        self.path.lineTo( 0, 5 )
        self.path.lineTo( -3, 5 )
        self.path.lineTo( 0, 0 )
        self.path.lineTo( 3, 5 )
        self.path.lineTo( 0, 5 )

        self.transform = QTransform() 
        self.transform.rotate( -30.0 )
        self.path = self.transform.map( self.path )

        self.setPath( self.path )
        self.setPinPoint( QPointF( 0, 0 ) )

        self.setSize( 10, 14 )



class Plot(Qwt.QwtPlot):
    def __init__(self):
        super().__init__()
        self.setAutoFillBackground( True )
        self.setPalette( QPalette( QColor( 165, 193, 228 ) ) )
        self.updateGradient()
        self.setTitle( "A Simple QwtPlot Demonstration" )
        self.insertLegend( Qwt.QwtLegend(), Qwt.QwtPlot.RightLegend )

        #axes
        self.setAxisTitle( Qwt.QwtPlot.xBottom, "x -->" )
        self.setAxisScale( Qwt.QwtPlot.xBottom, 0.0, 10.0 )

        self.setAxisTitle( Qwt.QwtPlot.yLeft, "y -->" )
        self.setAxisScale( Qwt.QwtPlot.yLeft, -1.0, 1.0 )
        # canvas
        self.canvas = Qwt.QwtPlotCanvas()
        self.canvas.setLineWidth( 1 )
        self.canvas.setFrameStyle( QFrame.Box | QFrame.Plain )
        self.canvas.setBorderRadius( 15 )

        self.canvasPalette = QPalette( Qt.white )
        self.canvasPalette.setColor( QPalette.Foreground, QColor( 133, 190, 232 ) ) 
        self.canvas.setPalette( self.canvasPalette )

        self.setCanvas( self.canvas )

        #panning with the left mouse button
        self.panner = Qwt.QwtPlotPanner( self.canvas )

        #zoom in/out with the wheel
        self.magnifier = Qwt.QwtPlotMagnifier( self.canvas )
        self.magnifier.setMouseButton( Qt.NoButton )
        
        self.populate()

    def resizeEvent(self,event):
        Qwt.QwtPlot.resizeEvent(self, event )
        self.updateGradient()
        
    def populate(self):
        #Insert new curves
        self.cSin = Qwt.QwtPlotCurve( "y = sin(x)" )
        self.cSin.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.cSin.setLegendAttribute( Qwt.QwtPlotCurve.LegendShowLine, True )
        self.cSin.setPen( Qt.red )
        self.cSin.attach( self )

        self.cCos = Qwt.QwtPlotCurve( "y = cos(x)" )
        self.cCos.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.cCos.setLegendAttribute( Qwt.QwtPlotCurve.LegendShowLine, True )
        self.cCos.setPen( Qt.blue )
        self.cCos.attach( self )


        #Create sin and cos data
        self.s = FunctionData( sin )
        self.cSin.setData( self.s )
        self.c = FunctionData( cos )
        self.cCos.setData( self.c)
        
        
        #Insert markers

        #  ...a horizontal line at y = 0...
        self.mY = Qwt.QwtPlotMarker()
        self.mY.setLabel( Qwt.QwtText("y = 0") )
        self.mY.setLabelAlignment( Qt.AlignRight | Qt.AlignTop )
        self.mY.setLineStyle( Qwt.QwtPlotMarker.HLine )
        self.mY.setYValue( 0.0 )
        self.mY.attach( self )

        #  ...a vertical line at x = 2 * pi
        self.mX = Qwt.QwtPlotMarker()
        self.mX.setLabel( Qwt.QwtText( "x = 2 pi" ) )
        self.mX.setLabelAlignment( Qt.AlignLeft | Qt.AlignBottom )
        self.mX.setLabelOrientation( Qt.Vertical )
        self.mX.setLineStyle( Qwt.QwtPlotMarker.VLine )
        self.mX.setLinePen( Qt.black, 0, Qt.DashDotLine )
        self.mX.setXValue( 2.0 * pi )
        self.mX.attach( self )

        x = 7.7

        # an arrow at a specific position
        self.mPos = Qwt.QwtPlotMarker( "Marker" )
        self.mPos.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased, True )
        self.mPos.setItemAttribute( Qwt.QwtPlotItem.Legend, True )
        self.arr = ArrowSymbol()
        self.mPos.setSymbol( self.arr )
        self.mPos.setValue( QPointF( x, sin( x ) ) )
        self.mPos.setLabel( Qwt.QwtText( "x = %.1f" % x) )
        self.mPos.setLabelAlignment( Qt.AlignRight | Qt.AlignBottom )
        self.mPos.attach( self )


    def updateGradient(self):
        self.pal = QPalette()
        self.buttonColor = self.pal.color( QPalette.Button )
        self.gradient = QLinearGradient( self.rect().topLeft(), self.rect().bottomLeft() )
        self.gradient.setColorAt( 0.0, Qt.gray )
        self.gradient.setColorAt( 0.7, self.buttonColor )
        self.gradient.setColorAt( 1.0, self.buttonColor )
        self.pal.setBrush( QPalette.Window, self.gradient )
        self.setPalette( self.pal )
        



def main():
    app = QApplication.instance()
    if app == None:
        app = QApplication(sys.argv)
        plot = Plot()
        win = QWidget()
        layout = QHBoxLayout(win)
        layout.setContentsMargins( 0, 0, 0, 0 )
        layout.addWidget( plot )
        win.resize( 600, 400 )
        win.show()
        sys.exit(app.exec_())

if __name__ == '__main__':
    main()    












