clear all;
load('data.mat'); % load filter bank
load('dictionary.mat'); % load dictionary

%path for your selected image
img_path = 'myBasilica.jpg';

%read the image
I = imread(img_path);

%extract feature points
featurePoints = extractFilterResponses(I, filterBank);
featurePoints;
[m,n] = size(featurePoints);
clusterBelonging = zeros(m,1);

for i = 1:m        
        %find the nearest clusters for each feature vector
        test_data=featurePoints(i,:);
        dist=sqrt(sum( (dictionary -  repmat(test_data,150,1)).^2, 2));        
        [M,Index] = min(dist);
        clusterBelonging(i,1)= Index;    
end

%build an "image of cluster belonging" (the segments)
imageSegments = reshape(clusterBelonging,[size(I,1) size(I,2)]);
%visualize and save the segments image
imagesc(imageSegments);
