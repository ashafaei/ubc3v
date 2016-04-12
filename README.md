# UBC3V Dataset
![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/all_chars.png "UBC3V Reference Groundtruth")

UBC3V is a synthetic dataset for training and evaluation of single or multiview depth-based pose estimation techniques.
The nature of the data is similar to the data used in the famous Kinect paper of Shotton et al. [1], but with a few distinctions:

* The dataset distinguishes the back-front and left-right sides of the body.
* The camera location is relatively unconstrained.
* The dataset has three randomly located cameras for each pose, which makes it suitable for multiview pose estimation settings.
* It is freely available to the public.

In Shafaei and Little [2] we show that a convolutional neural network (CNN) trained on this dataset can effortlessly generalize to real-world depth data.
## UBC3V Toolkit
The Matlab toolkit for UBC 3 View Dataset.

## References
[1] Shotton, Jamie, et al. "Real-time human pose recognition in parts from single depth images". Communications of the ACM 56.1 (2013): 116-124.

[2] Shafaei, Alireza, Little, James J.. "Real-Time Human Motion Capture with Multiple Depth Cameras". 13th Conference on Computer and Robot Vision, 2016.