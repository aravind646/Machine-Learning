clear all; addpath('image');addpath('image/inst');
load('data.mat'); % load filter bank
load('dictionary.mat'); % load dictionary

%--------------------------------------
%   YOUR CODE STARTS HERE
%--------------------------------------

%path for your selected image
img_path = 'myBasilica.jpg';

%read the image
I = imread(img_path);

%extract feature points
featurePoints = extractFilterResponses(I, filterBank);


%TODO: find the nearest clusters for each feature vector

%TODO: build an "image of cluster belonging" (the segments)

%TODO: visualize and save the segments image


%--------------------------------------
%   YOUR CODE ENDS HERE
%--------------------------------------

