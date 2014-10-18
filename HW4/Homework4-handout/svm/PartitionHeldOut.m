function testInstanceLabel = PartitionHeldOut(size, k)

numberOfOnes = floor(size/k);
testInstanceLabel = zeros(size,1);
current = randperm(size, numberOfOnes);

n = 1;
while n <= numberOfOnes 
    testInstanceLabel(current(n)) = 1;           
    n = n +1;       
end

end
