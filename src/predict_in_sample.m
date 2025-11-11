function yhat = predict_in_sample(y, s, coef)
% PREDICT_IN_SAMPLE  In-sample predictions including linear trend term.

    y = y(:);  T = numel(y);
    N = numel(coef.a);  K = numel(coef.alpha);
    M = T - N;  yhat = zeros(M,1);

    for k = 1:M
        t = N + k;
        sea = 0;
        for h = 1:K
            sea = sea + coef.alpha(h)*cos(2*pi*h*t/s) + coef.beta(h)*sin(2*pi*h*t/s);
        end
        acc = coef.c + sea;
        for i = 1:N
            acc = acc + coef.a(i)*y(t-i);
        end
        yhat(k) = acc + coef.d*t;   % <-- trend term
    end
end
