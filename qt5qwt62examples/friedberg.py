#!/usr/bin/python

# python simpleplot.py <qtversion (4 or 5)>
# Tested for python3 Qt5

import sys
#import Qwt
from PyQt5 import Qwt
import numpy as np
from PyQt5.QtCore import Qt,  QSize,  QTime,  QObject, QPointF
from PyQt5.QtGui import QBrush, QPen, QColor, QPalette
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QComboBox, QSizePolicy, QToolButton, QToolBar

class Temperature:
    def __init__(self, minValue, maxValue, averageValue):
        self.minValue = minValue
        self.maxValue = maxValue
        self.averageValue = averageValue

friedberg2007 = [
    Temperature( 2.6, 9.8, 7.07862 ),	# 01.01
    Temperature( 0.8, 5.8, 3.6993 ),	# 02.01
    Temperature( 2, 7, 5.02388 ),	# 03.01
    Temperature( 5.3, 7.8, 6.37778 ),	# 04.01
    Temperature( 5.6, 7.7, 6.83149 ),	# 05.01
    Temperature( 7.2, 8.9, 8.0816 ),	# 06.01
    Temperature( 4.2, 9.9, 7.54704 ),	# 07.01
    Temperature( 3.5, 8.9, 6.71951 ),	# 08.01
    Temperature( 8.2, 12.9, 10.8594 ),	# 09.01
    Temperature( 6.3, 11.9, 9.76424 ),	# 10.01
    Temperature( 3.9, 9.2, 6.18223 ),	# 11.01
    Temperature( 6.9, 9.7, 8.44236 ),	# 12.01
    Temperature( 9, 12.3, 10.6649 ),	# 13.01
    Temperature( 1.8, 10.8, 7.23438 ),	# 14.01
    Temperature( -2.8, 1.8, -0.518403 ),	# 15.01
    Temperature( -0.6, 4.5, 2.39479 ),	# 16.01
    Temperature( 4.3, 10.2, 7.23472 ),	# 17.01
    Temperature( 9.1, 13.6, 10.9316 ),	# 18.01
    Temperature( 6.9, 12.4, 9.4128 ),	# 19.01
    Temperature( 7.1, 13.3, 10.5083 ),	# 20.01
    Temperature( 3.5, 9.6, 6.10871 ),	# 21.01
    Temperature( -1.8, 6, 2.89028 ),	# 22.01
    Temperature( -5.4, 1.7, -2.46678 ),	# 23.01
    Temperature( -5.3, -1.3, -3.71483 ),	# 24.01
    Temperature( -7.5, 3.3, -3.36736 ),	# 25.01
    Temperature( -11.1, 0.3, -5.50662 ),	# 26.01
    Temperature( 0.2, 3.2, 1.95345 ),	# 27.01
    Temperature( 1.9, 5.2, 3.43633 ),	# 28.01
    Temperature( 4.4, 9.1, 6.24236 ),	# 29.01
    Temperature( 2.3, 11.5, 6.03114 ),	# 30.01
    Temperature( 4.6, 10.2, 6.04192 ),	# 31.01

    Temperature( 4.8, 13.8, 7.87674 ),	# 01.02
    Temperature( 5.7, 10, 7.28646 ),	# 02.02
    Temperature( 2.9, 8.2, 5.71771 ),	# 03.02
    Temperature( -1.5, 7.2, 4.71319 ),	# 04.02
    Temperature( -2.6, 4.4, 1.23542 ),	# 05.02
    Temperature( 0.3, 9.2, 2.59965 ),	# 06.02
    Temperature( -0.4, 2.4, 0.641667 ),	# 07.02
    Temperature( -1.7, 3.8, 0.811458 ),	# 08.02
    Temperature( 0.7, 7, 3.58328 ),	# 09.02
    Temperature( 1, 6, 3.51181 ),	# 10.02
    Temperature( 4.7, 9.6, 6.14913 ),	# 11.02
    Temperature( 5.3, 8.7, 6.80552 ),	# 12.02
    Temperature( 4.4, 10.3, 6.84552 ),	# 13.02
    Temperature( 2.6, 6.5, 4.58681 ),	# 14.02
    Temperature( -0.8, 13.4, 6.38542 ),	# 15.02
    Temperature( -3, 14.4, 4.11336 ),	# 16.02
    Temperature( 0.5, 13, 5.87457 ),	# 17.02
    Temperature( -2.2, 14.1, 4.36528 ),	# 18.02
    Temperature( 3.9, 5.6, 4.63737 ),	# 19.02
    Temperature( -0.4, 9.2, 4.37014 ),	# 20.02
    Temperature( -1.9, 5.5, 1.85675 ),	# 21.02
    Temperature( 1, 13.1, 5.41176 ),	# 22.02
    Temperature( 1.9, 13.9, 7.74251 ),	# 23.02
    Temperature( 3.8, 9.6, 7.19306 ),	# 24.02
    Temperature( 5.8, 10.8, 7.80312 ),	# 25.02
    Temperature( 5.2, 10.4, 6.79481 ),	# 26.02
    Temperature( 3.2, 7.4, 5.22986 ),	# 27.02
    Temperature( 6.4, 13.4, 9.13356 ),	# 28.02

    Temperature( 4.6, 11.4, 7.70554 ),	# 01.03
    Temperature( 3.4, 10.9, 5.98408 ),	# 02.03
    Temperature( 2.9, 10.5, 5.45675 ),	# 03.03
    Temperature( -0.7, 16.8, 7.29585 ),	# 04.03
    Temperature( 4.2, 13.4, 8.35862 ),	# 05.03
    Temperature( 3, 13, 7.76644 ),	# 06.03
    Temperature( 2, 13.3, 8.24618 ),	# 07.03
    Temperature( -0.8, 15, 6.11765 ),	# 08.03
    Temperature( -0.7, 11, 5.7568 ),	# 09.03
    Temperature( 1.2, 14.4, 6.61389 ),	# 10.03
    Temperature( -1.7, 18, 6.66146 ),	# 11.03
    Temperature( -0.6, 21.9, 8.9816 ),	# 12.03
    Temperature( -0.9, 19.6, 9.08299 ),	# 13.03
    Temperature( 5.3, 18.9, 10.5562 ),	# 14.03
    Temperature( 2, 20.5, 9.65156 ),	# 15.03
    Temperature( 0.2, 16.7, 7.8699 ),	# 16.03
    Temperature( 4.5, 10.6, 7.87535 ),	# 17.03
    Temperature( 2.7, 9.7, 6.71806 ),	# 18.03
    Temperature( 0.4, 10.9, 3.92404 ),	# 19.03
    Temperature( -2, 12.7, 4.01359 ),	# 20.03
    Temperature( 0.3, 6.8, 3.00382 ),	# 21.03
    Temperature( 0.9, 4.2, 2.2816 ),	# 22.03
    Temperature( 2, 5.7, 3.39233 ),	# 23.03
    Temperature( 3.9, 9.3, 6.41076 ),	# 24.03
    Temperature( 4.2, 19.1, 9.92182 ),	# 25.03
    Temperature( 2.3, 22, 12.5716 ),	# 26.03
    Temperature( 4.9, 20.6, 13.4568 ),	# 27.03
    Temperature( 0.3, 22.8, 10.755 ),	# 28.03
    Temperature( 1.8, 17.2, 9.43924 ),	# 29.03
    Temperature( 1.9, 19.8, 10.25 ),	# 30.03
    Temperature( 6.7, 17, 11.1324 ),	# 31.03

    Temperature( 5.7, 22, 12.8457 ),	# 01.04
    Temperature( 6.4, 22.1, 13.3847 ),	# 02.04
    Temperature( 5.8, 17.5, 10.5614 ),	# 03.04
    Temperature( 2.8, 16.2, 8.06574 ),	# 04.04
    Temperature( -0.6, 20.8, 9.18062 ),	# 05.04
    Temperature( 2.1, 24, 13.0069 ),	# 06.04
    Temperature( 5.3, 16.2, 10.2771 ),	# 07.04
    Temperature( 0.1, 20.7, 9.79861 ),	# 08.04
    Temperature( 0.3, 18.9, 10.0087 ),	# 09.04
    Temperature( 4, 16.4, 11.4208 ),	# 10.04
    Temperature( 2.3, 23.4, 13.083 ),	# 11.04
    Temperature( 7, 29.4, 16.5826 ),	# 12.04
    Temperature( 10.6, 31.5, 19.2249 ),	# 13.04
    Temperature( 11.8, 34, 21.441 ),	# 14.04
    Temperature( 11.6, 33.8, 21.0201 ),	# 15.04
    Temperature( 8.7, 31.1, 18.7885 ),	# 16.04
    Temperature( 5.5, 27.2, 16.1432 ),	# 17.04
    Temperature( 6.1, 17.2, 10.6688 ),	# 18.04
    Temperature( -0.6, 21.3, 10.4806 ),	# 19.04
    Temperature( 5.9, 21.6, 12.6257 ),	# 20.04
    Temperature( 2.1, 21.6, 11.0858 ),	# 21.04
    Temperature( 3.9, 25.9, 14.2108 ),	# 22.04
    Temperature( 3.1, 27.8, 15.7111 ),	# 23.04
    Temperature( 13.7, 29, 19.6397 ),	# 24.04
    Temperature( 9.8, 31.6, 19.601 ),	# 25.04
    Temperature( 8.2, 32.4, 20.0389 ),	# 26.04
    Temperature( 11.8, 32.1, 21.0726 ),	# 27.04
    Temperature( 12.6, 33.3, 21.6993 ),	# 28.04
    Temperature( 10.5, 27.4, 19.1206 ),	# 29.04
    Temperature( 5.3, 26.4, 15.0972 ),	# 30.04

    Temperature( 6.9, 25.3, 15.2802 ),	# 01.05
    Temperature( 4.3, 26.2, 14.8401 ),	# 02.05
    Temperature( 7.1, 28.5, 17.2145 ),	# 03.05
    Temperature( 11, 28.5, 18.537 ),	# 04.05
    Temperature( 12, 28, 18.1672 ),	# 05.05
    Temperature( 10.4, 29, 18.3844 ),	# 06.05
    Temperature( 13, 18.1, 15.0028 ),	# 07.05
    Temperature( 10.7, 18.3, 13.2014 ),	# 08.05
    Temperature( 10.8, 14.4, 12.5208 ),	# 09.05
    Temperature( 11.9, 23.5, 16.9632 ),	# 10.05
    Temperature( 9.8, 16.9, 15.0795 ),	# 11.05
    Temperature( 9.2, 19.6, 13.8521 ),	# 12.05
    Temperature( 8.9, 26.3, 16.2028 ),	# 13.05
    Temperature( 11.1, 17.5, 13.2934 ),	# 14.05
    Temperature( 6.5, 17, 11.7743 ),	# 15.05
    Temperature( 4.9, 13.6, 9.75625 ),	# 16.05
    Temperature( 6.8, 16.6, 9.96701 ),	# 17.05
    Temperature( 2.4, 21.2, 11.4311 ),	# 18.05
    Temperature( 8.2, 24.4, 15.4188 ),	# 19.05
    Temperature( 14.1, 31.7, 21.3303 ),	# 20.05
    Temperature( 11, 30.9, 21.5359 ),	# 21.05
    Temperature( 13.8, 31, 21.5177 ),	# 22.05
    Temperature( 16, 27.8, 21.0271 ),	# 23.05
    Temperature( 15, 34, 23.4142 ),	# 24.05
    Temperature( 14.3, 31.8, 22.8903 ),	# 25.05
    Temperature( 13.6, 33.1, 22.6156 ),	# 26.05
    Temperature( 11.2, 23.4, 16.6192 ),	# 27.05
    Temperature( 9.6, 13.1, 11.3222 ),	# 28.05
    Temperature( 8.3, 11.2, 10.3529 ),	# 29.05
    Temperature( 4.2, 20.8, 12.6218 ),	# 30.05
    Temperature( 9.2, 23.6, 15.1073 ),	# 31.05

    Temperature( 10.8, 24.4, 16.3205 ),	# 01.06
    Temperature( 13, 26.5, 18.9649 ),	# 02.06
    Temperature( 14, 25.1, 18.5398 ),	# 03.06
    Temperature( 13, 28, 20.2139 ),	# 04.06
    Temperature( 14, 28.8, 20.438 ),	# 05.06
    Temperature( 14, 30.4, 21.7821 ),	# 06.06
    Temperature( 17, 34.8, 25.3087 ),	# 07.06
    Temperature( 17.9, 35.7, 25.7872 ),	# 08.06
    Temperature( 17.8, 31.6, 22.0788 ),	# 09.06
    Temperature( 15.5, 33.4, 22.4458 ),	# 10.06
    Temperature( 16.6, 28.3, 19.8797 ),	# 11.06
    Temperature( 14, 27.3, 20.2566 ),	# 12.06
    Temperature( 13.2, 28.2, 19.4233 ),	# 13.06
    Temperature( 12.7, 30, 20.1427 ),	# 14.06
    Temperature( 15.2, 22.6, 18.5917 ),	# 15.06
    Temperature( 13.2, 24, 17.7014 ),	# 16.06
    Temperature( 11.7, 27.9, 19.8229 ),	# 17.06
    Temperature( 15.9, 27.2, 20.3358 ),	# 18.06
    Temperature( 12.6, 33.7, 22.2427 ),	# 19.06
    Temperature( 15.7, 30.8, 23.7507 ),	# 20.06
    Temperature( 14.8, 22.6, 18.2538 ),	# 21.06
    Temperature( 12.4, 21.3, 15.9969 ),	# 22.06
    Temperature( 12.6, 21.6, 15.8149 ),	# 23.06
    Temperature( 13, 26, 18.4176 ),	# 24.06
    Temperature( 12.9, 24.4, 17.1299 ),	# 25.06
    Temperature( 10.8, 18.8, 13.2913 ),	# 26.06
    Temperature( 9.9, 18.8, 13.5465 ),	# 27.06
    Temperature( 12, 19.8, 14.8434 ),	# 28.06
    Temperature( 12, 19, 15.155 ),	# 29.06
    Temperature( 12.4, 22.4, 17.1354 ),	# 30.06

    Temperature( 12.1, 24.9, 19.1639 ),	# 01.07
    Temperature( 15.7, 24.3, 18.4554 ),	# 02.07
    Temperature( 12.7, 17.2, 14.6564 ),	# 03.07
    Temperature( 11.2, 19, 13.9529 ),	# 04.07
    Temperature( 11.5, 19, 14.6422 ),	# 05.07
    Temperature( 12.4, 22, 16.6146 ),	# 06.07
    Temperature( 11.6, 24, 17.666 ),	# 07.07
    Temperature( 9, 28, 19.1351 ),	# 08.07
    Temperature( 11.3, 21.5, 16.5271 ),	# 09.07
    Temperature( 11.3, 20.2, 14.2326 ),	# 10.07
    Temperature( 10.2, 19.2, 14.0649 ),	# 11.07
    Temperature( 13.2, 23.1, 16.6346 ),	# 12.07
    Temperature( 15, 27, 19.6844 ),	# 13.07
    Temperature( 13.4, 32.4, 23.845 ),	# 14.07
    Temperature( 15, 38.2, 26.8559 ),	# 15.07
    Temperature( 16.1, 36.5, 26.4483 ),	# 16.07
    Temperature( 19.7, 30.5, 24.189 ),	# 17.07
    Temperature( 14.2, 29.3, 22.1363 ),	# 18.07
    Temperature( 16.4, 25.9, 19.0819 ),	# 19.07
    Temperature( 16.2, 30.8, 22.151 ),	# 20.07
    Temperature( 14, 24.3, 18.6573 ),	# 21.07
    Temperature( 13.2, 24.5, 18.3301 ),	# 22.07
    Temperature( 10.6, 23.4, 16.6903 ),	# 23.07
    Temperature( 13.2, 20.8, 16.2743 ),	# 24.07
    Temperature( 12.2, 25.8, 18.8267 ),	# 25.07
    Temperature( 11.9, 28.9, 20.5522 ),	# 26.07
    Temperature( 17.6, 25.8, 21.5691 ),	# 27.07
    Temperature( 16.6, 24.6, 19.2295 ),	# 28.07
    Temperature( 13, 19, 15.9021 ),	# 29.07
    Temperature( 9.6, 19.7, 13.875 ),	# 30.07
    Temperature( 8, 22, 14.5284 ),	# 31.07

    Temperature( 7.6, 27.5, 17.5684 ),	# 01.08
    Temperature( 9.2, 22.2, 16.1035 ),	# 02.08
    Temperature( 12.7, 25.3, 18.2958 ),	# 03.08
    Temperature( 8.6, 31.3, 19.7941 ),	# 04.08
    Temperature( 10.3, 32.7, 21.492 ),	# 05.08
    Temperature( 10, 33.4, 22.4431 ),	# 06.08
    Temperature( 16.8, 22.6, 19.5583 ),	# 07.08
    Temperature( 13.5, 16.7, 15.0264 ),	# 08.08
    Temperature( 13.2, 18.8, 15.6003 ),	# 09.08
    Temperature( 14.6, 27.9, 18.8292 ),	# 10.08
    Temperature( 16.3, 26.4, 20.3837 ),	# 11.08
    Temperature( 12.1, 28.7, 19.9892 ),	# 12.08
    Temperature( 15, 27.4, 19.7542 ),	# 13.08
    Temperature( 11.3, 28.3, 20.5656 ),	# 14.08
    Temperature( 18.6, 28.4, 23.1215 ),	# 15.08
    Temperature( 16, 23.6, 19.491 ),	# 16.08
    Temperature( 12.6, 22, 17.0437 ),	# 17.08
    Temperature( 8.5, 25.7, 16.5589 ),	# 18.08
    Temperature( 13.4, 25.8, 18.0543 ),	# 19.08
    Temperature( 10.9, 21.5, 16.1306 ),	# 20.08
    Temperature( 10.6, 19.2, 14.6177 ),	# 21.08
    Temperature( 14, 24.6, 17.3841 ),	# 22.08
    Temperature( 13.8, 30.4, 20.6125 ),	# 23.08
    Temperature( 12.3, 30.3, 20.7622 ),	# 24.08
    Temperature( 12.8, 30.2, 21.6736 ),	# 25.08
    Temperature( 15, 29.3, 21.266 ),	# 26.08
    Temperature( 12.9, 25.9, 18.791 ),	# 27.08
    Temperature( 9.3, 24.6, 16.2833 ),	# 28.08
    Temperature( 10.8, 25, 16.8459 ),	# 29.08
    Temperature( 8.2, 24.4, 15.9267 ),	# 30.08
    Temperature( 14.1, 20.5, 16.6128 ),	# 31.08

    Temperature( 13.4, 21.9, 16.2205 ),	# 01.09
    Temperature( 12, 20.7, 16.0882 ),	# 02.09
    Temperature( 10.8, 21.3, 14.7913 ),	# 03.09
    Temperature( 7.8, 18.2, 12.2747 ),	# 04.09
    Temperature( 8.1, 22.2, 12.9406 ),	# 05.09
    Temperature( 10, 23.8, 13.8785 ),	# 06.09
    Temperature( 10.7, 21.2, 15.4823 ),	# 07.09
    Temperature( 12.4, 21, 15.8194 ),	# 08.09
    Temperature( 12.7, 16.9, 14.7212 ),	# 09.09
    Temperature( 10.3, 17.7, 12.9271 ),	# 10.09
    Temperature( 10.6, 20.8, 14.4788 ),	# 11.09
    Temperature( 10.8, 21.9, 15.0184 ),	# 12.09
    Temperature( 6.9, 24.6, 14.5222 ),	# 13.09
    Temperature( 8.1, 24, 15.6583 ),	# 14.09
    Temperature( 8.8, 22.8, 15.941 ),	# 15.09
    Temperature( 3.1, 24.5, 14.1486 ),	# 16.09
    Temperature( 12.4, 21.2, 16.0497 ),	# 17.09
    Temperature( 7.8, 16.1, 12.024 ),	# 18.09
    Temperature( 5.3, 18.1, 10.3003 ),	# 19.09
    Temperature( 6.4, 20.3, 12.3177 ),	# 20.09
    Temperature( 6, 23.8, 13.6247 ),	# 21.09
    Temperature( 5.7, 27, 14.6847 ),	# 22.09
    Temperature( 7.8, 28, 16.6238 ),	# 23.09
    Temperature( 9.6, 24.9, 16.7191 ),	# 24.09
    Temperature( 8.4, 17.6, 12.636 ),	# 25.09
    Temperature( 4.3, 18.9, 10.0809 ),	# 26.09
    Temperature( 9.4, 11.2, 10.3344 ),	# 27.09
    Temperature( 7.7, 12.6, 10.5337 ),	# 28.09
    Temperature( 9.8, 15.3, 11.9306 ),	# 29.09
    Temperature( 9.6, 21.1, 13.6635 ),	# 30.09

    Temperature( 8.9, 24.5, 14.8163 ),	# 01.10
    Temperature( 13.5, 20.2, 16.1628 ),	# 02.10
    Temperature( 12.5, 18, 15.4691 ),	# 03.10
    Temperature( 13.8, 25, 17.2073 ),	# 04.10
    Temperature( 9.1, 23.2, 14.6181 ),	# 05.10
    Temperature( 6.4, 23.4, 12.8625 ),	# 06.10
    Temperature( 4.6, 22.1, 11.0052 ),	# 07.10
    Temperature( 2, 22.2, 10.1677 ),	# 08.10
    Temperature( 7.8, 21.6, 12.2139 ),	# 09.10
    Temperature( 7.1, 22.7, 13.0115 ),	# 10.10
    Temperature( 6.1, 21.2, 11.4333 ),	# 11.10
    Temperature( 4.3, 15.2, 10.6104 ),	# 12.10
    Temperature( 5.8, 23, 12.8875 ),	# 13.10
    Temperature( 1, 23, 9.72986 ),	# 14.10
    Temperature( 1, 19.3, 9.33021 ),	# 15.10
    Temperature( 8.5, 20.4, 13.2639 ),	# 16.10
    Temperature( 6.8, 17.3, 11.8174 ),	# 17.10
    Temperature( 5.2, 15.6, 9.06076 ),	# 18.10
    Temperature( 2.7, 13.5, 7.1309 ),	# 19.10
    Temperature( -0.2, 15.8, 6.01667 ),	# 20.10
    Temperature( 2.6, 6.1, 4.9441 ),	# 21.10
    Temperature( -0.8, 13.2, 4.50694 ),	# 22.10
    Temperature( -0.4, 13.3, 4.71007 ),	# 23.10
    Temperature( 2.9, 8.1, 5.96979 ),	# 24.10
    Temperature( 6.3, 10.5, 8.01206 ),	# 25.10
    Temperature( 7, 10.8, 8.14965 ),	# 26.10
    Temperature( 6.6, 9.7, 7.7809 ),	# 27.10
    Temperature( 1.7, 10.8, 6.95728 ),	# 28.10
    Temperature( 2.2, 9.9, 6.62917 ),	# 29.10
    Temperature( 5.8, 15, 8.76181 ),	# 30.10
    Temperature( 0.7, 15, 6.01528 ),	# 31.10

    Temperature( -0.2, 9.7, 3.75842 ),	# 01.11
    Temperature( 6.4, 9.6, 8.00138 ),	# 02.11
    Temperature( 8.7, 13.1, 10.5676 ),	# 03.11
    Temperature( 8, 11.8, 9.54306 ),	# 04.11
    Temperature( 5.8, 15.9, 8.52345 ),	# 05.11
    Temperature( 5.5, 10.8, 7.16493 ),	# 06.11
    Temperature( 5.5, 8.9, 7.30172 ),	# 07.11
    Temperature( 7, 11.7, 8.96701 ),	# 08.11
    Temperature( 2.5, 8.4, 4.86528 ),	# 09.11
    Temperature( 3.7, 9, 5.20828 ),	# 10.11
    Temperature( 2.8, 10.6, 6.80756 ),	# 11.11
    Temperature( 2.7, 9.5, 5.07647 ),	# 12.11
    Temperature( 0.1, 5.4, 3.3945 ),	# 13.11
    Temperature( -0.7, 7.9, 2.02234 ),	# 14.11
    Temperature( -1.8, 6.5, 1.07778 ),	# 15.11
    Temperature( -4.4, 5.1, -0.693772 ),	# 16.11
    Temperature( -0.3, 3.4, 1.33229 ),	# 17.11
    Temperature( -0.4, 4.3, 2.4622 ),	# 18.11
    Temperature( 1.8, 3.6, 2.78282 ),	# 19.11
    Temperature( 1.3, 5.6, 2.95979 ),	# 20.11
    Temperature( 1.6, 5.7, 3.62284 ),	# 21.11
    Temperature( 3.1, 7.3, 5.60277 ),	# 22.11
    Temperature( 4.2, 7.7, 6.28166 ),	# 23.11
    Temperature( -0.5, 11.5, 3.25931 ),	# 24.11
    Temperature( -1, 8.8, 2.86505 ),	# 25.11
    Temperature( 1.2, 6.8, 3.09414 ),	# 26.11
    Temperature( -0.8, 7.5, 3.17805 ),	# 27.11
    Temperature( -2.8, 3.1, -0.920139 ),	# 28.11
    Temperature( -2.6, 1.7, -0.491696 ),	# 29.11
    Temperature( 1.3, 6.5, 3.85 ),	# 30.11

    Temperature( 4.1, 8.7, 5.88924 ),	# 01.12
    Temperature( 4.8, 9, 6.81667 ),	# 02.12
    Temperature( 3.5, 8.5, 6.23633 ),	# 03.12
    Temperature( 2.7, 6.6, 4.63045 ),	# 04.12
    Temperature( 4.3, 8.6, 6.85993 ),	# 05.12
    Temperature( 5.5, 9.3, 7.79201 ),	# 06.12
    Temperature( 3.1, 13.4, 8.79444 ),	# 07.12
    Temperature( 2.6, 6.3, 4.67093 ),	# 08.12
    Temperature( 3, 10.4, 5.75724 ),	# 09.12
    Temperature( 4.1, 6.8, 5.31834 ),	# 10.12
    Temperature( 4.1, 7.4, 5.28993 ),	# 11.12
    Temperature( 3.9, 6.4, 4.64479 ),	# 12.12
    Temperature( 1.7, 9.1, 4.15363 ),	# 13.12
    Temperature( 0.4, 1.8, 0.934602 ),	# 14.12
    Temperature( -4.5, 2.1, -1.17292 ),	# 15.12
    Temperature( -5, 4.8, -2.17431 ),	# 16.12
    Temperature( -5.6, 6.1, -1.35448 ),	# 17.12
    Temperature( -4.9, 6.4, -1.25502 ),	# 18.12
    Temperature( -4.4, 6.6, -1.02396 ),	# 19.12
    Temperature( -7.3, 5.2, -2.63854 ),	# 20.12
    Temperature( -8.5, 5.7, -3.58333 ),	# 21.12
    Temperature( -7.9, -5.3, -6.13438 ),	# 22.12
    Temperature( -6.1, -4.4, -5.23472 ),	# 23.12
    Temperature( -4.6, -3.3, -3.84291 ),	# 24.12
    Temperature( -4.9, -2.8, -3.9066 ),	# 25.12
    Temperature( -4.7, -1.9, -3.10379 ),	# 26.12
    Temperature( -1.9, -0.2, -0.679791 ),	# 27.12
    Temperature( -1.8, 0.5, -0.521875 ),	# 28.12
    Temperature( -2.2, 2.3, -0.430796 ),	# 29.12
    Temperature( 0.9, 5.2, 2.83437 ),	# 30.12
    Temperature( -1, 8.3, 2.27093 )	# 31.12
    ]

class Grid(Qwt.QwtPlotGrid):
    def __init__(self):
        enableXMin( True )
        setMajorPen( Qt.white, 0, Qt.DotLine )
        setMinorPen( Qt.gray, 0, Qt.DotLine )

    def updateScaleDiv( xScaleDiv, yScaleDiv ):
        scaleDiv = QwtScaleDiv( xScaleDiv.lowerBound(),
            xScaleDiv.upperBound() )

        scaleDiv.setTicks( QwtScaleDiv.MinorTick,
            xScaleDiv.ticks( QwtScaleDiv.MinorTick ) )

        scaleDiv.setTicks( QwtScaleDiv.MajorTick,
                xScaleDiv.ticks( QwtScaleDiv.MediumTick ) )

        Qwt.QwtPlotGrid.updateScaleDiv( scaleDiv, yScaleDiv )

class YearScaleDraw(Qwt.QwtScaleDraw):
    def __init__(self):
        setTickLength( QwtScaleDiv.MajorTick, 0 )
        setTickLength( QwtScaleDiv.MinorTick, 0 )
        setTickLength( QwtScaleDiv.MediumTick, 6 )

        setLabelRotation( -60.0 )
        setLabelAlignment( Qt.AlignLeft | Qt.AlignVCenter )

        setSpacing( 15 )

    def label( value ):
        month = int( value / 30 ) + 1
        return QLocale.system().monthName( month, QLocale.LongFormat )

class Plot( Qwt.QwtPlot ):
    def __init__(self, parent = None):
        super().__init__()
        self.setObjectName( "FriedbergPlot" )
        self.setTitle( "Temperature of Friedberg/Germany" )

        self.setAxisTitle( Qwt.QwtPlot.xBottom, "2007" )
        #self.setAxisScaleDiv( Qwt.QwtPlot.xBottom, yearScaleDiv() )
        #self.setAxisScaleDraw( Qwt.QwtPlot.xBottom, YearScaleDraw() )
        self.setAxisTitle( Qwt.QwtPlot.yLeft, "Temperature [%1C]"  )

        canvas = Qwt.QwtPlotCanvas()
        canvas.setPalette( QPalette( QColor( Qt.darkGray ) ) )
        canvas.setBorderRadius( 10 )

        self.setCanvas( canvas )

        # grid
        self.grid = Qwt.QwtPlotGrid()
        self.grid.attach( self )
        self.legend = Qwt.QwtLegend()
        self.insertLegend( self.legend, Qwt.QwtPlot.RightLegend )

        numDays = 365
        averageData = []
        rangeData = []
        #QVector< QwtIntervalSample > rangeData( numDays )

        for i in range(len(friedberg2007)):
            t = friedberg2007[i]
            averageData.append(QPointF( float( i ), t.averageValue ))
            rangeData.append(Qwt.QwtIntervalSample( float( i ),Qwt.QwtInterval( t.minValue, t.maxValue ) ))

        self.insertCurve( "Average", averageData, Qt.black )
        self.insertErrorBars( "Range", rangeData, Qt.blue )
        """
            LeftButton for the zooming
            MidButton for the panning
            RightButton: zoom out by 1
            Ctrl+RighButton: zoom out to full size
        """
        self.zoomer = Qwt.QwtPlotZoomer( canvas )
        self.zoomer.setRubberBandPen( QColor( Qt.black ) )
        self.zoomer.setTrackerPen( QColor( Qt.black ) )
        self.zoomer.setMousePattern( Qwt.QwtEventPattern.MouseSelect2,
            Qt.RightButton, Qt.ControlModifier )
        self.zoomer.setMousePattern( Qwt.QwtEventPattern.MouseSelect3,
            Qt.RightButton )

        self.panner = Qwt.QwtPlotPanner( canvas )
        self.panner.setMouseButton( Qt.MiddleButton )

    def yearScaleDiv(self):
        days = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
        mediumTicks =[0.0]
        for i in range(0,len(days)):
            mediumTicks.append(mediumTicks[i] + days[i])

        minorTicks =[]
        for i in range( 1, 366, 7 ):
            minorTicks.append(i)

        majorTicks = []
        for i in range(12):
            majorTicks.append(i * 30 + 15)

        scaleDiv= QwtScaleDiv( mediumTicks[0], mediumTicks[-1] + 1,
            minorTicks, mediumTicks, majorTicks )
        return scaleDiv

    def insertCurve(self, title, samples, color ):
        self.m_curve = Qwt.QwtPlotCurve( title )
        self.m_curve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.m_curve.setStyle( Qwt.QwtPlotCurve.NoCurve )
        self.m_curve.setLegendAttribute( Qwt.QwtPlotCurve.LegendShowSymbol )

        self.symbol = Qwt.QwtSymbol( Qwt.QwtSymbol.XCross )
        self.symbol.setSize( 4 )
        self.symbol.setPen( color )
        self.m_curve.setSymbol( self.symbol )
        self.m_curve.setSamples( samples )
        self.m_curve.attach( self )

    def insertErrorBars(self, title, samples, color ):
        self.m_intervalCurve = Qwt.QwtPlotIntervalCurve( title )
        self.m_intervalCurve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased )
        self.m_intervalCurve.setPen( Qt.white )

        bg = QColor( color )
        bg.setAlpha( 150 )
        self.m_intervalCurve.setBrush( QBrush( bg ) )
        self.m_intervalCurve.setStyle( Qwt.QwtPlotIntervalCurve.Tube )

        self.m_intervalCurve.setSamples( samples )
        self.m_intervalCurve.attach( self )

    def setMode( self, style ):
        if ( style == 1 ): #Tube
            self.m_intervalCurve.setStyle( Qwt.QwtPlotIntervalCurve.Tube )
            #self.m_intervalCurve.setSymbol( 0 )
            self.m_intervalCurve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased, True )
        else:
            self.m_intervalCurve.setStyle( Qwt.QwtPlotIntervalCurve.NoCurve )

            c = QColor( self.m_intervalCurve.brush().color().rgb() ) # skip alpha

            self.errorBar = Qwt.QwtIntervalSymbol( Qwt.QwtIntervalSymbol.Bar )
            self.errorBar.setWidth( 8 ) # should be something even
            self.errorBar.setPen( c )

            self.m_intervalCurve.setSymbol( self.errorBar )
            self.m_intervalCurve.setRenderHint( Qwt.QwtPlotItem.RenderAntialiased, False )
        self.replot()

    def exportPlot():
        renderer = Qwt.QwtPlotRenderer()
        renderer.exportTo( self, "friedberg.pdf" )


class MainWindow(QMainWindow):
    def __init__(self, parent = None):
        super().__init__()
        self.plot = Plot()
        self.setCentralWidget( self.plot )

        self.typeBox = QComboBox()
        self.typeBox.addItem( "Bars" )
        self.typeBox.addItem( "Tube" )
        self.typeBox.setCurrentIndex( 1 )
        self.typeBox.setSizePolicy( QSizePolicy.Fixed, QSizePolicy.Fixed )

        btnExport = QToolButton()
        btnExport.setText( "Export" )
        btnExport.setToolButtonStyle( Qt.ToolButtonTextUnderIcon )
        #connect( btnExport, SIGNAL(clicked()), plot, SLOT(exportPlot()) )

        toolBar = QToolBar()
        toolBar.addWidget( self.typeBox )
        toolBar.addWidget( btnExport )
        self.addToolBar( toolBar )

        self.plot.setMode( self.typeBox.currentIndex() )

        self.typeBox.currentIndexChanged['int'].connect(self.plot.setMode )

if __name__=="__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.setObjectName( "MainWindow" )
    window.resize( 600, 400 )
    window.show()
    sys.exit(app.exec_())
