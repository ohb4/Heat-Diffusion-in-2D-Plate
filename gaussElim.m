function X = gaussElim(A, B)
 
  [n, m] = size(A);

  % Augment the matrix A with B
  Ab = [A, B];

  % Forward elimination with partial pivoting
  for k = 1:n-1
      % Find the row with the largest absolute value in the current column
      [~, maxRow] = max(abs(Ab(k:n, k)));
      maxRow = maxRow + k - 1;  % Correct the index

      % Swap the current row with the row with the largest absolute value
      if maxRow ~= k
          Ab([k, maxRow], :) = Ab([maxRow, k], :);
      end

      % Eliminate the entries below the pivot
      for i = k+1:n
          factor = Ab(i, k) / Ab(k, k);
          Ab(i, k:n+1) = Ab(i, k:n+1) - factor * Ab(k, k:n+1);
      end
  end

  % Back substitution
  X = zeros(n, 1);
  X(n) = Ab(n, n+1) / Ab(n, n);
  for i = n-1:-1:1
      X(i) = (Ab(i, n+1) - Ab(i, i+1:n) * X(i+1:n)) / Ab(i, i);
  end
end