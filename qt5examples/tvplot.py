#!/usr/bin/python

# python simpleplot.py <qtversion (4 or 5)>
# Doesn't work

import sys
sys.path.append('../sip/')
import Qwt
from PyQt5.QtCore import Qt,  QSize
from PyQt5.QtGui import QColor,  QPixmap, QFont, QBrush
from PyQt5.QtWidgets import QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication

class Histogram(Qwt.QwtPlotHistogram):
    def __init__(self,title, symbolColor ):
        Qwt.QwtPlotHistogram.__init__(self,title)
        self.setStyle( Qwt.QwtPlotHistogram.Columns )
        #self.setColor( symbolColor )

    def setValues(self, values ):
        pass
        #self.setData( values )
        """QVector<QwtIntervalSample> samples( numValues )
        for i in range(numValues):
            QwtInterval interval( double( i ), i + 1.0 )
            interval.setBorderFlags( Qwt.QwtInterval.ExcludeMaximum )
            samples[i] = QwtIntervalSample( values[i], interval )"""

    def setColor(self, color ):
        c = color;
        c.setAlpha( 180 )
        self.setBrush( QBrush( c ) )



class TVPlot( Qwt.QwtPlot):
    def __init__(self, parent=None):
        Qwt.QwtPlot.__init__(self, parent )
        self.grid=None
        #setTitle( "Watching TV during a weekend" )
        canvas = Qwt.QwtPlotCanvas()
        #canvas.setPalette( Qt.gray )
        canvas.setBorderRadius( 10 )
        self.setCanvas( canvas )

        #self.plotLayout().setAlignCanvasToScales( True )

        #setAxisTitle( Qwt.QwtPlot.yLeft, "Number of People" )
        #setAxisTitle( Qwt.QwtPlot.xBottom, "Number of Hours" )

        legend = Qwt.QwtLegend()
        legend.setDefaultItemMode( Qwt.QwtLegendData.Checkable )
        self.insertLegend( legend, Qwt.QwtPlot.RightLegend )
        self.populate()

        #connect( legend, SIGNAL( checked( const QVariant &, bool, int ) ), SLOT( showItem( const QVariant &, bool ) ) )

        self.replot() # creating the legend items

        items = Qwt.QwtPlotItemList.itemList( Qwt.QwtPlotItem.Rtti_PlotHistogram )
        for i in range(len(items)):
            if ( i == 0 ):
                #const QVariant 
                itemInfo = itemToInfo( items[i] )
                #QwtLegendLabel *
                legendLabel = legend.legendWidget( itemInfo )
                if ( legendLabel ):
                    legendLabel.setChecked( True )
                items[i].setVisible( True )
            else:
                items[i].setVisible( False )
        setAutoReplot( True )

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
        renderer = QwtPlotRenderer()
        renderer.exportTo( self, "tvplot.pdf" )

    def setMode( self, mode):
        #QwtPlotItemList
        items = QwtPlotItemList.itemList( Qwt.QwtPlotItem.Rtti_PlotHistogram )
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
                histogram.setSymbol( symbol )

    def showItem( itemInfo,on ):
        #QwtPlotItem 
        plotItem = infoToItem( itemInfo )
        if ( plotItem ):
            plotItem.setVisible( on )

class MainWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        self.d_plot = TVPlot(self)        
        setCentralWidget( self.d_plot )
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
        #btnExport.setToolButtonStyle( QtCore.ToolButtonTextUnderIcon )
        #connect( btnExport, SIGNAL( clicked() ), d_plot, SLOT( exportPlot() ) )
        self.toolBar.addWidget( self.typeBox )
        self.toolBar.addWidget( self.btnExport )
        self.addToolBar( self.toolBar )
        #d_plot->setMode( typeBox->currentIndex() )
        #connect( typeBox, SIGNAL( curr entIndexChanged( int ) ), d_plot, SLOT( setMode( int ) ) )

a = QApplication(sys.argv)
mainWindow = MainWindow()
mainWindow.resize( 600, 400 )
mainWindow.show()
sys.exit(a.exec_())
