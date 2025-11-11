function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into named fields for convenience.

    coef = struct();
    coef.c = beta(1);

    if N > 0
        coef.a = beta(2:1+N);
    else
        coef.a = zeros(0,1);
    end

    if K > 0
        coef.alpha = beta(1+N+1 : 1+N+K);
        coef.beta  = beta(1+N+K+1 : 1+N+2*K);
    else
        coef.alpha = zeros(0,1);
        coef.beta  = zeros(0,1);
    end
end
