# import necessary modules
import numpy as np
import cv2 as cv
import matplotlib.pyplot as plt

# ----- Problem 2 ----- #
# import image 1
img1 = cv.imread('output/ps0-1-a-1.png')

# get channels from img1 and swap red and green
green = img1[:,:,1].copy()
red = img1[:,:,2].copy()

img1[:,:,1] = red
img1[:,:,2] = green

cv.imwrite('output/ps0-2-a-1.png', img1)

# write monochrome image from green channel
cv.imwrite('output/ps0-2-b-1.png', green)

# write monochrome image from red channel
cv.imwrite('output/ps0-2-c-1.png', red)

# ----- Problem 3 ----- #
# get the center of the red image
redCenter = red[207:307, 79:179]

# load image 2 and insert redCenter
img2 = cv.imread('output/ps0-1-a-2.png')
img2[79:179, 207:307, 2] = redCenter

# recreate the original image 2
cv.imwrite('output/ps0-3-a-1.png', img2)

# replace center of image 2 with white square
img2white = cv.imread('output/ps0-1-a-2.png')
img2white[79:179, 207:307] = (255, 255, 255)

cv.imwrite('output/ps0-3-b-1.png', img2white)

#----- Problem 4 ----- #
# compute and print statistical values
maxGreen = np.max(green)
minGreen = np.min(green)
meanGreen = np.mean(green)
stddevGreen = np.std(green)
'''
print('Max of Green Pixels:', maxGreen)
print('Min of Green Pixels:', minGreen)
print('Mean of Green Pixels:', meanGreen)
print('Std Dev of Green Pixels:', stddevGreen)
'''

# compute and plot the histogram
hist, bins = np.histogram(green)
plt.figure(0)
plt.title("Histogram of Green Pixel Value")
plt.bar(bins[:-1],hist,width=bins[1]-bins[0], edgecolor='darkblue')
plt.xlim([0, 255])
plt.savefig('output/ps0-4-b-1.png')

# subtract mean, divide by stddev, multiply by 10, add mean back
green = green - meanGreen
green = green / stddevGreen
green = green * 10
green = green + meanGreen

cv.imwrite('output/ps0-4-c-1.png', green)

# plot the histogram of the result
hist, bins = np.histogram(green, range=(0,255))
plt.figure(1)
plt.title("Histogram of Altered Green Pixel Value")
plt.bar(bins[:-1],hist,width=bins[1]-bins[0], color='red', edgecolor='darkred')
plt.xlim([0, 255])
plt.savefig('output/ps0-4-d-1.png')

# shift image 1's green channel to the left 2 pixels
img1green = cv.imread('output/ps0-1-a-1.png')[:, :, 1]
img1green_shift = np.roll(img1green, -2)

cv.imwrite('output/ps0-4-e-1.png', img1green_shift)

# subtract img1green_shift from img1green and save
cv.imwrite('output/ps0-4-f-1.png', img1green-img1green_shift)

#----- Problem 5 -----#
# generate noise for the image
img1_greenNoise = cv.imread('output/ps0-1-a-1.png')

sigma = 10
mean = 0
x, y, channels = img1_greenNoise.shape
noise = np.random.normal(loc=mean, scale=sigma, size=(x,y))

# add noise to the image
img1_greenNoise[:, :, 1] = img1_greenNoise[:,:,1] + noise
cv.imwrite('output/ps0-5-a-1.png', img1_greenNoise)

# plot the histogram of the noisy image
hist, bins = np.histogram(img1_greenNoise, range=(0,255))
plt.figure(2)
plt.title("Histogram of Noisy Pixel Values")
plt.bar(bins[:-1],hist,width=bins[1]-bins[0], color='green', edgecolor='black')
plt.xlim([0, 255])
plt.savefig('output/ps0-5-b-1.png')

# add the noise to the blue channel of the image instead
img1_blueNoise = cv.imread('output/ps0-1-a-1.png')
img1_blueNoise[:, :, 0] = img1_blueNoise[:, :, 0] + noise

cv.imwrite('output/ps0-5-c-1.png', img1_blueNoise)

# filter 5a using a median filter
img1_filtered = cv.medianBlur(img1_greenNoise, 5)
cv.imwrite('output/ps0-5-e-1.png', img1_filtered)

# plot the histogram of the filtered image
hist, bins = np.histogram(img1_filtered, range=(0,255))
plt.figure(3)
plt.title("Histogram of Filtered Pixel Values")
plt.bar(bins[:-1],hist,width=bins[1]-bins[0], color='green', edgecolor='black')
plt.xlim([0, 255])
plt.savefig('output/ps0-5-e-2.png')

# filter 5a using Gaussian filter
img1_gaussianFilter = cv.GaussianBlur(img1_greenNoise, (9,9), 0)
cv.imwrite('output/ps0-5-f-1.png', img1_gaussianFilter)

# plot the histogram of the filtered image
hist, bins = np.histogram(img1_gaussianFilter, range=(0,255))
plt.figure(4)
plt.title("Histogram of Filtered Red Pixel Values")
plt.bar(bins[:-1],hist,width=bins[1]-bins[0], color='orange', edgecolor='black')
plt.xlim([0, 255])
plt.savefig('output/ps0-5-f-2.png')