#!/usr/bin/python3

# python radio.py <qtversion (4 or 5)>
# Tested for python3 Qt5. Crashes if mouse is over plot canvas

import sys
from PyQt5 import Qwt
from PyQt5.QtCore import Qt,  QTimer,  QRectF, QPointF,  qRound # pyqtSignal, Qt,  QSize, QBasicTimer
from PyQt5.QtGui import QColor,  QPalette, QPainterPath,  QPen #,  QPixmap, QFont,  QIcon, QLinearGradient
from PyQt5.QtWidgets import (QWidget,  QApplication,  QTabWidget,  QGridLayout )
#from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

M_PI=3.141

class CompassGrid( QWidget ): #QFrame( parent )
    def __init__(self, parent=None):
        QWidget.__init__(self,  parent)
        p = QPalette()
        p.setColor( self.backgroundRole(), Qt.gray )
        self.setPalette( p )
        self.setAutoFillBackground( True )
        layout = QGridLayout( self )
        layout.setSpacing( 5 )
        #layout.setMargin( 0 )
        for i in range(6):
            compass = self.createCompass( i )
            layout.addWidget( compass, i // 3, i % 3 )

        #for i in range(layout.columnCount()):
        #    layout.setColumnStretch( i, 1 )

    def createCompass( self, pos ):
        palette0 = QPalette()
        for c in range(QPalette.NColorRoles):
            colorRole = QPalette.ColorRole( c )
            palette0.setColor( colorRole, QColor() )

        #palette0.setColor( QPalette.Base, palette().color( QPalette.backgroundRole() ).light( 120 ) )
        palette0.setColor( QPalette.WindowText,
            palette0.color( QPalette.Base ) )

        compass = Qwt.QwtCompass( self )
        compass.setLineWidth( 4 )
        compass.setFrameShadow(Qwt.QwtCompass.Sunken)
        #    pos <= 2 ? QwtCompass.Sunken : QwtCompass.Raised )

        if pos == 0:
            #A compass with a rose and no needle. Scale and rose are rotating.
            compass.setMode( Qwt.QwtCompass.RotateScale )

            rose = Qwt.QwtSimpleCompassRose( 16, 2 )
            rose.setWidth( 0.15 )

            compass.setRose( rose )
        elif pos == 1:
            #A windrose, with a scale indicating the main directions only
            map = {}
            map[0.0] = "N" 
            map[90.0] = "E" 
            map[180.0] = "S" 
            map[270.0] = "W" 

            compass.setScaleDraw( Qwt.QwtCompassScaleDraw( map ) )

            rose = Qwt.QwtSimpleCompassRose( 4, 1 )
            compass.setRose( rose )

            compass.setNeedle( Qwt.QwtCompassWindArrow( Qwt.QwtCompassWindArrow.Style2 ) )
            compass.setValue( 60.0 )
        elif pos == 2:
            #A compass with a rotating needle in darkBlue. Shows
            #a ticks for each degree.

            palette0.setColor( QPalette.Base, Qt.darkBlue )
            palette0.setColor( QPalette.WindowText, QColor( Qt.darkBlue ))#.dark( 120 ) )
            palette0.setColor( QPalette.Text, Qt.white )

            scaleDraw = Qwt.QwtCompassScaleDraw()
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Ticks, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Labels, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Backbone, False )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MinorTick, 1 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MediumTick, 1 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MajorTick, 3 )

            compass.setScaleDraw( scaleDraw )

            compass.setScaleMaxMajor( 36 )
            compass.setScaleMaxMinor( 5 )

            compass.setNeedle( Qwt.QwtCompassMagnetNeedle( Qwt.QwtCompassMagnetNeedle.ThinStyle ) )
            compass.setValue( 220.0 )
        elif pos == 3:
            #A compass without a frame, showing numbers as tick labels.
            #The origin is at 220.0
            palette0.setColor( QPalette.Base, self.palette().color( self.backgroundRole() ) )
            palette0.setColor( QPalette.WindowText, Qt.blue )
            compass.setLineWidth( 0 )
            map = {}
            for  d in range(0,360,60):
                map[d] = "%.0f"%(d*1.0) 

            scaleDraw = Qwt.QwtCompassScaleDraw( map )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Ticks, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Labels, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Backbone, True )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MinorTick, 0 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MediumTick, 0 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MajorTick, 3 )
            compass.setScaleDraw( scaleDraw )
            compass.setScaleMaxMajor( 36 )
            compass.setScaleMaxMinor( 5 )
            compass.setNeedle( Qwt.QwtDialSimpleNeedle( Qwt.QwtDialSimpleNeedle.Ray, True, Qt.white ) )
            compass.setOrigin( 220.0 )
            compass.setValue( 20.0 )
        elif pos == 4:
            #A compass showing another needle
            scaleDraw = Qwt.QwtCompassScaleDraw()
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Ticks, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Labels, True )
            scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Backbone, False )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MinorTick, 0 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MediumTick, 0 )
            scaleDraw.setTickLength( Qwt.QwtScaleDiv.MajorTick, 3 )
            compass.setScaleDraw( scaleDraw )
            compass.setNeedle( Qwt.QwtCompassMagnetNeedle( Qwt.QwtCompassMagnetNeedle.TriangleStyle, Qt.white, Qt.red ) )
            compass.setValue( 220.0 )
        elif pos == 5:
            #A compass with a yellow on black ray
            palette0.setColor( QPalette.WindowText, Qt.black )
            compass.setNeedle( Qwt.QwtDialSimpleNeedle( Qwt.QwtDialSimpleNeedle.Ray, False, Qt.yellow ) )
            compass.setValue( 315.0 )

        newPalette = compass.palette()
        for c in range(QPalette.NColorRoles):
            colorRole = QPalette.ColorRole( c )
            if ( palette0.color( colorRole ).isValid() ):
                newPalette.setColor( colorRole, palette0.color( colorRole ) )

        for i in range(QPalette.NColorGroups):
            colorGroup = QPalette.ColorGroup( i )
            light = newPalette.color( colorGroup, QPalette.Base )#.light( 170 )
            dark = newPalette.color( colorGroup, QPalette.Base )#.dark( 170 )
            #mid = compass.frameShadow() == QwtDial.Raised
            #    ? newPalette.color( colorGroup, QPalette.Base ).dark( 110 )
            #    : newPalette.color( colorGroup, QPalette.Base ).light( 110 )
            mid = newPalette.color( colorGroup, QPalette.Base )#.dark( 110 )
            newPalette.setColor( colorGroup, QPalette.Dark, dark )
            newPalette.setColor( colorGroup, QPalette.Mid, mid )
            newPalette.setColor( colorGroup, QPalette.Light, light )
        compass.setPalette( newPalette )
        return compass

class SpeedoMeter( Qwt.QwtDial ): #QwtDial( parent ), 
    def __init__(self,parent = None):
        Qwt.QwtDial.__init__(self,parent)
        self.d_label = "km/h"
        scaleDraw = Qwt.QwtRoundScaleDraw()
        scaleDraw.setSpacing( 8 )
        scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Backbone, False )
        scaleDraw.setTickLength( Qwt.QwtScaleDiv.MinorTick, 0 )
        scaleDraw.setTickLength( Qwt.QwtScaleDiv.MediumTick, 4 )
        scaleDraw.setTickLength( Qwt.QwtScaleDiv.MajorTick, 8 )
        self. setScaleDraw( scaleDraw )

        self.setWrapping( False )
        self.setReadOnly( True )

        self.setOrigin( 135.0 )
        self.setScaleArc( 0.0, 270.0 )

        needle = Qwt.QwtDialSimpleNeedle(
            Qwt.QwtDialSimpleNeedle.Arrow, True, Qt.red,
            QColor( Qt.gray ))#.light( 130 ) )
        self.setNeedle( needle )

    def setLabel( self, label ):
        self.d_label = label
        self.update()

    def label(self):
        return self.d_label

    def drawScaleContents( self, painter, center, radius ):
        rect = QRectF( 0.0, 0.0, 2.0 * radius, 2.0 * radius - 10.0 )
        rect.moveCenter( center )
        color = self.palette().color( QPalette.Text )
        painter.setPen( color )
        flags = Qt.AlignBottom | Qt.AlignHCenter
        painter.drawText( rect, flags, self.d_label )

class AttitudeIndicatorNeedle(Qwt.QwtDialNeedle):
    def __init__(self,  color=None):
        Qwt.QwtDialNeedle.__init__(self)
        palette = QPalette()
        palette.setColor( QPalette.Text, color )
        #self.setPalette( palette )

    def rawNeedle( self,  painter, length, colorGroup ):
        triangleSize = length * 0.1
        pos = length - 2.0

        path = QPainterPath()
        path.moveTo( pos, 0 )
        path.lineTo( pos - 2 * triangleSize, triangleSize )
        path.lineTo( pos - 2 * triangleSize, -triangleSize )
        path.closeSubpath()

        painter.setBrush( self.palette().brush( colorGroup, QPalette.Text ) )
        painter.drawPath( path )

        l = length - 2
        painter.setPen( QPen( self.palette().color( colorGroup, QPalette.Text ), 3 ) )
        painter.drawLine( QPointF( 0.0, -l ), QPointF( 0.0, l ) )


class AttitudeIndicator(Qwt.QwtDial):
    def __init__(self, parent = None):
        Qwt.QwtDial.__init__( self,  parent )
        self.d_gradient = 0.0
        scaleDraw = Qwt.QwtRoundScaleDraw()
        scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Backbone, False )
        scaleDraw.enableComponent( Qwt.QwtAbstractScaleDraw.Labels, False )
        self.setScaleDraw( scaleDraw )

        #self.setMode( Qwt.RotateScale )
        self.setWrapping( True )

        self.setOrigin( 270.0 )

        self.setScaleMaxMinor( 0 )
        self.setScaleStepSize( 30.0 )
        self.setScale( 0.0, 360.0 )

        color = self.palette().color( QPalette.Text )
        self.setNeedle( AttitudeIndicatorNeedle( color ) )

    def setGradient( self,  gradient ):
        if ( gradient < -1.0 ):
            gradient = -1.0
        elif ( gradient > 1.0 ):
            gradient = 1.0
        if ( self.d_gradient != gradient ):
            self.d_gradient = gradient
            self.update()

    def drawScale( self,  painter, center, radius ):
        offset = 4.0
        p0 = self.qwtPolar2Pos( center, offset, 1.5 * M_PI )
        w = self.innerRect().width()
        path = QPainterPath()
        path.moveTo( Qwt.qwtPolar2Pos( p0, w, 0.0 ) )
        path.lineTo( Qwt.qwtPolar2Pos( path.currentPosition(), 2 * w, M_PI ) )
        path.lineTo( Qwt.qwtPolar2Pos( path.currentPosition(), w, 0.5 * M_PI ) )
        path.lineTo( Qwt.qwtPolar2Pos( path.currentPosition(), w, 0.0 ) )
        painter.save()
        painter.setClipPath( path ) # swallow 180 - 360 degrees
        Qwt.QwtDial.drawScale( painter, center, radius )
        painter.restore()

    def drawScaleContents( self,  painter, double ):
        dir = 360 - qRound( self.origin() - self.value() ) # counter clockwise
        arc = 90 + qRound( self.gradient() * 90 )
        skyColor = QColor( 38, 151, 221 )
        painter.save()
        painter.setBrush( skyColor )
        painter.drawChord( self.scaleInnerRect(), ( dir - arc ) * 16, 2 * arc * 16 )
        painter.restore()

    def keyPressEvent( self,  event ):
        k = event.key() 
        if k == Qt.Key_Plus:
            self.setGradient( self.gradient() + 0.05 )
        elif k == Qt.Key_Minus:
            self.setGradient( self.gradient() - 0.05 )
        else:
            Qwt.QwtDial.keyPressEvent( event )

    def angle(self):
        return self.value()
        
    def gradient(self):
        return self.d_gradient

    def setAngle( self,  angle ):
        self.setValue( angle )

class CockpitGrid( QWidget ):
    def __init__(self, parent = None):
        QWidget.__init__(self, parent)
        self.setAutoFillBackground( True )
        #self.setPalette( self.colorTheme( QColor( Qt.darkGray )))#.dark( 150 ) ) )
        layout = QGridLayout( self )
        layout.setSpacing( 5 )
        #layout.setMargin( 0 )
        for i in range(2): # FIXME. Should be 3 but program crashes for the third one.
            dial = self.createDial( i )
            layout.addWidget( dial, 0, i )

        for i in range(layout.columnCount()):
            layout.setColumnStretch( i, 1 )

    def createDial( self, pos ):
        dial = None
        if pos == 0:
            self.d_clock = Qwt.QwtAnalogClock( )
            # disable minor ticks
            #d_clock.scaleDraw().setTickLength( QwtScaleDiv.MinorTick, 0 )
            knobColor = QColor( Qt.gray ) # .light( 130 )

            for i in range(Qwt.QwtAnalogClock.NHands):
                handColor = QColor( Qt.gray ) #.light( 150 )
                width = 8
                if i == Qwt.QwtAnalogClock.SecondHand:
                    handColor = Qt.gray
                    width = 5
                hand = Qwt.QwtDialSimpleNeedle( Qwt.QwtDialSimpleNeedle.Arrow, True, handColor, knobColor )
                hand.setWidth( width )
                self.d_clock.setHand( Qwt.QwtAnalogClock.Hand( i ), hand )
            timer = QTimer( self.d_clock )
            timer.timeout.connect(self.d_clock.setCurrentTime)
            timer.start( 1000 )
            dial = self.d_clock
        elif pos == 1:
            self.d_speedo = SpeedoMeter( self )
            self.d_speedo.setScaleStepSize( 20.0 )
            self.d_speedo.setScale( 0.0, 240.0 )
            self.d_speedo.scaleDraw().setPenWidth( 2 )
            timer = QTimer( self.d_speedo )
            timer.timeout.connect(self.changeSpeed )
            timer.start( 50 )
            dial = self.d_speedo
        elif pos == 2:
            self.d_ai = AttitudeIndicator( self )
            self.d_ai.scaleDraw().setPenWidth( 3 )
            gradientTimer = QTimer( self.d_ai )
            gradientTimer.timeout.connect(self.changeGradient )
            gradientTimer.start( 100 )
            angleTimer = QTimer( self.d_ai )
            angleTimer.timeout.connect( self.changeAngle )
            angleTimer.start( 100 )
            dial = self.d_ai

        if ( dial ):
            dial.setReadOnly( True )
            dial.setLineWidth( 4 )
            dial.setFrameShadow(Qwt.QwtDial.Sunken )
        return dial

    def colorTheme( self, base ):
        palette = QPalette
        palette.setColor( QPalette.Base, base )
        palette.setColor( QPalette.Window, base.dark( 150 ) )
        palette.setColor( QPalette.Mid, base.dark( 110 ) )
        palette.setColor( QPalette.Light, base.light( 170 ) )
        palette.setColor( QPalette.Dark, base.dark( 170 ) )
        palette.setColor( QPalette.Text, base.dark( 200 ).light( 800 ) )
        palette.setColor( QPalette.WindowText, base.dark( 200 ) )
        return palette

    def changeSpeed(self):
        offset = 0.8
        speed = self.d_speedo.value()
        if ( ( speed < 7.0 and offset < 0.0 ) or ( speed > 203.0 and offset > 0.0 ) ):
            offset = -offset
        counter = 0
        """switch( counter++ % 12 )
        {
            case 0:
            case 2:
            case 7:
            case 8:
                break
            default:
        }"""
        self.d_speedo.setValue( speed + offset )

    def changeAngle(self):
        offset = 0.05
        angle = self.d_ai.angle()
        if ( angle > 180.0 ):
            angle -= 360.0
        if ( ( angle < -5.0 and offset < 0.0 ) or ( angle > 5.0 and offset > 0.0 ) ):
            offset = -offset
        self.d_ai.setAngle( angle + offset )

    def changeGradient(self):
        offset = 0.005
        gradient = self.d_ai.gradient()
        if ( ( gradient < -0.05 and offset < 0.0 ) or ( gradient > 0.05 and offset > 0.0 ) ):
            offset = -offset
        self.d_ai.setGradient( gradient + offset )

a = QApplication(sys.argv)
tabWidget = QTabWidget()
tabWidget.addTab(CompassGrid(),"Compass")
tabWidget.addTab(CockpitGrid(),"Cockpit")
tabWidget.show()

sys.exit(a.exec_())
