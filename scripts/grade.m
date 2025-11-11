function [best, yhat, mse, yF] = grade
% scripts/grade.m  -- compact, parseable output for autograder
% NOTE: This is an example how your code will be called when autograding.
% Make sure that all functions called in this script are defined and
% have the correct semantics.
    addpath(fullfile('..','src'));
    y = readmatrix(fullfile('..','data','y_example.csv'));
    s = 12; Ngrid = 0:10; Kgrid = 0:3; criterion = 'bic';
    best = select_model(y, s, Ngrid, Kgrid, criterion);
    yhat = predict_in_sample(y, s, best.coef);
    H = 12; yF = forecast(y, s, best.coef, H);

    fprintf('BEST_N=%d\n', best.N);
    fprintf('BEST_K=%d\n', best.K);
    mse = mean((y(best.N+1:end)-yhat).^2);
    fprintf('MSE=%.6f\n', mse);
    fprintf('F1=%.6f\n', yF(1));
    fprintf('F12=%.6f\n', yF(12));
end
