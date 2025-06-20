function X = inverseMethod(A, B)
% Check if A is square and invertible
    if size(A,1) ~= size(A,2)
        error('Matrix A must be square.');
    end

    if det(A) == 0
        error('Matrix A is SINGULAR and cannot be inverted.');
    end
    % Compute solution using matrix inverse
    X = inv(A) * B;
end
