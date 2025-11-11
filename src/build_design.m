function [A,b,meta] = build_design(y, s, N, K)
% BUILD_DESIGN  Construct LS system for N-lag + K cosine harmonics (cos-only).
%   y : Tx1 double (column), s : season, N : AR order, K : #harmonics
% Returns:
%   A : (T-N) x (1+N+K)  columns = [1, lags..., cos(2π*t/s), ..., cos(2π*K*t/s)]
%   b : (T-N) x 1        targets  = y(N+1:T)
%   meta : struct with .rows, .p, .t

    y = y(:);
    T = numel(y);
    M = T - N;
    p = 1 + N + K;

    if M <= p
        error('Underdetermined: T-N (= %d) must exceed p (= %d).', M, p);
    end

    b = y(N+1:T);
    A = ones(M, p);

    col = 1;

    % lag columns
    for i = 1:N
        col = col + 1;
        A(:, col) = y(N+1-i : T-i);
    end

    t = (N+1:T).';

    % cosine columns (cos-only)
    for k = 1:K
        col = col + 1;
        A(:, col) = cos(2*pi*k*t/s);
    end

    meta = struct('rows', M, 'p', p, 't', t);
end
