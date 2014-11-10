
function [clusterCenters, clusterBelonging] = k_means(data, k, startPoints)
if ~exist('startPoints')
    startPoints = data(randperm(size(data,1),k),:);
end
clusterCenters = startPoints;
[m,n] = size(data);
clusterBelonging = zeros(m,1);
num_changes=m;
while num_changes>0,
    num_changes=0;
    for i = 1:m
        test_data=data(i,:);
        dist=sqrt(sum( (clusterCenters -  repmat(test_data,k,1)).^2, 2));        
        [M,I] = min(dist);
        if I ~=clusterBelonging(i,1),
            num_changes = num_changes+1;
        end
        clusterBelonging(i,1)= I;    
    end
    for i=1:size(clusterCenters,1)
        clusterCenters(i,:)=  mean(data( clusterBelonging == i,:));
    end    
end
end