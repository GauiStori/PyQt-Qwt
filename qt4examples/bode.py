#!/usr/bin/python

import sys
import math
#import Qwt
#import Qwt
from PyQt4 import Qwt
from PyQt4.QtCore import Qt,  QSize
from PyQt4.QtGui import QColor,  QPixmap, QFont,  QIcon, QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication
#from PyQt4.QtPrintSupport import QPrintDialog, QPrinter
 

def logSpace(size, xmin, xmax ):
    array = []#np.zeros(0,float)
    for i in range(size):
        array.append(0.0)
    if ( ( xmin <= 0.0 ) or ( xmax <= 0.0 ) or ( size <= 0 ) ):
        return array;
    imax = size - 1;
    array[0] = xmin;
    array[imax] = xmax;
    lxmin = math.log( xmin )
    lxmax = math.log( xmax )
    lstep = ( lxmax - lxmin ) / imax 
    for i in range(imax):
        array[i] = math.exp( lxmin + i * lstep )
    return array

print_xpm = ["32 32 12 1",
    "a c #ffffff",
    "h c #ffff00",
    "c c #ffffff",
    "f c #dcdcdc",
    "b c #c0c0c0",
    "j c #a0a0a4",
    "e c #808080",
    "g c #808000",
    "d c #585858",
    "i c #00ff00",
    "# c #000000",
    ". c None",
    "................................",
    "................................",
    "...........###..................",
    "..........#abb###...............",
    ".........#aabbbbb###............",
    ".........#ddaaabbbbb###.........",
    "........#ddddddaaabbbbb###......",
    ".......#deffddddddaaabbbbb###...",
    "......#deaaabbbddddddaaabbbbb###",
    ".....#deaaaaaaabbbddddddaaabbbb#",
    "....#deaaabbbaaaa#ddedddfggaaad#",
    "...#deaaaaaaaaaa#ddeeeeafgggfdd#",
    "..#deaaabbbaaaa#ddeeeeabbbbgfdd#",
    ".#deeefaaaaaaa#ddeeeeabbhhbbadd#",
    "#aabbbeeefaaa#ddeeeeabbbbbbaddd#",
    "#bbaaabbbeee#ddeeeeabbiibbadddd#",
    "#bbbbbaaabbbeeeeeeabbbbbbaddddd#",
    "#bjbbbbbbaaabbbbeabbbbbbadddddd#",
    "#bjjjjbbbbbbaaaeabbbbbbaddddddd#",
    "#bjaaajjjbbbbbbaaabbbbadddddddd#",
    "#bbbbbaaajjjbbbbbbaaaaddddddddd#",
    "#bjbbbbbbaaajjjbbbbbbddddddddd#.",
    "#bjjjjbbbbbbaaajjjbbbdddddddd#..",
    "#bjaaajjjbbbbbbjaajjbddddddd#...",
    "#bbbbbaaajjjbbbjbbaabdddddd#....",
    "###bbbbbbaaajjjjbbbbbddddd#.....",
    "...###bbbbbbaaajbbbbbdddd#......",
    "......###bbbbbbjbbbbbddd#.......",
    ".........###bbbbbbbbbdd#........",
    "............###bbbbbbd#.........",
    "...............###bbb#..........",
    "..................###..........."]


zoom_xpm = ["32 32 8 1",
    "# c #000000",
    "b c #c0c0c0",
    "a c #ffffff",
    "e c #585858",
    "d c #a0a0a4",
    "c c #0000ff",
    "f c #00ffff",
    ". c None",
    "..######################........",
    ".#a#baaaaaaaaaaaaaaaaaa#........",
    "#aa#baaaaaaaaaaaaaccaca#........",
    "####baaaaaaaaaaaaaaaaca####.....",
    "#bbbbaaaaaaaaaaaacccaaa#da#.....",
    "#aaaaaaaaaaaaaaaacccaca#da#.....",
    "#aaaaaaaaaaaaaaaaaccaca#da#.....",
    "#aaaaaaaaaabe###ebaaaaa#da#.....",
    "#aaaaaaaaa#########aaaa#da#.....",
    "#aaaaaaaa###dbbbb###aaa#da#.....",
    "#aaaaaaa###aaaaffb###aa#da#.....",
    "#aaaaaab##aaccaaafb##ba#da#.....",
    "#aaaaaae#daaccaccaad#ea#da#.....",
    "#aaaaaa##aaaaaaccaab##a#da#.....",
    "#aaaaaa##aacccaaaaab##a#da#.....",
    "#aaaaaa##aaccccaccab##a#da#.....",
    "#aaaaaae#daccccaccad#ea#da#.....",
    "#aaaaaab##aacccaaaa##da#da#.....",
    "#aaccacd###aaaaaaa###da#da#.....",
    "#aaaaacad###daaad#####a#da#.....",
    "#acccaaaad##########da##da#.....",
    "#acccacaaadde###edd#eda#da#.....",
    "#aaccacaaaabdddddbdd#eda#a#.....",
    "#aaaaaaaaaaaaaaaaaadd#eda##.....",
    "#aaaaaaaaaaaaaaaaaaadd#eda#.....",
    "#aaaaaaaccacaaaaaaaaadd#eda#....",
    "#aaaaaaaaaacaaaaaaaaaad##eda#...",
    "#aaaaaacccaaaaaaaaaaaaa#d#eda#..",
    "########################dd#eda#.",
    "...#dddddddddddddddddddddd##eda#",
    "...#aaaaaaaaaaaaaaaaaaaaaa#.####",
    "...########################..##."]

class Plot( Qwt.QwtPlot):
    def __init__(self, parent=None):
        Qwt.QwtPlot.__init__(self, parent)
        self.setAutoReplot( False )
        self.setTitle( "Frequency Response of a Second-Order System" )
        canvas = Qwt.QwtPlotCanvas()
        canvas.setBorderRadius( 10 )
        self.setCanvas( canvas )
        self.setCanvasBackground( QColor( "MidnightBlue" ) )
        # legend
        legend = Qwt.QwtLegend()
        self.insertLegend( legend, Qwt.QwtPlot.BottomLegend )

        # grid
        grid = Qwt.QwtPlotGrid()
        grid.enableXMin( True )
        grid.setMajorPen( Qt.white, 0, Qt.DotLine )
        grid.setMinorPen( Qt.gray, 0 , Qt.DotLine )
        grid.attach( self )

        # axes
        self.enableAxis( Qwt.QwtPlot.yRight )
        self.setAxisTitle( Qwt.QwtPlot.xBottom, "Normalized Frequency" )
        self.setAxisTitle( Qwt.QwtPlot.yLeft, "Amplitude [dB]" )
        self.setAxisTitle( Qwt.QwtPlot.yRight, "Phase [deg]" )

        self.setAxisMaxMajor( Qwt.QwtPlot.xBottom, 6 )
        self.setAxisMaxMinor( Qwt.QwtPlot.xBottom, 9 )
        self.setAxisScaleEngine( Qwt.QwtPlot.xBottom, Qwt.QwtLogScaleEngine() )

        # curves
        self.d_curve1 = Qwt.QwtPlotCurve( "Amplitude" )
        self.d_curve1.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.d_curve1.setPen( Qt.yellow )
        self.d_curve1.setLegendAttribute( Qwt.QwtPlotCurve.LegendShowLine )
        self.d_curve1.setYAxis( Qwt.QwtPlot.yLeft )
        self.d_curve1.attach( self )

        self.d_curve2 = Qwt.QwtPlotCurve( "Phase" )
        self.d_curve2.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.d_curve2.setPen( Qt.cyan )
        self.d_curve2.setLegendAttribute( Qwt.QwtPlotCurve.LegendShowLine )
        self.d_curve2.setYAxis( Qwt.QwtPlot.yRight )
        self.d_curve2.attach( self )

        # marker
        self.d_marker1 = Qwt.QwtPlotMarker()
        self.d_marker1.setValue( 0.0, 0.0 )
        self.d_marker1.setLineStyle( Qwt.QwtPlotMarker.VLine )
        self.d_marker1.setLabelAlignment( Qt.AlignRight | Qt.AlignBottom )
        self.d_marker1.setLinePen( Qt.green, 0, Qt.DashDotLine )
        self.d_marker1.attach( self )

        self.d_marker2 = Qwt.QwtPlotMarker()
        self.d_marker2.setLineStyle( Qwt.QwtPlotMarker.HLine )
        self.d_marker2.setLabelAlignment( Qt.AlignRight | Qt.AlignBottom )
        self.d_marker2.setLinePen( QColor( 200, 150, 0 ), 0, Qt.DashDotLine )
        self.d_marker2.setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Diamond,QColor( Qt.yellow ), QColor( Qt.green ), QSize( 8, 8 ) ) )
        self.d_marker2.attach( self )

        self.setDamp( 0 )

        self.setAutoReplot( True )

    def showData(self,  frequency, amplitude, phase, count ):
        self.d_curve1.setSamples( frequency, amplitude)
        self.d_curve2.setSamples( frequency, phase)

    def showPeak( self, freq, amplitude ):
        label = "Peak: %.3g dB"%amplitude
        text = Qwt.QwtText( label )
        text.setFont( QFont( "Helvetica", 10, QFont.Bold ) )
        text.setColor( QColor( 200, 150, 0 ) )
        self.d_marker2.setValue( freq, amplitude )
        self.d_marker2.setLabel( text )

    def show3dB( self, freq ):
        label = "-3 dB at f = %.3g"%freq
        text = Qwt.QwtText( label )
        text.setFont( QFont( "Helvetica", 10, QFont.Bold ) )
        text.setColor( Qt.green )
        self.d_marker1.setValue( freq, 0.0 )
        self.d_marker1.setLabel( text )

    #re-calculate frequency response
    def setDamp( self,  damping ):
        doReplot = self.autoReplot()
        self.setAutoReplot( False )
        ArraySize = 200;
        #amplitude = np.zeros(ArraySize, float)
        amplitude = []
        for i in range(ArraySize):
            amplitude.append(0.0)
        #phase = np.zeros(ArraySize, float)
        phase = []
        for i in range(ArraySize):
            phase.append(0.0)
        
        # build frequency vector with logarithmic division
        frequency = logSpace( ArraySize, 0.01, 100 )
        i3 = 1
        fmax = 1
        amax = -1000.0
        for i in range(ArraySize):
            f = frequency[i];
            g = complex( 1.0 ) / complex( 1.0 - f * f, 2.0 * damping * f )
            amplitude[i] = 20.0 * math.log10( math.sqrt( g.real * g.real + g.imag * g.imag ) )
            phase[i] = math.atan2( g.imag, g.real ) * ( 180.0 / 3.14159)#M_PI )

            if ( ( i3 <= 1 ) and ( amplitude[i] < -3.0 ) ):
                i3 = i
            if ( amplitude[i] > amax ):
                amax = amplitude[i];
                fmax = frequency[i];
        f3 = frequency[i3] - ( frequency[i3] - frequency[i3 - 1] ) / ( amplitude[i3] - amplitude[i3 -1] ) * ( amplitude[i3] + 3 )
        self.showPeak( fmax, amax )
        self.show3dB( f3 )
        self.showData( frequency, amplitude, phase, ArraySize )
        self.setAutoReplot( doReplot )
        self.replot()

class Zoomer(Qwt.QwtPlotZoomer):
    def __init__(self, xAxis, yAxis, canvas ):
        Qwt.QwtPlotZoomer.__init__(self, xAxis, yAxis, canvas )
        self.setTrackerMode( Qwt.QwtPicker.AlwaysOff )
        self.setRubberBand( Qwt.QwtPicker.NoRubberBand )
        # RightButton: zoom out by 1
        # Ctrl+RightButton: zoom out to full size
        self.setMousePattern( Qwt.QwtEventPattern.MouseSelect2, Qt.RightButton, Qt.ControlModifier )
        self.setMousePattern( Qwt.QwtEventPattern.MouseSelect3, Qt.RightButton )

class MainWindow( QMainWindow ):
    def __init__(self, *args):
        QMainWindow.__init__(self, *args) 
        self.d_plot = Plot( self )
        margin = 5;
        self.d_plot.setContentsMargins( margin, margin, margin, 0 )

        self.setContextMenuPolicy( Qt.NoContextMenu )

        self.d_zoomer=[None,None]
        self.d_zoomer[0] = Zoomer( Qwt.QwtPlot.xBottom, Qwt.QwtPlot.yLeft, self.d_plot.canvas() )
        self.d_zoomer[0].setRubberBand( Qwt.QwtPicker.RectRubberBand )
        self.d_zoomer[0].setRubberBandPen( QColor( Qt.green ) )
        self.d_zoomer[0].setTrackerMode( Qwt.QwtPicker.ActiveOnly )
        self.d_zoomer[0].setTrackerPen( QColor( Qt.white ) )

        self.d_zoomer[1] = Zoomer( Qwt.QwtPlot.xTop, Qwt.QwtPlot.yRight, self.d_plot.canvas() )
        self.d_panner = Qwt.QwtPlotPanner( self.d_plot.canvas() )
        self.d_panner.setMouseButton( Qt.MidButton )

        self.d_picker = Qwt.QwtPlotPicker( Qwt.QwtPlot.xBottom, Qwt.QwtPlot.yLeft,
            Qwt.QwtPlotPicker.CrossRubberBand, Qwt.QwtPicker.AlwaysOn, self.d_plot.canvas() )
        self.d_picker.setStateMachine( Qwt.QwtPickerDragPointMachine() )
        self.d_picker.setRubberBandPen( QColor( Qt.green ) )
        self.d_picker.setRubberBand( Qwt.QwtPicker.CrossRubberBand )
        self.d_picker.setTrackerPen( QColor( Qt.white ) )

        self.setCentralWidget( self.d_plot )

        self.toolBar = QToolBar( self )

        self.btnZoom = QToolButton( self.toolBar )
        self.btnZoom.setText( "Zoom" )
        self.btnZoom.setIcon( QIcon(QPixmap( zoom_xpm ) ))
        self.btnZoom.setCheckable( True )
        self.btnZoom.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        self.toolBar.addWidget( self.btnZoom )
        self.btnZoom.toggled.connect(self.enableZoomMode)

        self.btnPrint = QToolButton( self.toolBar )
        self.btnPrint.setText( "Print" )
        self.btnPrint.setIcon( QIcon(QPixmap( print_xpm ) ) )
        self.btnPrint.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        self.toolBar.addWidget( self.btnPrint )        
        self.btnPrint.clicked.connect(self.mprint)

        self.btnExport = QToolButton( self.toolBar )
        self.btnExport.setText( "Export" )
        self.btnExport.setIcon( QIcon(QPixmap( print_xpm ) ) )
        self.btnExport.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        self.toolBar.addWidget( self.btnExport )        
        self.btnExport.clicked.connect(self.exportDocument)

        self.toolBar.addSeparator()

        hBox = QWidget( self.toolBar )

        self.layout = QHBoxLayout( hBox )
        self.layout.setSpacing( 0 )
        self.layout.addWidget( QWidget( hBox ), 10 ) # spacer
        self.layout.addWidget( QLabel( "Damping Factor", hBox ), 0 )
        self.layout.addSpacing( 10 )

        self.cntDamp = Qwt.QwtCounter( hBox )
        self.cntDamp.setRange( 0.0, 5.0 )
        self.cntDamp.setSingleStep( 0.01 )
        self.cntDamp.setValue( 0.0 )

        self.layout.addWidget( self.cntDamp, 0 )

        self.toolBar.addWidget( hBox )

        self.addToolBar( self.toolBar )
        self.statusBar()
        self.enableZoomMode( False )
        self.showInfo("humm")

        self.cntDamp.valueChanged['double'].connect(self.d_plot.setDamp)
        self.d_picker.moved.connect(self.moved)
        #connect( d_picker, SIGNAL( moved( const QPoint & ) ), SLOT( moved( const QPoint & ) ) )
        #connect( d_picker, SIGNAL( selected( const QPolygon & ) ), SLOT( selected( const QPolygon & ) ) )

    def mprint(self):
        printer = QPrinter( QPrinter.HighResolution )
        docName = "Humm" #self.d_plot.title().text()
        #if ( not docName.isEmpty() ):
        #docName.replace ( QRegExp ( QString.fromLatin1 ( "\n" ) ), tr ( " -- " ) )
        printer.setDocName ( docName )

        printer.setCreator( "Bode example" )
        printer.setOrientation( QPrinter.Landscape )

        dialog = QPrintDialog( printer )
        if ( dialog.exec_() ):
            renderer = Qwt.QwtPlotRenderer()
            if ( printer.colorMode() == QPrinter.GrayScale ):
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardBackground )
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardCanvasBackground )
                renderer.setDiscardFlag( Qwt.QwtPlotRenderer.DiscardCanvasFrame )
                renderer.setLayoutFlag( Qwt.QwtPlotRenderer.FrameWithScales )
            renderer.renderTo( self.d_plot, printer )

    def exportDocument(self):
        print("Not implemented")
        #renderer = Qwt.QwtPlotRenderer()
        #renderer.exportTo( self.d_plot, "bode.pdf" )

    def enableZoomMode( self, on ):
        self.d_panner.setEnabled( on )
        self.d_zoomer[0].setEnabled( on )
        self.d_zoomer[0].zoom( 0 )
        self.d_zoomer[1].setEnabled( on )
        self.d_zoomer[1].zoom( 0 )
        self.d_picker.setEnabled(  not on )
        #self.showInfo()

    def showInfo( self, text ):
        if ( text=="" ):
            if ( self.d_picker.rubberBand() ):
                text = "Cursor Pos: Press left mouse button in plot region"
            else:
                text = "Zoom: Press mouse button and drag"

        #self.statusBar.showMessage( text )

    def moved( self, pos ):
        info = "Freq=%g, Ampl=%g, Phase=%g"%(
                self.d_plot.invTransform( Qwt.QwtPlot.xBottom, pos.x() ),
                self.d_plot.invTransform( Qwt.QwtPlot.yLeft, pos.y() ),
                self.d_plot.invTransform( Qwt.QwtPlot.yRight, pos.y() ))
        self.showInfo( info )

    def selected(self):
        self.showInfo("selected")


a = QApplication(sys.argv)
m = MainWindow()
m.resize( 540, 400 )
m.show()

sys.exit(a.exec_())
