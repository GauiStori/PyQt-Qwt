#!/usr/bin/python

import sys
from PyQt6 import Qwt
import time
from PyQt6.QtCore import Qt,  QSize
from PyQt6.QtGui import QColor,  QPixmap, QFont, QBrush, QPalette, QPen
from PyQt6.QtWidgets import (QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication, QComboBox, QSizePolicy)

class Histogram(Qwt.QwtPlotHistogram):
    def __init__(self,title, symbolColor ):
        Qwt.QwtPlotHistogram.__init__(self,title)
        self.setStyle( Qwt.QwtPlotHistogram.HistogramStyle.Columns )
        self.setColor( symbolColor )

    def setValues(self, values ):
        numValues = len(values)
        #QVector<QwtIntervalSample> samples( numValues )
        samples = []
        for i in range(numValues):
            interval = Qwt.QwtInterval( i , i + 1.0 )
            interval.setBorderFlags( Qwt.QwtInterval.BorderFlag.ExcludeMaximum )
            a=Qwt.QwtIntervalSample( values[i], interval )
            samples.append(a)
        self.setSamples( samples )
        

    def setColor(self, color ):
        c = QColor(color)
        c.setAlpha( 180 )
        self.setBrush( QBrush( c ) )



class TVPlot( Qwt.QwtPlot):
    def __init__(self, parent=None):
        Qwt.QwtPlot.__init__(self, parent )
        self.setTitle( "Watching TV during a weekend" )
        canvas = Qwt.QwtPlotCanvas()
        canvas.setPalette( QPalette(Qt.GlobalColor.gray) )
        canvas.setBorderRadius( 10 )
        self.setCanvas( canvas )

        self.plotLayout().setAlignCanvasToScales( True )

        self.setAxisTitle( Qwt.QwtPlot.Axis.yLeft, "Number of People" )
        self.setAxisTitle( Qwt.QwtPlot.Axis.xBottom, "Number of Hours" )

        self.legend = Qwt.QwtLegend()
        self.legend.setDefaultItemMode( Qwt.QwtLegendData.Mode.Checkable )
        self.insertLegend( self.legend, Qwt.QwtPlot.LegendPosition.RightLegend )
        self.populate()

        #connect( legend, SIGNAL( checked( const QVariant &, bool, int ) ), SLOT( showItem( const QVariant &, bool ) ) );
        self.legend.checked['QVariant','bool','int'].connect(self.showItem )

        self.replot() # creating the legend items
        self.items = self.itemList( Qwt.QwtPlotItem.RttiValues.Rtti_PlotHistogram.value )
        for i in range(len(self.items)):
            if ( i == 0 ):
                #const QVariant 
                itemInfo = self.itemToInfo( self.items[i] )
                #QwtLegendLabel *
                legendLabel = self.legend.legendWidget( itemInfo )
                if ( legendLabel ):
                    legendLabel.setChecked( True )
                self.items[i].setVisible( True )
            else:
                self.items[i].setVisible( False )
        self.setAutoReplot( True )

    def populate(self):
        self.grid = Qwt.QwtPlotGrid()
        self.grid.enableX( False )
        self.grid.enableY( True )
        self.grid.enableXMin( False )
        self.grid.enableYMin( False )
        self.grid.setMajorPen( Qt.GlobalColor.black, 0, Qt.PenStyle.DotLine )
        self.grid.attach( self )
        juneValues = [ 7.0, 19.0, 24.0, 32.0, 10.0, 5.0, 3.0 ]
        novemberValues = [ 4.0, 15.0, 22.0, 34.0, 13.0, 8.0, 4.0 ]

        self.histogramJune = Histogram( "Summer", Qt.GlobalColor.red )
        self.histogramJune.setValues( juneValues )
        self.histogramJune.attach( self )

        self.histogramNovember = Histogram( "Winter", Qt.GlobalColor.blue )
        self.histogramNovember.setValues( novemberValues )
        self.histogramNovember.attach( self )

    def exportPlot(self):
        print("Export Plot")
        #renderer = Qwt.QwtPlotRenderer()
        #renderer.exportTo( self, "tvplot.pdf" )

    def setMode( self, mode):
        #QwtPlotItemList
        #print("Set mode %d"%mode)
        items = self.itemList( Qwt.QwtPlotItem.RttiValues.Rtti_PlotHistogram.value )
        for i in range(len(items)):
            histogram = items[i]
            if ( mode < 3 ):
                histogram.setStyle(mode)
                histogram.setSymbol( None)
                pen = QPen( Qt.GlobalColor.black, 0 )
                if ( mode == Qwt.QwtPlotHistogram.HistogramStyle.Lines ):
                    pen.setBrush( histogram.brush() )
                histogram.setPen( pen )
            else:
                histogram.setStyle( Qwt.QwtPlotHistogram.HistogramStyle.Columns )
                symbol = Qwt.QwtColumnSymbol( Qwt.QwtColumnSymbol.Style.Box )
                symbol.setFrameStyle( Qwt.QwtColumnSymbol.FrameStyle.Raised )
                symbol.setLineWidth( 2 )
                symbol.setPalette( QPalette( histogram.brush().color() ) )
                histogram.setSymbol( symbol )

    def showItem( self, plotItem, on ):
        plotItem.setVisible( on )

class MainWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        self.d_plot = TVPlot(self)        
        self.setCentralWidget( self.d_plot )
        self.toolBar = QToolBar( self )
        self.typeBox = QComboBox( self.toolBar )
        self.typeBox.addItem( "Outline" )
        self.typeBox.addItem( "Columns" )
        self.typeBox.addItem( "Lines" )
        self.typeBox.addItem( "Column Symbol" )
        self.typeBox.setCurrentIndex( self.typeBox.count() - 1 )
        self.typeBox.setSizePolicy( QSizePolicy.Policy.Fixed, QSizePolicy.Policy.Fixed )
        self.btnExport = QToolButton( self.toolBar )
        self.btnExport.setText( "Export" )
        self.btnExport.setToolButtonStyle( Qt.ToolButtonStyle.ToolButtonTextUnderIcon )
        #connect( btnExport, SIGNAL( clicked() ), d_plot, SLOT( exportPlot() ) )
        self.btnExport.clicked.connect(self.d_plot.exportPlot)
        self.toolBar.addWidget( self.typeBox )
        self.toolBar.addWidget( self.btnExport )
        self.addToolBar( self.toolBar )
        self.d_plot.setMode( self.typeBox.currentIndex() )
        self.typeBox.currentIndexChanged['int'].connect(self.d_plot.setMode)

a = QApplication(sys.argv)
mainWindow = MainWindow()
mainWindow.resize( 600, 400 )
mainWindow.show()
sys.exit(a.exec())
