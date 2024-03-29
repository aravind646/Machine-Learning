function kernel = gaussian_kernel(x, z)
% returns a gaussian kernel matrix with gamma == 1/2 of vector x and vector z
% x and z must be in the same dimension
    % CODE BEGIN
    gamma = 1/2;
    kernel = exp(-gamma*(sum(sq(x-z))));    
    % CODE END
    