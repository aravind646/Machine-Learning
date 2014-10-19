
% One use case of the implementation. Here we compared the training error
% and test error of non-kernel and Gaussion kernel SVM.

clear
clc
load('ps4-svm.mat')

C = 0.01;
x_combined = cat(1, x_train, x_test);
y_combined = cat(1, y_train, y_test);

% Linear Kernel

kernel = @(x,z) x'*z;
model_linear = svm_train(x_train, y_train, C, kernel);
pred_linear = svm_classify(model_linear, x_test);


% START Q.2.3
C = [0, 0.1, 0.3, 0.5, 1, 2, 5, 8, 10];
% model_linear = svm_train(x_combined, y_combined, C, kernel);
crossSetLabel = PartitionCrossSet(200, 4);
u = unique(crossSetLabel(:,1));
[m,n] = size(u);
[mc, nc] = size(C);
for cIndex = 1:1
    Ypredict = zeros(size(y_combined));
    train_error = 0;
    for index = 1:m
        value = u(index);
        x_test = x_combined(crossSetLabel == value,:);  
        x_train = x_combined(crossSetLabel ~= value,:);  
        y_train = y_combined(crossSetLabel ~= value,:);  
        model_linear = svm_train(x_train, y_train, C(cIndex), kernel);    
        Ypredict(crossSetLabel == value,:) = svm_classify(model_linear, x_test);    
        y_train_pred= svm_classify(model_linear, x_train);
        train_error = train_error + mean(y_train_pred ~= y_train);
    end
    mean_train_error = train_error/m;
    corrects = Ypredict ~= y_combined;
    test_error = mean(corrects);
    fprintf('%.2f', C(cIndex));
    fprintf('\t%.5f',  mean_train_error);
    fprintf('\t%.5f \n',  test_error);    
    cIndex= cIndex +1;
end


% END Q.2. 

% START Q.2nd 
%model = nb_train(x_train_combined, y_train_combined);
%Ypredict = nb_test(model, x_test_combined);

C = 0.5;
model_linear = svm_train(x_combined, y_combined, C, kernel);

testInstanceLabel = PartitionHeldOut(200, 2); 
x_train_combined = x_combined(testInstanceLabel == 1,:);
y_train_combined = y_combined(testInstanceLabel == 1,:);
x_test_combined = x_combined(testInstanceLabel == 0,:);
y_test_combined = y_combined(testInstanceLabel == 0,:);

pred_linear = svm_classify(model_linear, x_test_combined);
[a, l, h] = ConstructInterval(pred_linear, y_test_combined, .95)
[a, l, h] = ConstructInterval(pred_linear, y_test_combined, .99)

k11 =111
testInstanceLabel = PartitionHeldOut(200, 10); 
x_train_combined = x_combined(testInstanceLabel == 1,:);
y_train_combined = y_combined(testInstanceLabel == 1,:);
x_test_combined = x_combined(testInstanceLabel == 0,:);
y_test_combined = y_combined(testInstanceLabel == 0,:);

pred_linear = svm_classify(model_linear, x_test_combined);
[a, l, h] = ConstructInterval(pred_linear, y_test_combined, .95)
[a, l, h] = ConstructInterval(pred_linear, y_test_combined, .99)


% END Q.2nd 
% Gussian kernel. We can also specify the polynomial kernal here.
kernel = @(x,z) gaussian_kernel(x, z);
model_gaussian = svm_train(x_train, y_train, C, kernel);
pred_gaussian = svm_classify(model_gaussian, x_test);


% polynomial kernel.
kernel = @(x,z) polynomial_kernel(x, z)
model_polynomial = svm_train(x_train, y_train, C, kernel);
pred_polynomial = svm_classify(model_polynomial, x_test);
[a, l, h] = ConstructInterval(pred_polynomial, y_test, 99);
