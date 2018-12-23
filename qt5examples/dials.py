#!/usr/bin/python3

# python radio.py <qtversion (4 or 5)>
# Tested for python3 Qt5. Crashes if mouse is over plot canvas

import sys
import math
from PyQt5 import Qwt
import numpy as np

from PyQt5.QtCore import pyqtSignal, Qt,  QSize, QBasicTimer
from PyQt5.QtGui import QColor,  QPixmap, QFont,  QIcon,  QPalette, QLinearGradient
from PyQt5.QtWidgets import (QMainWindow,  QWidget,  QToolBar,  QToolButton,  QHBoxLayout,  QLabel,  QApplication,  QSizePolicy, 
    QVBoxLayout,  QFrame, QTabWidget )
#from PyQt5.QtPrintSupport import QPrintDialog, QPrinter



class CompassGrid( QWidget ): #QFrame( parent )
    self.p = QPalette()
    p.setColor( backgroundRole(), Qt.gray )
    setPalette( p )
    setAutoFillBackground( true )
    layout = QGridLayout( self )
    layout.setSpacing( 5 )
    layout.setMargin( 0 )
    for i in range(6):
        QwtCompass *compass = createCompass( i )
        layout.addWidget( compass, i / 3, i % 3 )

    for i in range(layout.columnCount()):
        layout.setColumnStretch( i, 1 )

    def createCompass( self, pos ):
        palette0 = QPalette()
        for c in range(QPalette.NColorRoles):
            colorRole = QPalette.ColorRole( c )
            palette0.setColor( colorRole, QColor() )

        palette0.setColor( QPalette.Base,
            palette().color( backgroundRole() ).light( 120 ) )
        palette0.setColor( QPalette.WindowText,
            palette0.color( QPalette.Base ) )

        compass = QwtCompass( self )
        compass.setLineWidth( 4 )
        compass.setFrameShadow(
            pos <= 2 ? QwtCompass.Sunken : QwtCompass.Raised )

        if pos == 0:
            #A compass with a rose and no needle. Scale and rose are rotating.
            compass.setMode( QwtCompass.RotateScale )

            QwtSimpleCompassRose *rose = new QwtSimpleCompassRose( 16, 2 )
            rose.setWidth( 0.15 )

            compass.setRose( rose )
        elif pos == 1:
            #A windrose, with a scale indicating the main directions only
            QMap<double, QString> map
            map.insert( 0.0, "N" )
            map.insert( 90.0, "E" )
            map.insert( 180.0, "S" )
            map.insert( 270.0, "W" )

            compass.setScaleDraw( new QwtCompassScaleDraw( map ) )

            QwtSimpleCompassRose *rose = new QwtSimpleCompassRose( 4, 1 )
            compass.setRose( rose )

            compass.setNeedle(
                new QwtCompassWindArrow( QwtCompassWindArrow.Style2 ) )
            compass.setValue( 60.0 )
        elif pos == 2:
            #A compass with a rotating needle in darkBlue. Shows
            #a ticks for each degree.

            palette0.setColor( QPalette.Base, Qt.darkBlue )
            palette0.setColor( QPalette.WindowText,
                            QColor( Qt.darkBlue ).dark( 120 ) )
            palette0.setColor( QPalette.Text, Qt.white )

            QwtCompassScaleDraw *scaleDraw = new QwtCompassScaleDraw()
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Ticks, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Labels, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Backbone, false )
            scaleDraw.setTickLength( QwtScaleDiv.MinorTick, 1 )
            scaleDraw.setTickLength( QwtScaleDiv.MediumTick, 1 )
            scaleDraw.setTickLength( QwtScaleDiv.MajorTick, 3 )

            compass.setScaleDraw( scaleDraw )

            compass.setScaleMaxMajor( 36 )
            compass.setScaleMaxMinor( 5 )

            compass.setNeedle(
                new QwtCompassMagnetNeedle( QwtCompassMagnetNeedle.ThinStyle ) )
            compass.setValue( 220.0 )
        elif pos == 3:
            #A compass without a frame, showing numbers as tick labels.
            #The origin is at 220.0
            palette0.setColor( QPalette.Base, palette().color( backgroundRole() ) )
            palette0.setColor( QPalette.WindowText, Qt.blue )
            compass.setLineWidth( 0 )
            QMap<double, QString> map
            for  d in range(0,360,60):
                map.insert( d, "%.0f"%(d*1.0) )

            QwtCompassScaleDraw *scaleDraw = new QwtCompassScaleDraw( map )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Ticks, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Labels, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Backbone, true )
            scaleDraw.setTickLength( QwtScaleDiv.MinorTick, 0 )
            scaleDraw.setTickLength( QwtScaleDiv.MediumTick, 0 )
            scaleDraw.setTickLength( QwtScaleDiv.MajorTick, 3 )
            compass.setScaleDraw( scaleDraw )
            compass.setScaleMaxMajor( 36 )
            compass.setScaleMaxMinor( 5 )
            compass.setNeedle( new QwtDialSimpleNeedle( QwtDialSimpleNeedle.Ray,
                true, Qt.white ) )
            compass.setOrigin( 220.0 )
            compass.setValue( 20.0 )
        elif pos == 4:
            #A compass showing another needle
            QwtCompassScaleDraw *scaleDraw = new QwtCompassScaleDraw()
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Ticks, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Labels, true )
            scaleDraw.enableComponent( QwtAbstractScaleDraw.Backbone, false )
            scaleDraw.setTickLength( QwtScaleDiv.MinorTick, 0 )
            scaleDraw.setTickLength( QwtScaleDiv.MediumTick, 0 )
            scaleDraw.setTickLength( QwtScaleDiv.MajorTick, 3 )

            compass.setScaleDraw( scaleDraw )

            compass.setNeedle( new QwtCompassMagnetNeedle(
                QwtCompassMagnetNeedle.TriangleStyle, Qt.white, Qt.red ) )
            compass.setValue( 220.0 )
        elif pos == 5:
            #A compass with a yellow on black ray
            palette0.setColor( QPalette.WindowText, Qt.black )
            compass.setNeedle( new QwtDialSimpleNeedle( QwtDialSimpleNeedle.Ray,
                false, Qt.yellow ) )
            compass.setValue( 315.0 )

        QPalette newPalette = compass.palette()
        for c in range(QPalette.NColorRoles)
            colorRole = QPalette.ColorRole( c )
            if ( palette0.color( colorRole ).isValid() ):
                newPalette.setColor( colorRole, palette0.color( colorRole ) )

        for i in range(QPalette.NColorGroups):
            colorGroup = QPalette.ColorGroup( i )
            light = newPalette.color( colorGroup, QPalette.Base ).light( 170 )
            dark = newPalette.color( colorGroup, QPalette.Base ).dark( 170 )
            mid = compass.frameShadow() == QwtDial.Raised
                ? newPalette.color( colorGroup, QPalette.Base ).dark( 110 )
                : newPalette.color( colorGroup, QPalette.Base ).light( 110 )

            newPalette.setColor( colorGroup, QPalette.Dark, dark )
            newPalette.setColor( colorGroup, QPalette.Mid, mid )
            newPalette.setColor( colorGroup, QPalette.Light, light )
        compass.setPalette( newPalette )
        return compass





a = QApplication(sys.argv)
tabWidget = QTabWidget()
#tabWidget.addTab(CompassGrid,"Compass")
#tabWidget.addTab("Cockpit")
tabWidget.show()

sys.exit(a.exec_())
