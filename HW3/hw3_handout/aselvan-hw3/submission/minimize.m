function theta = minimize(f, init_theta)
% MINIMIZE  Find a local minima of a function f, starting at init_theta.
%          f - function to be minimized. f should be of the form:
%              [cost, grad(, hess)] = f(theta)
    tol = 1e-5; % you should stop optimization when the absolute difference
                % in cost between two iterations is less than tol.
                
    maxIter = 1000; % you should alternatively break after maxIter.
    alpha = 0.1;
    alpha_decay = 0.998;
    % Write your solution below. You should use either gradient descent or
    % Newton-Raphson to find the (local) minimum of the function.
    % Our solution is ~10 lines
    %% BEGIN SOLUTION (GRADIENT DESCENT)        
    oldTheta = init_theta;
    [cost, grad] = f(init_theta);
    oldCost = cost;    
    for i = 2:maxIter               
        theta = oldTheta;
        oldTheta = oldTheta - (alpha * grad);
        [cost, grad] = f(oldTheta);
        newCost = cost; 
        if (abs(oldCost - newCost) < tol)            
            break        
        end
        oldCost = newCost;        
        alpha = alpha * alpha_decay;
    end
    %% END SOLUTION
end
