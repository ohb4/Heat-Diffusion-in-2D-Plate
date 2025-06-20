function [X, relErr, avgErr, iterations] = gaussSeidel(A, B, tol, maxIter)
    n = length(B);
    X = zeros(n, 1);
    relErr = zeros(n, 1);
    
    % Check for zero diagonal elements
    if any(diag(A) == 0)
        error('Matrix has zero(s) on the diagonal. Gauss-Seidel cannot proceed.');
    end

    % Improved diagonal dominance check
    isDiagDominant = all(abs(diag(A)) > sum(abs(A), 2) - abs(diag(A)));
    if isDiagDominant
        lamda = 1.2; % over-relaxation
        fprintf('Matrix is diagonally dominant: using over-relaxation (w = %.2f)\n', lamda);
    else
        lamda = 0.8; % under-relaxation
        fprintf('Matrix is not diagonally dominant: using under-relaxation (w = %.2f)\n', lamda);
    end

    for iterations = 1:maxIter
        X_old = X;
        for i = 1:n
            sum1 = A(i, 1:i-1) * X(1:i-1);
            sum2 = A(i, i+1:n) * X_old(i+1:n);
            x_new = (B(i) - sum1 - sum2) / A(i, i);
            X(i) = lamda * x_new + (1 - lamda) * X_old(i);
        end
        
        % Relative error check
        relErr = abs((X - X_old) ./ (X + eps));
        avgErr = mean(relErr) * 100;

        if all(relErr < tol)
            break;
        end
    end
end
