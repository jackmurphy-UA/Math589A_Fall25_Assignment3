function S = score_model(RSS, M, p, criterion)
% SCORE_MODEL  Information criterion score (lower is better).
%   criterion: 'bic' (default) or 'aic'

    if nargin < 4 || isempty(criterion), criterion = 'bic'; end

    mse = RSS / M;  % unbiased scale in the log term
    switch lower(criterion)
        case 'bic'
            S = M*log(mse) + p*log(M);
        case 'aic'
            S = M*log(mse) + 2*p;
        otherwise
            error('Unknown criterion: %s', criterion);
    end
end
