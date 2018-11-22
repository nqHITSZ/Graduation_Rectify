import numpy as np
import cv2 as cv
import matplotlib.pyplot as plt
from PIL import Image

a=np.loadtxt('rectified_img.txt')
a=np.reshape(a,(480,-1))
cv.imwrite("test.bmp", a)