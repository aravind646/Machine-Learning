clear all; addpath('image');addpath('image/inst');
load('data.mat'); % load image paths and filter bank  


%--------------------------------------
%   YOUR CODE STARTS HERE
%--------------------------------------


%For each image in the dataset
for i = 1:length(imagePaths)
    
    %get the image path
    img_path = imagePaths{i};
    
    %read the image
    I = imread(img_path);
    
    %extract feature points
    featurePoints = extractFilterResponses(I, filterBank);
    
    
    %TODO: store just a random subsample of the feature points
    
end


%TODO: apply K-Means to the set of all the stored feature vectors

%TODO: Save dictionary




%--------------------------------------
%   YOUR CODE ENDS HERE
%--------------------------------------


