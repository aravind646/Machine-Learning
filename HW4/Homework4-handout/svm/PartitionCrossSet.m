function YcrossSetLabel = PartitionCrossSet(size,k)
numberOfSets = k;
div = size/k;
YcrossSetLabel = zeros(size,1);
current = randperm(size, size);
n = 1; start = 1;
while n <= numberOfSets
    for i = start: start + div - 1
        YcrossSetLabel(current(i)) = n;  
    end    
    start = start + div;
    n = n + 1;       
end    
end