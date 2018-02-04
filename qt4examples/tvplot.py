#!/usr/bin/python

import sys
#import Qwt
from PyQt4 import Qwt
from PyQt4.QtCore import Qt,  QSize
from PyQt4.QtGui import QColor,  QPixmap, QFont, QBrush, QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication, QPalette, QComboBox, QSizePolicy

class Histogram(Qwt.QwtPlotHistogram):
    def __init__(self,title, symbolColor ):
        Qwt.QwtPlotHistogram.__init__(self,title)
        self.setStyle( Qwt.QwtPlotHistogram.Columns )
        self.setColor( symbolColor )

    def setValues(self, values ):
        numValues = len(values)
        #QVector<QwtIntervalSample> samples( numValues )
        samples = []
        for i in range(numValues):
            interval = Qwt.QwtInterval( i , i + 1.0 )
            interval.setBorderFlags( Qwt.QwtInterval.ExcludeMaximum )
            samples.append(Qwt.QwtIntervalSample( values[i], interval ))
        self.setSamples( samples )
        

    def setColor(self, color ):
        c = QColor(color)
        c.setAlpha( 180 )
        self.setBrush( QBrush( c ) )



class TVPlot( Qwt.QwtPlot):
    def __init__(self, parent=None):
        Qwt.QwtPlot.__init__(self, parent )
        self.grid=None
        self.setTitle( "Watching TV during a weekend" )
        canvas = Qwt.QwtPlotCanvas()
        canvas.setPalette( QPalette(Qt.gray) )
        canvas.setBorderRadius( 10 )
        self.setCanvas( canvas )

        self.plotLayout().setAlignCanvasToScales( True )

        self.setAxisTitle( Qwt.QwtPlot.yLeft, "Number of People" )
        self.setAxisTitle( Qwt.QwtPlot.xBottom, "Number of Hours" )

        self.legend = Qwt.QwtLegend()
        self.legend.setDefaultItemMode( Qwt.QwtLegendData.Checkable )
        self.insertLegend( self.legend, Qwt.QwtPlot.RightLegend )
        self.populate()

        self.legend.checked['QVariant','bool','int'].connect(self.showItem )

        self.replot() # creating the legend items
        """self.items = Qwt.QwtPlotDict.itemList( Qwt.QwtPlotItem.Rtti_PlotHistogram )
        for i in range(len(self.items)):
            if ( i == 0 ):
                #const QVariant 
                itemInfo = itemToInfo( self.items[i] )
                #QwtLegendLabel *
                legendLabel = legend.legendWidget( itemInfo )
                if ( legendLabel ):
                    legendLabel.setChecked( True )
                self.items[i].setVisible( True )
            else:
                self.items[i].setVisible( False )"""
        self.setAutoReplot( True )

    def populate(self):
        self.grid = Qwt.QwtPlotGrid()
        self.grid.enableX( False )
        self.grid.enableY( True )
        self.grid.enableXMin( False )
        self.grid.enableYMin( False )
        self.grid.setMajorPen( Qt.black, 0, Qt.DotLine )
        self.grid.attach( self )
        juneValues = [ 7.0, 19.0, 24.0, 32.0, 10.0, 5.0, 3.0 ]
        novemberValues = [ 4.0, 15.0, 22.0, 34.0, 13.0, 8.0, 4.0 ]

        histogramJune = Histogram( "Summer", Qt.red )
        histogramJune.setValues( juneValues )
        histogramJune.attach( self )

        histogramNovember = Histogram( "Winter", Qt.blue )
        histogramNovember.setValues( novemberValues )
        histogramNovember.attach( self )

    def exportPlot(self):
        print("Export Plot")
        #renderer = Qwt.QwtPlotRenderer()
        #renderer.exportTo( self, "tvplot.pdf" )

    def setMode( self, mode):
        #QwtPlotItemList
        print("Set mode %d"%mode)
        """items = self.itemList( Qwt.QwtPlotItem.Rtti_PlotHistogram )
        for i in range(len(items)):
            histogram = items[i]
            if ( mode < 3 ):
                histogram.setStyle(mode)
                histogram.setSymbol( )
                pen = QPen( Qt.black, 0 )
                if ( mode == Qwt.QwtPlotHistogram.Lines ):
                    pen.setBrush( histogram.brush() )
                histogram.setPen( pen )
            else:
                histogram.setStyle( Qwt.QwtPlotHistogram.Columns )
                symbol = Qwt.QwtColumnSymbol( Qwt.QwtColumnSymbol.Box )
                symbol.setFrameStyle( Qwt.QwtColumnSymbol.Raised )
                symbol.setLineWidth( 2 )
                symbol.setPalette( QPalette( histogram.brush().color() ) )
                histogram.setSymbol( symbol )"""

    def showItem( self, itemInfo, on ):
        print("Doesn't work yet.") 
        plotItem = self.infoToItem( itemInfo )
        if ( plotItem):
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
        self.typeBox.setSizePolicy( QSizePolicy.Fixed, QSizePolicy.Fixed )
        self.btnExport = QToolButton( self.toolBar )
        self.btnExport.setText( "Export" )
        self.btnExport.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
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
sys.exit(a.exec_())
