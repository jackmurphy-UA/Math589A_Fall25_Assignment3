function best = select_model(y, s, Ngrid, Kgrid, criterion)
% SELECT_MODEL  Grid-search over N and K with AIC/BIC scoring.

    best = struct('score', Inf, 'N', NaN, 'K', NaN, 'coef', [], ...
                  'RSS', [], 'M', [], 'p', [], 's', s, 'criterion', criterion);

    for N = Ngrid(:).'
        for K = Kgrid(:).'
            try
                fit = fit_once(y, s, N, K);
            catch
                % Under/ill-determined combos are skipped
                continue
            end
            S = score_model(fit.RSS, fit.M, fit.p, criterion);
            if S < best.score
                best = fit;
                best.score = S;
                best.criterion = criterion;
            end
        end
    end
end
