function x = qr_solve_dense(A,b)
% QR_SOLVE_DENSE  Solve min ||A*x - b||_2 using explicit Householder QR.
%   No backslash, pinv, chol, svd, regress, fitlm, arima, etc.

    [m,n] = size(A);
    R = A; 
    y = b;

    for k = 1:min(m,n)
        v = R(k:end,k);
        sigma = norm(v);
        if sigma == 0
            % Column already zero below diagonal; skip
            continue;
        end
        % Choose alpha to avoid cancellation
        if v(1) >= 0
            alpha = -sigma;
        else
            alpha = sigma;
        end
        v(1) = v(1) - alpha;
        beta = (v.'*v);            % = ||v||^2
        if beta == 0
            continue;
        end
        tau = 2 / beta;

        % Apply reflector to R(k:end,k:end)
        R(k:end,k:end) = R(k:end,k:end) - (tau * (v * (v.' * R(k:end,k:end))));

        % Apply reflector to y(k:end)
        y(k:end)       = y(k:end)  - (tau * (v * (v.' * y(k:end))));

        % Impose exact zeros under diagonal for numerical cleanliness
        R(k+1:end,k) = 0;
        R(k,k) = alpha;
    end

    % Extract the top triangular part for square solve
    rdim = min(n,m);
    Rtri = triu(R(1:rdim,1:n));

    % If m >= n and Rtri(1:n,1:n) nonsingular, do back substitution
    x = zeros(n,1);
    nn = min(n,rdim);
    Rt = Rtri(1:nn,1:nn);
    yt = y(1:nn);

    % Back substitution
    for i = nn:-1:1
        x(i) = (yt(i) - Rt(i,i+1:end)*x(i+1:end)) / Rt(i,i);
    end
end
