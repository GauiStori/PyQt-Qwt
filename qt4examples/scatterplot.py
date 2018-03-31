

#!/usr/bin/python

# python scatterplot.py <qtversion (4 or 5)>
# Tested for python3 Qt5. Crashes if mose is over plot canvas

import sys
sys.path.append('../sip/')
import math
#import Qwt
from PyQt4 import Qwt
#import numpy as np
from PyQt4.QtCore import Qt,  QSize, qrand, QPointF
from PyQt4.QtGui import QColor,  QPixmap, QFont,  QIcon, QPen, QPolygonF, QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication

def randomValue():
    #a number between [ 0.0, 1.0 ]
    return ( qrand() % 100000 ) / 100000.0

class DistancePicker(Qwt.QwtPlotPicker):
    def __init__(self, canvas):
        Qwt.QwtPlotPicker.__init__(self, canvas)
        self.setTrackerMode( Qwt.QwtPicker.ActiveOnly )
        self.setStateMachine( Qwt.QwtPickerDragLineMachine() )
        self.setRubberBand( Qwt.QwtPlotPicker.PolygonRubberBand )

    def trackerTextF(self, pos ):
        text = QwtText()
        points = self.selection();
        if ( not points.isEmpty() ):
            #QString num
            #num.setNum( QLineF( pos, invTransform( points[0] ) ).length() )
            num = "123"
            bg = QColor( Qt.white )
            bg.setAlpha( 200 )

            text.setBackgroundBrush( QBrush( bg ) )
            text.setText( num )
        return text

class Plot( Qwt.QwtPlot ):
    def __init__(self, parent=None):
        Qwt.QwtPlot.__init__(self, parent)
        self.canvas().setStyleSheet(
            "border: 2px solid Black;"
            "border-radius: 15px;"
            "background-color: qlineargradient( x1: 0, y1: 0, x2: 0, y2: 1,"
                "stop: 0 LemonChiffon, stop: 1 PaleGoldenrod );"
        )

        # attach curve
        self.d_curve = Qwt.QwtPlotCurve( "Scattered Points" )
        self.d_curve.setPen( QColor( "Purple" ) )

        # when using QwtPlotCurve.ImageBuffer simple dots can be
        # rendered in parallel on multicore systems.
        self.d_curve.setRenderThreadCount( 0 ) # 0: use QThread.idealThreadCount()
        self.d_curve.attach( self )
        self.setSymbol( None )
        # panning with the left mouse button
        Qwt.QwtPlotPanner( self.canvas() )
        # zoom in/out with the wheel
        #magnifier = Qwt.QwtPlotMagnifier( self.canvas() ) FIXME
        #magnifier.setMouseButton( Qt.NoButton )
        # distanve measurement with the right mouse button
        self.picker = DistancePicker( self.canvas() )
        self.picker.setMousePattern( Qwt.QwtPlotPicker.MouseSelect1, Qt.RightButton )
        self.picker.setRubberBandPen( QPen( Qt.blue ) )

    def setSymbol( self, symbol ):
        self.d_curve.setSymbol( symbol )
        if ( symbol == None):
            self.d_curve.setStyle( Qwt.QwtPlotCurve.Dots )

    def setSamples(self, samples ):
        self.d_curve.setPaintAttribute( Qwt.QwtPlotCurve.ImageBuffer, samples.size() > 1000 )
        self.d_curve.setSamples( samples )

class MainWindow(QMainWindow):
    def __init__(self, *args):
        QMainWindow.__init__(self, *args) 
        self.d_plot = Plot( self )
        self.d_plot.setTitle( "Scatter Plot" )
        self.setCentralWidget( self.d_plot )

        # a million points
        self.setSamples( 100000 );

    def setSamples(self, numPoints ):
        samples = QPolygonF()
        for i in range(numPoints):
            x = randomValue() * 24.0 + 1.0;
            y = math.log( 10.0 * ( x - 1.0 ) + 1.0 ) * ( randomValue() * 0.5 + 0.9 )
            samples += QPointF( x, y )
        self.d_plot.setSamples( samples )


a = QApplication( sys.argv )
m = MainWindow()
m.resize( 800, 600 )
m.show()

sys.exit(a.exec_())
