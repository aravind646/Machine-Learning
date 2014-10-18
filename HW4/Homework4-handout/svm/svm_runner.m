
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
%[a, l, h] = ConstructInterval(pred_linear, y_combined, .99)

testInstanceLabel = PartitionHeldOut(200, 10); 
x_train_combined = x_combined(testInstanceLabel == 1,:);
y_train_combined = y_combined(testInstanceLabel == 1,:);
x_test_combined = x_combined(testInstanceLabel == 0,:);
y_test_combined = y_combined(testInstanceLabel == 0,:);

pred_linear = svm_classify(model_linear, x_test_combined);
[a, l, h] = ConstructInterval(pred_linear, y_test_combined, .99)


% END Q.2nd 
% Gussian kernel. We can also specify the polynomial kernal here.
kernel = @(x,z) gaussian_kernel(x, z);
model_gaussian = svm_train(x_train, y_train, C, kernel);
pred_gaussian = svm_classify(model_gaussian, x_test);


% polynomial kernel.
kernel = @(x,z) polynomial_kernel(x, z);
model_polynomial = svm_train(x_train, y_train, C, kernel);
pred_polynomial = svm_classify(model_polynomial, x_test);
%[a, l, h] = ConstructInterval(pred_polynomial, y_test, 99);
