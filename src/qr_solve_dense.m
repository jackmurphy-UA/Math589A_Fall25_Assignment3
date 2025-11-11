function x = qr_solve_dense(A,b)
% QR_SOLVE_DENSE  Solve min ||A*x - b||_2 using explicit Householder QR.
%   No backslash, pinv, chol, svd, regress, fitlm, arima, etc.
%
%   Inputs:
%       A : m x n matrix (full rank assumed)
%       b : m x 1 vector
%   Output:
%       x : n x 1 least-squares solution

    [m,n] = size(A);
    R = A; 
    y = b;

    % --- Householder QR factorization ---
    for k = 1:n
        v = R(k:end,k);
        alpha = -sign(v(1)) * norm(v);
        if alpha == 0
            continue
        end
        v(1) = v(1) - alpha;
        v = v / norm(v);
        R(k:end,k:end) = R(k:end,k:end) - 2 * v * (v.' * R(k:end,k:end));
        y(k:end)       = y(k:end)       - 2 * v * (v.' * y(k:end));
    end

    % Upper triangular part
    R = triu(R(1:n,1:n));

    % --- Normalize to ensure positive diagonal entries (deterministic signs) ---
    for j = 1:n
        if R(j,j) < 0
            R(:,j) = -R(:,j);
            y(j)   = -y(j);
        end
    end

    % --- Back substitution ---
    x = zeros(n,1);
    for i = n:-1:1
        x(i) = (y(i) - R(i,i+1:end) * x(i+1:end)) / R(i,i);
    end
end
