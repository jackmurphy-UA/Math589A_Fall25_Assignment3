function S = score_model(RSS, M, p, criterion)
    if nargin<4 || isempty(criterion), criterion = 'bic'; end
    if strcmpi(criterion,'bic')
        S = M*log(RSS/M) + p*log(M);
    else
        S = M*log(RSS/M) + 2*p;
    end
end
