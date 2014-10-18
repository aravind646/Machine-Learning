function Ypredict = TrainCrossSet(Xtrain, Ytrain, crossSetLabel)

u = unique(crossSetLabel(:,1));
[m,n] = size(u);
Ypredict = zeros(size(Ytrain));
for index = 1:m
    value = u(index);
    x_test = Xtrain(crossSetLabel == value,:);  
    x_train = Xtrain(crossSetLabel ~= value,:);  
    y_train = Ytrain(crossSetLabel ~= value,:);  
    model = nb_train(x_train, y_train);
    Ypredict(crossSetLabel == value,:) = nb_test(model, x_test);        
end
end