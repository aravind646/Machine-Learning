function [accuracy] = nb_run(Xtrain, Ytrain,Xtest,Ytest)
    model = nb_train(Xtrain, Ytrain);
    Pred_nb = nb_test(model, Xtest);
    save('Pred_nb.mat','Pred_nb');
    accuracy = mean(Pred_nb==Ytest);
end