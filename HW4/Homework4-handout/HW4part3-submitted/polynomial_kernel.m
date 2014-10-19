function kernel = polynomial_kernel( x, z )
% returns a polynomial kernel matrix with d = 2
   % CODE BEGIN
   d = 2;
   kernel = ((x' * z) + 1)^d; 
   % CODE END
 end    