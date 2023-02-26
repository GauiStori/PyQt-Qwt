#!/usr/bin/python

# python simpleplot.py <qtversion (4 or 5)>
# Tested for python3 Qt5

import sys
#import Qwt
from PyQt6 import Qwt
import numpy as np
from PyQt6.QtCore import Qt,  QSize
from PyQt6.QtGui import QBrush, QPen
from PyQt6.QtWidgets import QApplication

a = QApplication(sys.argv)

plot=Qwt.QwtPlot()
plot.setTitle("Plot Demo")
plot.setCanvasBackground(Qt.GlobalColor.white)
plot.insertLegend( Qwt.QwtLegend() )
grid = Qwt.QwtPlotGrid()
grid.attach( plot )

curve = Qwt.QwtPlotCurve()
curve.setTitle("Some Points")
curve.setPen(Qt.GlobalColor.blue,4)
curve.setRenderHint( Qwt.QwtPlotItem.RenderHint.RenderAntialiased, True );

symbol = Qwt.QwtSymbol( Qwt.QwtSymbol.Style.Ellipse, QBrush( Qt.GlobalColor.yellow ), QPen( Qt.GlobalColor.red, 2 ), QSize( 8, 8 ) );
curve.setSymbol( symbol )

x=np.arange(0,10,0.1)
y=np.sin(x)
curve.setSamples(x,y)
curve.attach(plot)

#zoomer = Qwt.QwtPlotZoomer( Qwt.QwtPlot.Axis.xBottom, Qwt.QwtPlot.Axis.yLeft, plot.canvas() );
zoomer = Qwt.QwtPlotZoomer( 2,0, plot.canvas() );
zoomer.setZoomBase(False);
zoomer.zoom(0);

plot.resize(600,400)
plot.replot()
plot.show()
sys.exit(a.exec())
