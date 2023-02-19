#!/usr/bin/python

import sys
import math
import numpy as np
from PyQt6 import Qwt
from PyQt6.QtCore import Qt, QSize, QRectF
from PyQt6.QtGui import QPen, QBrush,  QPainter, QFont
from PyQt6.QtWidgets import QApplication, QFrame

Size = 27
CurvCnt = 6

xval = np.zeros(Size,float)
yval = np.zeros(Size,float)
xMap = Qwt.QwtScaleMap()
yMap = Qwt.QwtScaleMap()

class MainWin(QFrame):
    def __init__(self):
        QFrame.__init__(self)
        self.d_curves = [None]*CurvCnt
        xMap.setScaleInterval( -0.5, 10.5 )
        yMap.setScaleInterval( -1.1, 1.1 )
        # Frame style FIXME This doesn't seem to work properly
        # FIXME self.setFrameStyle( QFrame.Shape.Box | QFrame.Shape.Raised )
        self.setLineWidth( 2 )
        self.setMidLineWidth( 3 )
        # Calculate values
        for i in range(Size):
            xval[i] = i * 10.0 / ( Size - 1.0 )
            yval[i] = math.sin( xval[i] ) * math.cos( 2.0 * xval[i] )
        #  define curve styles
        i = 0
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Style.Cross, QBrush(Qt.BrushStyle.NoBrush),
                                    QPen( Qt.GlobalColor.black ), QSize( 5, 5 ) ) )
        self.d_curves[i].setPen( Qt.GlobalColor.darkGreen )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.Lines )
        self.d_curves[i].setCurveAttribute( Qwt.QwtPlotCurve.CurveAttribute.Fitted )
        i += 1
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Style.Ellipse, Qt.GlobalColor.yellow,
                                    QPen( Qt.GlobalColor.blue ), QSize( 5, 5 ) ) )
        self.d_curves[i].setPen( Qt.GlobalColor.red )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.Sticks )
        i += 1
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setPen( Qt.GlobalColor.darkBlue )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.Lines )
        i += 1
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setPen( Qt.GlobalColor.darkBlue )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.Lines )
        self.d_curves[i].setRenderHint( Qwt.QwtPlotItem.RenderHint.RenderAntialiased )
        i += 1
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setPen( Qt.GlobalColor.darkCyan )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.Steps )
        i += 1
        self.d_curves[i] = Qwt.QwtPlotCurve()
        self.d_curves[i].setSymbol( Qwt.QwtSymbol( Qwt.QwtSymbol.Style.XCross, QBrush(Qt.BrushStyle.NoBrush),
                                    QPen( Qt.GlobalColor.darkMagenta ), QSize( 5, 5 ) ) )
        self.d_curves[i].setStyle( Qwt.QwtPlotCurve.CurveStyle.NoCurve )
        # attach data
        for i in range(CurvCnt):
            self.d_curves[i].setSamples( xval, yval )

    def shiftDown(self, rect, offset ):
        rect.translate( 0, offset )

    def paintEvent( self, event ):
        #QFrame.paintEvent( event )
        painter = QPainter( self )
        painter.setClipRect( self.contentsRect() )
        self.drawContents( painter )

    # REDRAW CONTENTS
    def drawContents( self, painter ):
        r = self.contentsRect()
        deltay = r.height() // CurvCnt - 1
        r.setHeight( deltay )
        #  draw curves
        for i in range( CurvCnt ):
            xMap.setPaintInterval( r.left(), r.right() )
            yMap.setPaintInterval( r.top(), r.bottom() )
            painter.setRenderHint( QPainter.RenderHint.Antialiasing,
                self.d_curves[i].testRenderHint( Qwt.QwtPlotItem.RenderHint.RenderAntialiased ) )
            self.d_curves[i].draw( painter, xMap, yMap, QRectF(r) )
            self.shiftDown( r, deltay )

        # draw titles
        r = self.contentsRect()     # reset r
        painter.setFont( QFont( "Helvetica", 8 ) )
        alignment = Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignHCenter
        painter.setPen( Qt.GlobalColor.black )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Line/Fitted, Symbol: Cross" )
        self.shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Sticks, Symbol: Ellipse" )
        self.shiftDown( r, deltay )
        painter.drawText( 0 , r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Lines, Symbol: None" )
        self.shiftDown( r, deltay )
        painter.drawText( 0 , r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Lines, Symbol: None, Antialiased" )
        self.shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: Steps, Symbol: None" )
        self.shiftDown( r, deltay )
        painter.drawText( 0, r.top(), r.width(), painter.fontMetrics().height(),
            alignment, "Style: NoCurve, Symbol: XCross" )


if __name__ == '__main__':
    a = QApplication(sys.argv)
    a.setStyle( "Windows" )
    w = MainWin()
    w.resize( 300, 600 )
    w.show()
    sys.exit(a.exec())
