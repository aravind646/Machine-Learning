
% One use case of the implementation. Here we compared the training error
% and test error of non-kernel and Gaussion kernel SVM.

clear
clc
load('ps4-svm.mat')

C = 0.01;

% Linear Kernel
kernel = @(x,z) x'*z;
model_linear = svm_train(x_train, y_train, C, kernel);
pred_linear = svm_classify(model_linear, x_test);

% Gussian kernel. We can also specify the polynomial kernal here.
kernel = @(x,z) gaussian_kernel(x, z);
model_gaussian = svm_train(x_train, y_train, C, kernel);
pred_gaussian = svm_classify(model_gaussian, x_test);


% polynomial kernel.
kernel = @(x,z) polynomial_kernel(x, z);
model_polynomial = svm_train(x_train, y_train, C, kernel);
pred_polynomial = svm_classify(model_polynomial, x_test);
