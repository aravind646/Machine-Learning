function [cost, grad] = costNN(X, y, theta, opt)
% costNN  Neural network cost function.
%
% function [cost, grad] = costNN(X, y, theta, opt)
%
%   X     - m x n design matrix of m data points.
%   y     - k x m labels.
%   theta - flattened parameters for NN.
%   opt   - Struct must contain:
%          lambda        - regularization strength
%          hidden_sizes  - vector of number of units in each hidden layer. 
%                          In the case of a single hidden layer NN this 
%                          will be a scalar.
%
%   cost - cost at theta
%   grad - gradient at theta. i.e. [dJ/dx1, ..., dJ/dxp]'
%
    visible_size = size(X, 2);
    hidden_size = opt.hidden_sizes;
    output_size = size(y, 1);
    
    n_layers = length(opt.hidden_sizes) + 1;

    all_layer_sizes = [visible_size; opt.hidden_sizes; output_size];
    
    [Ws, bs] = unflattenParameters(theta, all_layer_sizes);
    
    % You may find the following variables helpful.
    
    W1 = Ws{1}; % weights from layer 1 to layer 2.
    W2 = Ws{2}; % weights from layer 2 to layer 3.
    b1 = bs{1}; % biases to layer 2.
    b2 = bs{2}; % biases to layer 3.
    
    W1grad = zeros(hidden_size, visible_size);
    W2grad = zeros(output_size, hidden_size);
    b1grad = zeros(hidden_size, 1);
    b2grad = zeros(output_size, 1);
    
    Wgrads = cell(n_layers, 1); % Wgrads{i} = Wigrad
    bgrads = cell(n_layers, 1); % bgrads{i} = bigrad
    
    % in the case of single hidden layer NN.
    %      layer 1 = input layer
    %      layer 2 = hidden layer
    %      layer 3 = output layer
    
    %% Write your code below to compute the cost and gradients.
    % our solution is ~14 lines. You may assume that the NN has a single
    % hidden layer.

    cost = 0;
    
    %% BEGIN SOLUTION
    [act, a2, a3, W1, W2] = nnComputeActivations(theta, X, output_size, opt);
    cost = opt.lambda/2 * (sum(sumsq(W1)) + sum(sumsq(W2))) + 1/2 * (sum(sumsq(act - y)));
    delta3 = (act' - y') .* a3 .* (1 - a3);
    delta2 = (delta3 * W2) .* a2 .* (1 -  a2);
    W1grad = opt.lambda * W1 + (delta2' * X);
    W2grad = opt.lambda * W2 + (delta3' * a2);
    b1grad = sum(delta2, 1)';
    b2grad = sum(delta3, 1)';
    %% END SOLUTION
    
    Wgrads{1} = W1grad;
    Wgrads{2} = W2grad;
    bgrads{1} = b1grad;
    bgrads{2} = b2grad;
    
    grad = flattenParameters(Wgrads, bgrads);
    
end

function y = sigmoid(x)
    y = 1 ./ (1. + exp(-x));
end
