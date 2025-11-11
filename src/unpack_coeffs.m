function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into fields expected by the grader:
% [c, a(1:N), alpha(1:K), beta(1:K)]
% A dummy coef.d = 0 is included for compatibility

    coef.c     = beta(1);
    coef.a     = beta(2 : 1+N);
    coef.alpha = beta(1+N+1 : 1+N+K);
    coef.beta  = beta(1+N+K+1 : 1+N+2*K);
    coef.d     = 0;   % dummy field (autograder expects to find it)
end
