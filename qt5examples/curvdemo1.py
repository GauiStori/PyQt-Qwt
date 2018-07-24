#!/usr/bin/python

import sys
import math
#import Qwt
from PyQt5 import Qwt
from PyQt5.QtCore import Qt,  qIsNaN,  qRound, QSize
from PyQt5.QtGui import QColor, QPen, QBrush, qRgb,  QFontMetrics
from PyQt5.QtWidgets import QApplication, QWidget,  QCheckBox,  QToolBar,  QToolButton,  QLabel,  QComboBox,  QSlider,  QSizePolicy, QMainWindow, QFrame
from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

#include <qwt_scale_map.h>
#include <qwt_plot_curve.h>
#include <qwt_symbol.h>
#include <qwt_math.h>
#include <qcolor.h>
#include <qpainter.h>
#include <qapplication.h>
#include <qframe.h>

Size = 27
CurvCnt = 6

xval  = [None]*Size
yval = [None]*Size
xMap = Qwt.QwtScaleMap()
yMap = Qwt.QwtScaleMap()

class MainWin(QFrame):
    def __init__(self):
        QFrame.__init__(self)
        self.d_curves = [Qwt.QwtPlotCurve]*CurvCnt
        xMap.setScaleInterval( -0.5, 10.5 )
        yMap.setScaleInterval( -1.1, 1.1 )
        # Frame style
        self.setFrameStyle( QFrame.Box | QFrame.Raised )
        self.setLineWidth( 2 )
        self.setMidLineWidth( 3 )
        # Calculate values
        for i in range(Size):
            xval[i] = i * 10.0 / ( Size - 1.0 )
            yval[i] = math.sin( xval[i] ) * math.cos( 2.0 * xval[i] )
        #  define curve styles
        i = 0
        #self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Cross, Qt.NoBrush,
        #    QPen( Qt.black ), QSize( 5, 5 ) ) )
        self.d_curves[i].setPen( QColor( 150, 150, 200 ) ) #Qt.darkGreen )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.Lines )
        self.d_curves[i].setCurveAttribute( QwtPlotCurve.Fitted )
        i += 1
        #self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Ellipse, Qt.yellow,
        #    QPen( Qt.blue ), QSize( 5, 5 ) ) )
        self.d_curves[i].setPen( QColor( 150, 150, 200 ) ) #Qt.red )
        self.d_curves[i].setStyle( QwtPlotCurve.Sticks )
        i += 1
        self.d_curves[i].setPen( QColor( 150, 150, 200 ) ) #Qt.darkBlue )
        self.d_curves[i].setStyle( QwtPlotCurve.Lines )
        i += 1
        self.d_curves[i].setPen( QColor( 150, 150, 200 ) ) #Qt.darkBlue )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.Lines )
        self.d_curves[i].setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        i += 1
        self.d_curves[i].setPen( QColor( 150, 150, 200 ) ) #Qt.darkCyan )
        self.d_curves[i].setStyle( QwtPlotCurve.Steps )
        i += 1
        #self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.XCross, Qt.NoBrush,
        #    QPen( Qt.darkMagenta ), QSize( 5, 5 ) ) )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.NoCurve )
        i += 1
        # attach data
        for i in range(CurvCnt):
            self.d_curves[i].setRawSamples( xval, yval, Size )

    def shiftDown(self, rect, offset ):
        rect.translate( 0, offset )

    def paintEvent( event ):
        QFrame.paintEvent( event )
        painter = QPainter( self )
        painter.setClipRect( contentsRect() )
        self.drawContents( painter )

    # REDRAW CONTENTS
    def drawContents( self, painter ):
        r = QRect.contentsRect()
        deltay = r.height() / CurvCnt - 1
        r.setHeight( deltay )
        #  draw curves
        for i in range( CurvCnt ):
            xMap.setPaintInterval( r.left(), r.right() )
            yMap.setPaintInterval( r.top(), r.bottom() )
            painter.setRenderHint( QPainter.Antialiasing,
                self.d_curves[i].testRenderHint( Qwt.QwtPlotItem.RenderAntialiased ) )
            self.d_curves[i].draw( painter, xMap, yMap, r )
            self.shiftDown( r, deltay )

        # draw titles
        r = contentsRect()     # reset r
        painter.setFont( QFont( "Helvetica", 8 ) )
        alignment = Qt.AlignTop | Qt.AlignHCenter
        painter.setPen( Qt.black )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Line/Fitted, Symbol: Cross" )
        shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Sticks, Symbol: Ellipse" )
        shiftDown( r, deltay )
        painter.drawText( 0 , r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Lines, Symbol: None" )
        shiftDown( r, deltay )
        painter.drawText( 0 , r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Lines, Symbol: None, Antialiased" )
        shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Steps, Symbol: None" )
        shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: NoCurve, Symbol: XCross" )


if __name__ == '__main__':
    a = QApplication(sys.argv)
    a.setStyle( "Windows" )
    w = MainWin()
    w.resize( 300, 600 )
    w.show()
    sys.exit(a.exec())
