function [Accuracy, lowerInterval, upperInterval] = ConstructInterval(Ypredict,Ytest,confLevel)

corrects = Ypredict == Ytest;
Accuracy = mean(corrects);

Z = 0.0;
if confLevel == 0.99
    Z = 2.576;
elseif confLevel == 0.95
        Z = 1.960;
end
n = max(size(Ytest));
t1 = ((Accuracy * (1 - Accuracy))/n);
accuracyHypothesis = Z * (sqrt(t1));
lowerInterval = Accuracy - accuracyHypothesis;
upperInterval = Accuracy + accuracyHypothesis;
end