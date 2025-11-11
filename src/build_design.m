function [A,b,meta] = build_design(y, s, N, K)
% BUILD_DESIGN  LS system for N-th order difference eq + K harmonics + linear trend.
% A row order: [1, t, y_{t-1},..., y_{t-N}, cos(...),..., sin(...)]
% Returns:
%   A : (T-N) x (2+N+2K)
%   b : (T-N) x 1   with b = y(N+1:T)
%   meta.rows = M, meta.p = 2+N+2K, meta.t = (N+1:T)'

    y = y(:);
    T = numel(y);
    M = T - N;
    p = 2 + N + 2*K;

    if M < p
        error('Underdetermined: T-N (= %d) must exceed p (= %d).', M, p);
    end

    b = y(N+1:T);
    t = (N+1:T).';                 % use actual time indices

    A = ones(M, p);
    A(:,2) = t;                    % trend column

    col = 2;

    % lag columns: y_{t-1},...,y_{t-N}
    for i = 1:N
        col = col + 1;
        A(:, col) = y(N+1-i : T-i);
    end

    % cosine columns: k = 1..K
    for k = 1:K
        col = col + 1;
        A(:, col) = cos(2*pi*k*t/s);
    end

    % sine columns: k = 1..K
    for k = 1:K
        col = col + 1;
        A(:, col) = sin(2*pi*k*t/s);
    end

    meta = struct('rows', M, 'p', p, 't', t);
end
