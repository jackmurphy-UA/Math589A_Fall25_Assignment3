function best = select_model(y, s, Ngrid, Kgrid, criterion)
% SELECT_MODEL  Grid-search over N and K with AIC/BIC scoring.
% Handles RSS ~ 0 (noiseless) and tie-breaking.

    if nargin < 5 || isempty(criterion)
        criterion = 'bic';
    end

    best = struct('score', Inf, 'N', NaN, 'K', NaN, 'coef', [], ...
                  'RSS', [], 'M', [], 'p', [], 's', s, 'criterion', criterion);

    TOL_RSS   = 1e-12;
    TOL_SCORE = 1e-12;

    for N = Ngrid(:).'
        for K = Kgrid(:).'
            try
                fit = fit_once(y, s, N, K);
            catch
                continue
            end

            if fit.RSS <= TOL_RSS
                if strcmpi(criterion,'bic')
                    S_eff = fit.p * log(fit.M);
                else
                    S_eff = 2 * fit.p;
                end
            else
                S_eff = score_model(fit.RSS, fit.M, fit.p, criterion);
            end

            do_update = false;
            if S_eff < best.score - TOL_SCORE
                do_update = true;
            elseif abs(S_eff - best.score) <= TOL_SCORE
                if isempty(best.p) || fit.p < best.p
                    do_update = true;
                elseif fit.p == best.p
                    if isnan(best.N) || N < best.N || (N == best.N && K < best.K)
                        do_update = true;
                    end
                end
            end

            if do_update
                best = fit;
                best.score = S_eff;
                best.criterion = criterion;
            end
        end
    end
end
