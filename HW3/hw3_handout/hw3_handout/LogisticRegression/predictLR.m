function y_pred = predictLR(X, theta)
% PREDICTLR  Using fitted parameters, predict labels for data, X.
%           X      - m x n design matrix of m observations with n features.
%           theta  - (n+1) x 1 trained logistic regression parameters
%                    vector.
%
%           y_pred - predicted labels using trained model.
    
    % Predict the labels for X. Our solution is ~2 lines.
    
    %% BEGIN SOLUTION    
    [m, n] = size(X); 
    onesRow = ones(1, size(X, 1));
    X = [onesRow', X];
    y_pred = zeros(m,1);
    y_pred = (sigmoid(theta' * X') >= 0.5)';
    %% END SOLUTION
end

function y = sigmoid(x)
% SIGMOID  Computes sigmoid function, y = e^x/(1+e^x) = 1/(1+e^-x).
    y = 1./(1. + exp(-x));
end