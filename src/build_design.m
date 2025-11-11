function [A,b,meta] = build_design(y, s, N, K)
% BUILD_DESIGN  Construct LS system for N-th order difference eq + K harmonics.
%   y : Tx1 double (column)
%   s : scalar season (e.g., 12)
%   N : nonnegative integer (order of past)
%   K : nonnegative integer (# harmonics)
% Returns:
%   A : (T-N)x(1+N+2K) matrix  [1, cos..., sin..., lags...]
%   b : (T-N)x1 vector         [y_{N+1: T}]
%   meta : struct with fields: .rows=M, .p=p, .t=(N+1:T).'

    y = y(:);
    T = numel(y);
    M = T - N;
    p = 1 + N + 2*K;

    if M < p
        error('Underdetermined: T-N (= %d) must exceed p (= %d).', M, p);
    end

    b = y(N+1:T);
    t = (N+1:T).';

    A = ones(M, p);
    col = 1;

    % --- cosine columns ---
    for k = 1:K
        col = col + 1;
        A(:, col) = cos(2*pi*k*t/s);
    end

    % --- sine columns ---
    for k = 1:K
        col = col + 1;
        A(:, col) = sin(2*pi*k*t/s);
    end

    % --- lag columns ---
    for i = 1:N
        col = col + 1;
        A(:, col) = y(N+1-i : T-i);
    end

    meta = struct('rows', M, 'p', p, 't', t);
end
