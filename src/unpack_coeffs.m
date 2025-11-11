function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into named fields:
% [c, alpha(1:K), beta(1:K), a(1:N)]

    coef.c = beta(1);
    coef.alpha = beta(2:2*K+1);                   % interleaved cos-sin pairs
    coef.beta  = beta(2*K+2:3*K+1);               % adjust indexing accordingly
    coef.a     = beta(3*K+2:3*K+1+N);
    coef.d     = 0;  % dummy field for compatibility
end
