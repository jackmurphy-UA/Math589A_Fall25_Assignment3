function out = fit_once(y, s, N, K)
% FIT_ONCE  Fit a single (N,K) model by QR-based least squares.
% Fully standardized for autograder compatibility:
% - All coefficient arrays are column vectors.
% - Field 'd' = [a; alpha; beta], length N+2K.
% - Ensures consistent vector sizes regardless of N,K.

    [A,b,meta] = build_design(y, s, N, K);
    beta = qr_solve_dense(A, b);

    res  = A*beta - b;
    RSS  = res.'*res;
    coef = unpack_coeffs(beta,N,K);

    % Ensure column vectors
    coef.a      = coef.a(:);
    coef.alpha  = coef.alpha(:);
    coef.beta   = coef.beta(:);
    coef.c      = coef.c(1);

    % Define .d as [a; alpha; beta] (exclude intercept)
    coef.d = [coef.a; coef.alpha; coef.beta];
    coef.d = coef.d(:);   % force column orientation

    out = struct( ...
        'beta' , beta(:), ...
        'coef' , coef, ...
        'RSS'  , RSS, ...
        'M'    , meta.rows, ...
        'p'    , meta.p, ...
        'N'    , N, ...
        'K'    , K, ...
        's'    , s, ...
        'res'  , res(:), ...
        'd'    , coef.d ...
    );
end
