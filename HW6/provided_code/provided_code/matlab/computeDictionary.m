clear all;
load('data.mat'); % load image paths and filter bank  

v=[];
%For each image in the dataset
for i = 1:length(imagePaths)    
    %get the image path
    img_path = imagePaths{i};
    
    %read the image
    I = imread(img_path);
    
    %extract feature points
    featurePoints = extractFilterResponses(I, filterBank);    
    s = size(featurePoints,1);
    v = [v;featurePoints(randperm(s,ceil(s/100)),:)];    
end

[dictionary, clusterBelonging] = k_means(v, 150);
save('dictionary.mat', 'dictionary');
