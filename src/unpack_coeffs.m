function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into named fields matching autograder expectation:
% [c, d, a(1:N), alpha(1:K), beta(1:K)]

    coef.c = beta(1);
    coef.d = beta(2);
    coef.a = beta(3:2+N);
    coef.alpha = beta(2+N+1 : 2+N+K);
    coef.beta  = beta(2+N+K+1 : 2+N+2*K);
end
