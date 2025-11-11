function best = select_model(y, s, Ngrid, Kgrid, criterion)
    if nargin < 5 || isempty(criterion), criterion = 'bic'; end

    best = struct('score', Inf, 'N', NaN, 'K', NaN, 'coef', [], ...
                  'RSS', [], 'M', [], 'p', [], 's', s, 'criterion', criterion);
    TOL_RSS = 1e-12; TOL_S = 1e-12;

    for N = Ngrid(:).'
        for K = Kgrid(:).'
            try
                fit = fit_once(y, s, N, K);
            catch
                continue
            end
            if fit.RSS <= TOL_RSS
                S = strcmpi(criterion,'bic') * (fit.p*log(fit.M)) + ...
                    strcmpi(criterion,'aic') * (2*fit.p);
                if S==0, S = fit.p*log(fit.M); end  % default to BIC penalty
            else
                S = score_model(fit.RSS, fit.M, fit.p, criterion);
            end
            if S < best.score - TOL_S || (abs(S-best.score)<=TOL_S && fit.p < best.p)
                best = fit; best.score = S; best.criterion = criterion;
            end
        end
    end
end
