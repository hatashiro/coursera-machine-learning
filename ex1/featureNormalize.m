function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each\and each row is an example. You need 
%               to perform the normalization separately for 
%   ture. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

mu = mean(X, 1);
sigma = std(X, 0, 1);
X_norm = (X - mu) ./ sigma;

% ============================================================

end
