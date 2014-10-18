function Ypredict = TrainHeldOut(Xtrain, Ytrain, testInstanceLabel)

x_train = Xtrain(testInstanceLabel == 0,:);
y_train = Ytrain(testInstanceLabel == 0,:);
x_test = Xtrain(testInstanceLabel == 1,:);

model = nb_train(x_train, y_train);
Ypredict = nb_test(model, x_test);

end