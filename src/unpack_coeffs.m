function coef = unpack_coeffs(beta, N, K)
% UNPACK_COEFFS  Map beta into fields: c (scalar), a (Nx1), alpha (Kx1), beta (Kx1 zeros)
% We keep .beta as zeros for compatibility, but the model is cos-only.

    coef = struct();
    coef.c = beta(1);

    if N > 0
        coef.a = beta(2:1+N);
    else
        coef.a = zeros(0,1);
    end

    if K > 0
        coef.alpha = beta(1+N+1 : 1+N+K);
    else
        coef.alpha = zeros(0,1);
    end

    % No sine terms in the design; expose zeros for compatibility
    coef.beta = zeros(K,1);
end
