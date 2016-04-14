# UBC3V Dataset
![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/all_chars.png "UBC3V Reference Groundtruth")

UBC3V is a synthetic dataset for training and evaluation of single or multiview depth-based pose estimation techniques.
The nature of the data is similar to the data used in the famous Kinect paper of Shotton et al. [1], but with a few distinctions:

* The dataset distinguishes the back-front and left-right sides of the body.
* The camera location is relatively unconstrained.
* The dataset has three randomly located cameras for each pose, which makes it suitable for multiview pose estimation settings.
* It is freely available to the public.

In Shafaei and Little [2] we show that a convolutional neural network (CNN) trained on this dataset can effortlessly generalize to real-world depth data.

## Sub-datasets
The UBC3V dataset consists of three sub-datasets:

| Subset        | Postures            | #Characters  | Samples |
| ------------- |:-------------------:|:------------:|:-------:|
| easy-pose     | simple (~10k)       | 1            | 1 m     |
| inter-pose    | all (100k)          | 1            | 1.3 m   |
| hard-pose     | all (100k)          | 16           | 300 k   |

The easy-pose, as the name indicates, is an easy sub-problem with a limited set of postures (mostly walking and running) and only one character.
The inter-pose includes all the postures, but with only one character. Finally, hard-pose includes all the postures and the above 16 characters.
The progression in the dataset difficulty is particularly useful for curriculum learning [3] applications.

<center>
![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/samples.png "Samples")
</center>

## Dataset Structure
Each sub-dataset has its own *train*, *valid*, and *test* set, therefore, it is organized into three folders:

* sub-dataset
	* train
	* valid
	* test

Furthermore, each *train*, *valid*, or *test* splits the data into **n** sections (n varies). So the tuple ('easy-pose', 'train', 12), refers to the section *12* of the *train* set of the *easy-pose* dataset. Each section is organized as follows:

* Section i
	* groundtruth.mat
	* images
		* depthRender
			* Cam 1
			* Cam 2
			* Cam 3
		* groundtruth
			* Cam 1
			* Cam 2
			* Cam 3

Each section has a `groundtruth.mat` file that contains the **posture** and the **extrinsic camera parameters** for the images. Note that the intrinsic camera parameters of our dataset is identical to that of `Kinect 2` depth camera.
If you don't care about the multiview feature of this dataset, you can just treat each camera as independent samples.

In the next section we show how you can use this toolkit to:

* Easily access the data.
* Generate point cloud from the depth image.
* Use the extrinsic camera parameters to merge the generated point clouds from different viewpoints.
* Draw the posture in the reference coordinate space.
* Generate a groundtruth class image to feed to a CNN.

## UBC3V Toolkit
The Matlab toolkit for UBC 3 View Dataset facilitates data access and use in Matlab. Grab a copy of this project and navigate to the root folder in Matlab.
Run `init` to initialize the script.

### UBC3V Configuration
The `config.m` script contains the parameters that you need to set before you can use UBC3V Toolkit.

1. `easy_pose_path` must be set to the root folder of the *easy-pose* dataset.
2. `inter_pose_path` must be set to the root folder of the *inter-pose* dataset.
3. `hard_pose_path` must be set to the root folder of the *hard-pose* dataset.

Don't forget to add the trailing `/` in the paths. Now you're ready to use the toolkit.

### Demo
The script `demo_render.m` is a good starting point to learn to use the toolkit. This script reads a sample from the *easy-pose* dataset and visualizes the merged colored point-cloud. The output figures should look like this:

![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/sample_cameras.png "Samples per camera")

![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/sample_merged-2.png "Samples merged")
![alt text](https://raw.githubusercontent.com/ashafaei/ubc3v/master/metadata/sample_merged.png "Samples merged colored")

### Useful functions

* ```matlab
load_multicam('easy-pose', 'train', 150, 1:10);
```

## References
1. Shotton, Jamie, et al. "Real-time human pose recognition in parts from single depth images". Communications of the ACM 56.1 (2013): 116-124.
2. Shafaei, Alireza, Little, James J.. "Real-Time Human Motion Capture with Multiple Depth Cameras". 13th Conference on Computer and Robot Vision, 2016.
3. Bengio, Yoshua, et al. "Curriculum learning." Proceedings of the 26th annual international conference on machine learning. ACM, 2009.