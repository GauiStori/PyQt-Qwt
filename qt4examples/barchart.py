#!/usr/bin/python

import sys
#import Qwt
from PyQt4 import Qwt
sys.path.append('../sip/')
import math, random
from PyQt4.QtCore import Qt, QTime,  QPointF,  QSize
from PyQt4.QtGui import QColor,  QTransform,  QPalette, QApplication, QMainWindow, QFrame, QWidget,  QToolBar,  QComboBox,  QSizePolicy,  QToolButton

class BarChart( Qwt.QwtPlot ):
    def __init__(self, parent):
        Qwt.QwtPlot.__init__(self, parent)
        self.setAutoFillBackground( True )
        self.setPalette( QPalette(Qt.white) )
        #self.canvas.setPalette( QColor( "LemonChiffon" ) ) #FIXME
        #self.canvas.setPalette( QColor( "LemonChiffon" ) ) #FIXME

        self.setTitle( "Bar Chart" )

        self.setAxisTitle( Qwt.QwtPlot.yLeft, "Whatever" )
        self.setAxisTitle( Qwt.QwtPlot.xBottom, "Whatever" )

        self.d_barChartItem = Qwt.QwtPlotMultiBarChart( "Bar Chart " )
        self.d_barChartItem.setLayoutPolicy( Qwt.QwtPlotMultiBarChart.AutoAdjustSamples )
        self.d_barChartItem.setSpacing( 20 )
        self.d_barChartItem.setMargin( 3 )

        self.d_barChartItem.attach( self )

        self.insertLegend( Qwt.QwtLegend() )

        self.populate()
        self.setOrientation( 0 )

        self.setAutoReplot( True )

    def populate(self):
        #colors = ["DarkOrchid", "SteelBlue", "Gold"]
        colors = [Qt.magenta, Qt.blue, Qt.yellow]

        numSamples = 5
        numBars = len(colors )

        titles = []
        for i in range(numBars):
            titles.append(Qwt.QwtText("Bar %d"%i))

        self.d_barChartItem.setBarTitles( titles )
        self.d_barChartItem.setLegendIconSize( QSize( 10, 14 ) )

        for i in range(numBars):
            symbol = Qwt.QwtColumnSymbol( Qwt.QwtColumnSymbol.Box )
            symbol.setLineWidth( 2 )
            symbol.setFrameStyle( Qwt.QwtColumnSymbol.Raised )
            symbol.setPalette( QPalette( colors[i] ) ) 
            #self.d_barChartItem.setSymbol( i, symbol ) #FIXME Segfaults
        
        self.series = []
        for i in range(numSamples):
            values = []
            for j in range(numBars):
                values.append( 2.0 + random.randint(0, 8) % 8 )
            self.series.append(values)
        print(self.series)
        self.d_barChartItem.setSamples( self.series )

    def setMode( self, mode ):
        if ( mode == 0 ):
            self.d_barChartItem.setStyle( Qwt.QwtPlotMultiBarChart.Grouped )
        else:
            self.d_barChartItem.setStyle( Qwt.QwtPlotMultiBarChart.Stacked )

    def setOrientation( self, orientation ):
        axis1 = Qwt.QwtPlot.Axis()
        axis2 = Qwt.QwtPlot.Axis()
        if ( orientation == 0 ):
            axis1 = Qwt.QwtPlot.xBottom
            axis2 = Qwt.QwtPlot.yLeft
            self.d_barChartItem.setOrientation( Qt.Vertical )
        else:
            axis1 = Qwt.QwtPlot.yLeft
            axis2 = Qwt.QwtPlot.xBottom
            self.d_barChartItem.setOrientation( Qt.Horizontal )

        self.setAxisScale( axis1, 0, len(self.series) -1, 1.0 )
        #self.setAxisScale( axis1, 0, self.d_barChartItem.dataSize() - 1, 1.0 )
        self.setAxisAutoScale( axis2 )

        self.scaleDraw1 = self.axisScaleDraw( axis1 )
        self.scaleDraw1.enableComponent( Qwt.QwtScaleDraw.Backbone, False )
        self.scaleDraw1.enableComponent( Qwt.QwtScaleDraw.Ticks, False )

        self.scaleDraw2 = self.axisScaleDraw( axis2 )
        self.scaleDraw2.enableComponent( Qwt.QwtScaleDraw.Backbone, True )
        self.scaleDraw2.enableComponent( Qwt.QwtScaleDraw.Ticks, True )

        self.plotLayout().setAlignCanvasToScale( axis1, True )
        self.plotLayout().setAlignCanvasToScale( axis2, False )

        self.plotLayout().setCanvasMargin( 0 )
        self.updateCanvasMargins()
        self.replot()

    def exportChart(self):
        renderer = Qwt.QwtPlotRenderer()
        renderer.exportTo( self, "barchart.pdf" )

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        QMainWindow.__init__(self, parent)
        self.d_chart = BarChart( self )
        self.setCentralWidget( self.d_chart )

        self.toolBar = QToolBar( self )

        self.typeBox = QComboBox( self.toolBar )
        self.typeBox.addItem( "Grouped" )
        self.typeBox.addItem( "Stacked" )
        self.typeBox.setSizePolicy( QSizePolicy.Fixed, QSizePolicy.Fixed )

        self.orientationBox = QComboBox( self.toolBar )
        self.orientationBox.addItem( "Vertical" )
        self.orientationBox.addItem( "Horizontal" )
        self.orientationBox.setSizePolicy( QSizePolicy.Fixed, QSizePolicy.Fixed )

        self.btnExport = QToolButton(self.toolBar )
        self.btnExport.setText( "Export" )
        self.btnExport.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        self.btnExport.clicked.connect(self.d_chart.exportChart)

        self.toolBar.addWidget( self.typeBox )
        self.toolBar.addWidget( self.orientationBox )
        self.toolBar.addWidget( self.btnExport )
        self.addToolBar( self.toolBar )

        self.d_chart.setMode( self.typeBox.currentIndex() )
        self.typeBox.currentIndexChanged['int'].connect(self.d_chart.setMode )
        self.d_chart.setOrientation( self.orientationBox.currentIndex() )
        self.orientationBox.currentIndexChanged['int'].connect(self.d_chart.setOrientation)

a = QApplication(sys.argv)
m = MainWindow()
m.resize( 600, 400 )
m.show()
sys.exit(a.exec_())

