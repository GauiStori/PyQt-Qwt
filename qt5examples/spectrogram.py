#!/usr/bin/python

import sys
#import Qwt
from PyQt5 import Qwt
from PyQt5.QtCore import Qt,  qIsNaN,  qRound
from PyQt5.QtGui import QColor, QPen, QBrush,  QFontMetrics
from PyQt5.QtWidgets import QApplication,  QCheckBox,  QToolBar,  QToolButton,  QLabel,  QComboBox,  QSlider,  QSizePolicy, QMainWindow
from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

class MyZoomer(Qwt.QwtPlotZoomer):
    def __init__(self, canvas):
        Qwt.QwtPlotZoomer.__init__(self, canvas )
        self.setTrackerMode( Qwt.QwtPicker.AlwaysOn )

    def trackerTextF( self, pos ):
        bg = QColor( Qt.white )
        bg.setAlpha( 200 )
        text = Qwt.QwtPlotZoomer.trackerTextF( pos )
        text.setBackgroundBrush( QBrush( bg ) )
        return text

class SpectrogramData(Qwt.QwtRasterData):
    def __init__(self):
        Qwt.QwtRasterData.__init__(self)
        self.setInterval( Qt.XAxis, Qwt.QwtInterval( -1.5, 1.5 ) )
        self.setInterval( Qt.YAxis, Qwt.QwtInterval( -1.5, 1.5 ) )
        self.setInterval( Qt.ZAxis, Qwt.QwtInterval( 0.0, 10.0 ) )

    def value( self, x, y ):
        c = 0.842
        #c = 0.33
        v1 = x * x + ( y - c ) * ( y + c )
        v2 = x * ( y + c ) + x * ( y + c )
        return 1.0 / ( v1 * v1 + v2 * v2 )

class LinearColorMapRGB(Qwt.QwtLinearColorMap):
    def __init__(self):
        Qwt.QwtLinearColorMap.__init__(self, Qt.darkCyan, Qt.red, Qwt.QwtColorMap.RGB )
        self.addColorStop( 0.1, Qt.cyan )
        self.addColorStop( 0.6, Qt.green )
        self.addColorStop( 0.95, Qt.yellow )

class LinearColorMapIndexed(Qwt.QwtLinearColorMap):
    def __init__(self):
        Qwt.QwtLinearColorMap.__init__( self, Qt.darkCyan, Qt.red, Qwt.QwtColorMap.Indexed )
        self.addColorStop( 0.1, Qt.cyan )
        self.addColorStop( 0.6, Qt.green )
        self.addColorStop( 0.95, Qt.yellow )

class HueColorMap(Qwt.QwtColorMap):
    def __init__(self):
        Qwt.QwtColorMap.__init__(self)
        self.d_hue1 = 0
        self.d_hue2 = 359
        self.d_saturation = 150
        self.d_value = 200 
        self.d_rgbTable = []
        self.updateTable()

    def rgb(self, interval, value ):
        if ( qIsNaN(value) ):
            return 0

        width = interval.width()
        if ( width <= 0 ):
            return 0

        if ( value <= interval.minValue() ):
            return self.d_rgbMin

        if ( value >= interval.maxValue() ):
            return self.d_rgbMax

        ratio = ( value - interval.minValue() ) / width
        hue = self.d_hue1 + qRound( ratio * ( self.d_hue2 - self.d_hue1 ) )

        if ( hue >= 360 ):
            hue -= 360
            if ( hue >= 360 ):
                hue = hue % 360
        return self.d_rgbTable[hue]

    def colorIndex(self, a0, a1 ):
        # we don't support indexed colors
        return 0


    def updateTable(self):
        for i in range(360):
            self.d_rgbTable.append(QColor.fromHsv( i, self.d_saturation, self.d_value ).rgb())
        self.d_rgbMin = self.d_rgbTable[ self.d_hue1 % 360 ]
        self.d_rgbMax = self.d_rgbTable[ self.d_hue2 % 360 ]

class AlphaColorMap(Qwt.QwtAlphaColorMap):
    def __init__(self):
        Qwt.QwtAlphaColorMap.__init__(self)
        #setColor( QColor("DarkSalmon") )
        self.setColor( QColor("SteelBlue") )

class Plot( Qwt.QwtPlot ):
    def __init__(self, parent):
        Qwt.QwtPlot.__init__(self, parent )
        self.RGBMap = 0
        self.IndexMap = 1
        self.HueMap = 2
        self.AlphaMap = 3
        self.d_alpha = 255
        self.d_spectrogram = Qwt.QwtPlotSpectrogram()
        self.d_spectrogram.setRenderThreadCount( 0 ) # use system specific thread count
        self.d_spectrogram.setCachePolicy( Qwt.QwtPlotRasterItem.PaintCache )

        contourLevels=[]
        for level in range(1,20,2):
            contourLevels.append(0.5*level)
        self.d_spectrogram.setContourLevels( contourLevels )
        self.d_spectrogram.setData( SpectrogramData() )
        self.d_spectrogram.attach( self )

        zInterval = self.d_spectrogram.data().interval( Qt.ZAxis )

        # A color bar on the right axis
        self.rightAxis = self.axisWidget( Qwt.QwtPlot.yRight )
        self.rightAxis.setTitle( "Intensity" )
        self.rightAxis.setColorBarEnabled( True )

        self.setAxisScale( Qwt.QwtPlot.yRight, zInterval.minValue(), zInterval.maxValue() )
        self.enableAxis( Qwt.QwtPlot.yRight )

        self.plotLayout().setAlignCanvasToScales( True )

        self.setColorMap( self.RGBMap )

        # LeftButton for the zooming
        # MidButton for the panning
        # RightButton: zoom out by 1
        # Ctrl+RighButton: zoom out to full size

        self.zoomer = MyZoomer( self.canvas() )
        self.zoomer.setMousePattern( Qwt.QwtEventPattern.MouseSelect2, Qt.RightButton, Qt.ControlModifier )
        self.zoomer.setMousePattern( Qwt.QwtEventPattern.MouseSelect3, Qt.RightButton )

        self.panner = Qwt.QwtPlotPanner( self.canvas() )
        self.panner.setAxisEnabled( Qwt.QwtPlot.yRight, False )
        self.panner.setMouseButton( Qt.MidButton )

        # Avoid jumping when labels with more/less digits
        # appear/disappear when scrolling vertically

        fm = QFontMetrics ( self.axisWidget( Qwt.QwtPlot.yLeft ).font() )
        sd = self.axisScaleDraw( Qwt.QwtPlot.yLeft )
        sd.setMinimumExtent( fm.width( "100.00" ) )

        c = QColor( Qt.darkBlue )
        self.zoomer.setRubberBandPen( c )
        self.zoomer.setTrackerPen( c )

    def showContour( self, on ):
        self.d_spectrogram.setDisplayMode( Qwt.QwtPlotSpectrogram.ContourMode, on )
        self.replot()

    def showSpectrogram( self, on ):
        self.d_spectrogram.setDisplayMode( Qwt.QwtPlotSpectrogram.ImageMode, on )
        if (on):
            self.d_spectrogram.setDefaultContourPen( QPen( Qt.black, 0 ) )
        else:
            self.d_spectrogram.setDefaultContourPen( QPen( Qt.NoPen ) )
        self.replot()

    def setColorMap( self,  type ):
        self.axis = self.axisWidget( Qwt.QwtPlot.yRight )
        zInterval = self.d_spectrogram.data().interval( Qt.ZAxis )
        self.d_mapType = type

        alpha = self.d_alpha
        if ( type == self.HueMap ):
            self.d_spectrogram.setColorMap( HueColorMap() )
            self.axis.setColorMap( zInterval, HueColorMap() )
        elif ( type == self.AlphaMap):
            self.alpha = 255
            self.d_spectrogram.setColorMap( AlphaColorMap() )
            self.axis.setColorMap( zInterval, AlphaColorMap() )
        elif ( type == self.IndexMap):
            self.d_spectrogram.setColorMap( LinearColorMapIndexed() )
            self.axis.setColorMap( zInterval, LinearColorMapIndexed() )
        elif ( type == self.RGBMap):
            self.d_spectrogram.setColorMap( LinearColorMapRGB() )
            self.axis.setColorMap( zInterval, LinearColorMapRGB() )
        self.d_spectrogram.setAlpha( alpha )
        self.replot()

    def setAlpha( self,  alpha ):
        # setting an alpha value doesn't make sense in combination
        # with a color map interpolating the alpha value
        self.d_alpha = alpha
        if ( self.d_mapType != self.AlphaMap ):
            self.d_spectrogram.setAlpha( alpha )
            self.replot()

    def printPlot(self): # Creates an empty file XXXXX
        printer = QPrinter( QPrinter.HighResolution )
        printer.setOrientation( QPrinter.Landscape )
        printer.setDocName( "spectrogram.pdf" )
        printer.setCreator( "Spectrogram example" )
        
        dialog = QPrintDialog ( printer )
        if ( dialog.exec_() ):
            renderer = Qwt.QwtPlotRenderer()
            if ( printer.colorMode() == QPrinter.GrayScale ):
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardBackground )
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardCanvasBackground )
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardCanvasFrame )
                renderer.setLayoutFlag( Qwt.QwtPlotRenderer.FrameWithScales )
            renderer.renderTo( self,  printer )


class MainWindow( QMainWindow ):
    def __init__(self,  *args):
        QMainWindow.__init__(self, *args )
        self.d_plot = Plot( self )
        self.setCentralWidget( self.d_plot )

        self.toolBar = QToolBar( self )
        self.btnPrint = QToolButton( self.toolBar )
        self.btnPrint.setText( "Print" )
        self.btnPrint.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        self.toolBar.addWidget( self.btnPrint )
        self.btnPrint.clicked.connect(self.d_plot.printPlot )

        self.toolBar.addSeparator()

        self.toolBar.addWidget( QLabel("Color Map " ) )
        self.mapBox = QComboBox( self.toolBar )
        self.mapBox.addItem( "RGB" )
        self.mapBox.addItem( "Indexed Colors" )
        self.mapBox.addItem( "Hue" )
        self.mapBox.addItem( "Alpha" )
        self.mapBox.setSizePolicy( QSizePolicy.Fixed, QSizePolicy.Fixed )
        self.toolBar.addWidget( self.mapBox )
        self.mapBox.currentIndexChanged['int'].connect(self.d_plot.setColorMap )
        self.toolBar.addWidget( QLabel( " Opacity " ) )
        self.slider = QSlider( Qt.Horizontal )
        self.slider.setRange( 0, 255 )
        self.slider.setValue( 255 )
        self.slider.valueChanged['int'].connect(self.d_plot.setAlpha )
        self.toolBar.addWidget( self.slider )
        self.toolBar.addWidget( QLabel("   " ) )
        self.btnSpectrogram = QCheckBox( "Spectrogram", self.toolBar )
        self.toolBar.addWidget( self.btnSpectrogram )
        self.btnSpectrogram.toggled['bool'].connect(self.d_plot.showSpectrogram ) 

        self.btnContour = QCheckBox( "Contour", self.toolBar )
        self.toolBar.addWidget( self.btnContour )
        self.btnContour.toggled['bool'].connect(self.d_plot.showContour )

        self.addToolBar( self.toolBar )

        self.btnSpectrogram.setChecked( True )
        self.btnContour.setChecked( False )

if __name__ == '__main__':
    a = QApplication(sys.argv)
    a.setStyle( "Windows" )
    mainWindow = MainWindow()
    mainWindow.resize( 600, 400 )
    mainWindow.show()
    sys.exit(a.exec_())
