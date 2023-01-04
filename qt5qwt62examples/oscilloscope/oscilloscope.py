#!/usr/bin/python
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import Qt
from sampledata import SamplingThread
from mainwin import MainWindow
import sys



    


def main():
    app = QApplication.instance()
    def amplitudeChanged():
        samplingThread.setAmplitude(win.amplitude())
    def frequencyChanged():
        samplingThread.setFrequency(win.frequency())
    def signalIntervalChanged():
        samplingThread.setInterval( win.signalInterval() )
        

    if app == None:
        app = QApplication(sys.argv)
        app.setStyleSheet( open('osci.css').read())
        win = MainWindow()
        

        win.resize( 800, 400 )
        samplingThread = SamplingThread()
        samplingThread.setFrequency( win.frequency() )
        samplingThread.setAmplitude( win.amplitude() )
        samplingThread.setInterval( win.signalInterval() )

        win.frequencyChanged.connect(frequencyChanged)
        
                
        win.amplitudeChanged.connect(amplitudeChanged)

       
        win.signalIntervalChanged.connect(signalIntervalChanged)

        win.show()

        samplingThread.start()
        win.start()

        ok = app.exec();

        samplingThread.stop()
        samplingThread.wait( 1000 )

    
        

if __name__ == '__main__':
    main()    
    



