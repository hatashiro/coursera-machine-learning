%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Load from ex5data1: 
% You will have X, y, Xval, yval, Xtest, ytest in your environment
load ('ex5data1.mat');

% m = Number of examples
m = size(X, 1);

p = 8;

% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
X_poly_val = polyFeatures(Xval, p);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones

%% === Part 10: Plotting learning curves with randomly selected examples ==

repeat = 10;
lambda = 0.01;

% Number of training examples
m = size(X_poly, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

for r = 1:repeat
    for i = 1:m
        trainRows = randperm(m, i);
        Xtrain_rand = X_poly(trainRows, :);
        ytrain_rand = y(trainRows);
        valRows = randperm(m, i);
        Xval_rand = X_poly_val(valRows, :);
        yval_rand = yval(valRows);

        theta = trainLinearReg(Xtrain_rand, ytrain_rand, lambda);

        error_train(i) = error_train(i) + linearRegCostFunction(Xtrain_rand, ytrain_rand, theta, 0);
        error_val(i) = error_val(i) + linearRegCostFunction(Xval_rand, yval_rand, theta, 0);
    end
end

error_train = error_train ./ repeat;
error_val = error_val ./ repeat;

figure(1);
plot(1:m, error_train, 1:m, error_val);

title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 100])
legend('Train', 'Cross Validation')

fprintf('Program paused. Press enter to continue.\n');
pause;
