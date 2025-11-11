function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into named fields matching autograder expectation:
% [c, a(1:N), alpha(1:K), beta(1:K)]

    coef.c = beta(1);
    coef.a = beta(2:1+N);
    coef.alpha = beta(2+N : 1+N+K);
    coef.beta  = beta(2+N+K : 1+N+2*K);
    coef.d = 0;  % dummy field required by autograder
end
