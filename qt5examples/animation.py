#!/usr/bin/python

import sys
import math
#import Qwt
from PyQt5 import Qwt
from PyQt5.QtCore import Qt, QTime,  QPointF,  QSize
from PyQt5.QtGui import QColor,  QTransform
from PyQt5.QtWidgets import QApplication, QFrame
from PyQt5.QtGui import QPolygonF

class Curve(Qwt.QwtPlotCurve):
    def __init__(self):
        Qwt.QwtPlotCurve.__init__(self)
        self.d_transform = QTransform()

    def setTransformation(self, transform ):
        self.d_transform = transform;


class Curve1(Curve):
    def __init__(self):
        Curve.__init__(self)
        self.setPen( QColor( 150, 150, 200 ), 2 )
        self.setStyle( Qwt.QwtPlotCurve.Lines )

        curveFitter = Qwt.QwtSplineCurveFitter()
        curveFitter.setSplineSize( 150 )
        self.setCurveFitter( curveFitter )
        self.setCurveAttribute( Qwt.QwtPlotCurve.Fitted, True )

        symbol = Qwt.QwtSymbol( Qwt.QwtSymbol.XCross )
        symbol.setPen( Qt.yellow )
        symbol.setSize( 7 )

        self.setSymbol( symbol )
        # somewhere to the left
        self.transform = QTransform()
        self.transform.scale( 1.5, 1.0 );
        self.transform.translate( 1.5, 3.0 );

        self.setTransformation( self.transform )

    def points(self, phase ):
        points = QPolygonF()
        numSamples = 15;
        for i in range(numSamples):
            v = 6.28 * i / ( numSamples - 1 )
            points += QPointF( math.sin( v - phase ), v )
        return points

    def updateSamples( self, phase ):
        self.setSamples( self.d_transform.map( self.points( phase )))

class Curve2(Curve):
    def __init__(self):
        Curve.__init__(self)
        self.setStyle( Qwt.QwtPlotCurve.Sticks );
        self.setPen( QColor( 200, 150, 50 ) );
        self.setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Ellipse,QColor( Qt.gray ), QColor( Qt.yellow ), QSize( 5, 5 ) ) )

    def points(self, phase ):
        points = QPolygonF()
        numSamples = 50
        for i in range(numSamples):
            v = 10.0 * i / ( numSamples - 1 )
            points += QPointF( v, math.cos( 3.0 * ( v + phase ) ) )
        return points

    def updateSamples( self, phase ):
        a=self.points(phase)
        b= self.d_transform.map(a)
        self.setSamples( b )

class Curve3(Curve):
    def __init__(self):
        Curve.__init__(self)
        self.setStyle( Qwt.QwtPlotCurve.Lines )
        self.setPen( QColor( 100, 200, 150 ), 2 )

        curveFitter = Qwt.QwtSplineCurveFitter()
        curveFitter.setFitMode( Qwt.QwtSplineCurveFitter.ParametricSpline )
        curveFitter.setSplineSize( 200 )
        self.setCurveFitter( curveFitter )

        self.setCurveAttribute( Qwt.QwtPlotCurve.Fitted, True )

        # somewhere in the top right corner
        transform = QTransform()
        transform.translate( 7.0, 7.5 )
        transform.scale( 2.0, 2.0 )

        self.setTransformation( transform )

    def points( self, phase ):
        points = QPolygonF()
        numSamples = 9
        for i in range(numSamples):
            v = i * 2.0 * 3.14159 / ( numSamples - 1 )
            points += QPointF( math.sin( v - phase ), math.cos( 3.0 * ( v + phase ) ) )
        return points;

    def updateSamples( self, phase ):
        self.setSamples( self.d_transform.map( self.points( phase )))

class Curve4(Curve):
    def __init__(self):
        Curve.__init__(self)
        self.d_points = QPolygonF()
        self.setStyle( Qwt.QwtPlotCurve.Lines )
        self.setPen( Qt.red, 2 )
        self.initSamples()
        # somewhere in the center
        transform = QTransform()
        transform.translate( 7.0, 3.0 )
        transform.scale( 1.5, 1.5 )
        self.setTransformation( transform )

    def points(self,  phase ):
        speed = 0.05
        s = speed * math.sin( phase );
        c = math.sqrt( 1.0 - s * s );

        for i in range(len(self.d_points)):
            p = self.d_points[i]
            u = p.x()
            v = p.y()
            self.d_points[i].setX( u * c - v * s )
            self.d_points[i].setY( v * c + u * s )
        return self.d_points;

    def initSamples(self):
        numSamples = 15
        for i in range(numSamples):
            angle = i * ( 2.0 * 3.14159 / ( numSamples - 1 ) );
            p= QPointF( math.cos( angle ), math.sin( angle ) );
            if ( i % 2 ):
                p *= 0.4
            self.d_points += p

    def updateSamples( self, phase ):
        self.setSamples( self.d_transform.map( self.points( phase )))


class Plot( Qwt.QwtPlot):
    def __init__(self,parent=None):
        Qwt.QwtPlot.__init__(self, parent)
        self.d_time = QTime()
        self.d_curves = []
        self.setAutoReplot( False )
        self.setTitle( "Animated Curves" )

        # hide all axes
        for axis in range(Qwt.QwtPlot.axisCnt):
            self.enableAxis( axis, False )

        #self.plotLayout.setCanvasMargin( 10 )

        self.d_curves.append(Curve1())
        self.d_curves.append(Curve2())
        self.d_curves.append(Curve3())
        self.d_curves.append(Curve4())

        self.updateCurves()

        for i in range(len(self.d_curves)):
            self.d_curves[i].attach( self )
        self.d_time.start()
        self.startTimer( 40 )

    def timerEvent( self, event ):
        self.updateCurves()
        self.replot()

    def updateCurves(self):
        speed = 2 * 3.14159 / 25000.0 # a cycle every 25 seconds

        phase = self.d_time.elapsed() * speed
        for i in range(len(self.d_curves)):
            self.d_curves[i].updateSamples( phase )


if __name__ == '__main__':
    a = QApplication(sys.argv)
    plot = Plot()
    #if USE_OPENGL
    #canvas = Qwt.QwtPlotGLCanvas()
    #canvas.setFrameStyle( Qwt.QwtPlotGLCanvas.NoFrame )
    #else
    canvas = Qwt.QwtPlotCanvas();
    canvas.setFrameStyle( QFrame.NoFrame );
    canvas.setPaintAttribute( Qwt.QwtPlotCanvas.BackingStore, False )
    #endif

    plot.setCanvas( canvas )
    plot.setCanvasBackground( QColor( 30, 30, 50 ) )

    plot.resize( 400, 400 )
    plot.show()

    sys.exit(a.exec_())
