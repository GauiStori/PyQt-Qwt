#!/usr/bin/python

from numpy import sin, pi , fmod
from PyQt5 import Qwt
from PyQt5.QtCore import Qt,QPointF, QMutex, QReadWriteLock,QRectF
from operator import add



class SignalData():
    def __init__(self):
        self.__d_data = self.__PrivateData()

    def size(self):
        return len(self.__d_data.values)

    def boundingRect(self):
        return self.__d_data.boundingRect

    def value(self, index ):
        return self.__d_data.values[index]

    @staticmethod
    def instance():
        valueVector = SignalData()
        return valueVector

    def lock(self):
        self.__d_data.lock.lockForRead()

    def unlock(self):
        self.__d_data.lock.unlock()

    def append(self,sample):
        self.__d_data.mutex.lock()
        self.__d_data.pendingValues.append( sample )
        
         
        isLocked = self.__d_data.lock.tryLockForWrite()
        if ( isLocked ):
            numValues = len(self.__d_data.pendingValues)
            pendingValues = self.__d_data.pendingValues
            
            for i in range(0, numValues):
                self.__d_data.append( pendingValues[i] )

            self.__d_data.pendingValues *=0

            self.__d_data.lock.unlock()
    

        self.__d_data.mutex.unlock()

    def clearStaleValues(self, limit):
        self.__d_data.lock.lockForWrite()

        self.__d_data.boundingRect = QRectF( 1.0, 1.0, -2.0, -2.0 ) 

        values = self.__d_data.values
        self.__d_data.values *=0
        
        index = 0
        
        for index in range( len(values) - 1, -1,-1):
            
            if ( values[index].x() < limit ):
                break
    

        if ( index > 0 ):
            index +=1 
            self.__d_data.append( values[index] )

        while ( index < len(values) - 1 ):
            index +=1
            self.__d_data.append( values[index] )

        self.__d_data.lock.unlock()



    def __del__(self):
        del self.__d_data


    class __PrivateData():
        boundingRect = QRectF(1.0, 1.0, -2.0, -2.0 )
        values = [] 
        pendingValues = []
        mutex = QMutex()
        lock = QReadWriteLock()
        
        
        def append(self,sample):
            self.values.append(sample)
            if (self.boundingRect.width() < 0 or self.boundingRect.height() < 0 ):
                self.boundingRect.setRect( sample.x(), sample.y(), 0.0, 0.0 )
            else:
                self.boundingRect.setRight( sample.x() )

                if ( sample.y() > self.boundingRect.bottom() ):
                    self.boundingRect.setBottom( sample.y() )

                if ( sample.y() < self.boundingRect.top() ):
                    self.boundingRect.setTop( sample.y() )
        




class SamplingThread(Qwt.QwtSamplingThread):
    def __init__(self,parent=None):
        super().__init__()
        self.__d_frequency = 5.0 
        self.__d_amplitude = 20.0 
        QwtSamplingThread = parent 
    
    def setFrequency(self,frequency ):
        self.__d_frequency = frequency

    def frequency(self):
        return self.__d_frequency
    
    def setAmplitude(self,amplitude ):
        self.__d_amplitude = amplitude


    def amplitude(self):
        return self.__d_amplitude


    def sample(self,elapsed ):
        if ( self.__d_frequency > 0.0 ):
            s = QPointF(elapsed,self.__value(elapsed))    
            SignalData.instance().append( s )
        
    def __value(self,timeStamp ):
        period = 1.0 / self.__d_frequency
        x = fmod( timeStamp, period )
        v = self.__d_amplitude * sin( x / period * 2 * pi )
        return v





