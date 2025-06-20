function [PointDB, A, B] = steadyStateEq(topT, bottomT, leftT, rightT, L, N)

    % Calculate total number of points Nodes^2
    Points=N^2;

    % Grid spacing
    dx = L / (N - 1);

    % Initialize outputs
    A = sparse(Points, Points);  % Use sparse for efficiency
    B = zeros(Points, 1);
    PointDB = zeros(Points, 3); % [index, x, y]

    % Loop over each grid point
    for j = 1:N  % y-direction
        for i = 1:N  % x-direction
            idx = (j-1)*N + i;  % Point number in 1D
            x = (i-1) * dx;
            y = (j-1) * dx; %dx since its same as dy since its square

            % Store point data
            PointDB(idx, :) = [idx, x, y];

            % Check if the point is on the boundary
            if i == 1
                % Left boundary
                A(idx, idx) = 1;
                B(idx) = leftT;
            elseif i == N
                % Right boundary
                A(idx, idx) = 1;
                B(idx) = rightT;
            elseif j == 1
                % Bottom boundary
                A(idx, idx) = 1;
                B(idx) = bottomT;
            elseif j == N
                % Top boundary
                A(idx, idx) = 1;
                B(idx) = topT;
            else
                % Interior point: 5-point Laplacian stencil
                A(idx, idx) = -4;
                A(idx, idx - 1) = 1;     % left neighbor
                A(idx, idx + 1) = 1;     % right neighbor
                A(idx, idx - N) = 1;     % bottom neighbor
                A(idx, idx + N) = 1;     % top neighbor
                % B(idx) remains zero
            end
        end
    end
end