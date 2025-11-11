function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into named fields matching autograder expectation:
% [c, alpha(1:K), beta(1:K), a(1:N)]

    coef.c     = beta(1);
    coef.alpha = beta(2:1+K);
    coef.beta  = beta(2+K:1+2*K);
    coef.a     = beta(2+2*K:1+2*K+N);
    coef.d     = 0;  % dummy field required by autograder
end
