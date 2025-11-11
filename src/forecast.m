function yF = forecast(y, s, coef, H)
% FORECAST  H-step-ahead recursive forecast from fitted coefficients.
%   yF is Hx1

    y = y(:); 
    T = numel(y); 
    N = numel(coef.a); 
    K = numel(coef.alpha);

    yF = zeros(H,1);

    for h = 1:H
        t = T + h;

        sea = 0;
        for k = 1:K
            sea = sea + coef.alpha(k)*cos(2*pi*k*t/s) + coef.beta(k)*sin(2*pi*k*t/s);
        end

        acc = coef.c + sea;

        for i = 1:N
            if h - i <= 0
                acc = acc + coef.a(i)*y(T-(i-1));
            else
                acc = acc + coef.a(i)*yF(h-i);
            end
        end

        yF(h) = acc;
    end
end
