#!/usr/bin/python

# python simpleplot.py <qtversion (4 or 5)>
# Tested for python3 Qt5

import sys
sys.path.append("../sip")
import Qwt
import math
#import numpy as np
from PyQt4.QtCore import Qt,  QSize
from PyQt4.QtGui import QBrush, QPen, QApplication

a = QApplication(sys.argv)

plot=Qwt.QwtPlot()
plot.setTitle("Plot Demo")
plot.setCanvasBackground(Qt.white)
plot.insertLegend( Qwt.QwtLegend() )
grid = Qwt.QwtPlotGrid()
grid.attach( plot )

curve = Qwt.QwtPlotCurve()
curve.setTitle("Some Points")
curve.setPen(Qt.blue,4)
curve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased, True );

symbol = Qwt.QwtSymbol( Qwt.QwtSymbol.Ellipse, QBrush( Qt.yellow ), QPen( Qt.red, 2 ), QSize( 8, 8 ) );
curve.setSymbol( symbol )

#x=np.arange(0,10,0.1)
x = range(101)
y = []
for i in range(len(x)):
    x[i]=0.1*x[i]
    y.append(math.sin(x[i]))
#y=np.sin(x)
curve.setSamples(x,y)
curve.attach(plot)

plot.resize(600,400)
plot.replot()
plot.show()
sys.exit(a.exec_())
