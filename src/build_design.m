function [A,b,meta] = build_design(y, s, N, K)
% BUILD_DESIGN  Construct LS system for N-th order difference eq + K harmonics + linear trend.
%   Adds both a constant and a time-trend column.

    y = y(:);  T = numel(y);
    M = T - N;
    p = 2 + N + 2*K;   % constant + trend + N lags + 2K harmonics

    if M < p
        error('Underdetermined: T-N (= %d) must exceed p (= %d).', M, p);
    end

    b = y(N+1:T);
    t = (N+1:T).';
    A = ones(M, p);
    A(:,2) = t;   % time-trend column

    col = 2;
    % lag columns
    for i = 1:N
        col = col + 1;
        A(:, col) = y(N+1-i : T-i);
    end

    % cosine columns
    for k = 1:K
        col = col + 1;
        A(:, col) = cos(2*pi*k*t/s);
    end
    % sine columns
    for k = 1:K
        col = col + 1;
        A(:, col) = sin(2*pi*k*t/s);
    end

    meta = struct('rows',M,'p',p,'t',t);
end
