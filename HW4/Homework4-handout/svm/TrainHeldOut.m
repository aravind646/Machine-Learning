function Ypredict = TrainHeldOut(Xtrain, Ytrain, testInstanceLabel)
% put this in main
%testInstanceLabel = PartitionHeldOut(100, 5); 

%Xtrain = randi([25, 35], m, 2);
%Ytrain = randi([45, 55], m, 2);

x_train = Xtrain(testInstanceLabel == 1,:);
y_train = Ytrain(testInstanceLabel == 1,:);
x_test = Xtrain(testInstanceLabel == 0,:);

model = nb_train(x_train, y_train);
Ypredict = nb_test(model, x_test);
end