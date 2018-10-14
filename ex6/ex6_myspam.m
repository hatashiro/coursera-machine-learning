clear; close all; clc

load mailData;
addpath lib/libsvm/matlab;

model = svmtrain(y, X, '-q -t 0');
[p, acc, prb] = svmpredict(ycv, Xcv, model, '-q');

fprintf("Accuracy on CV: %.2f\n", acc(1));

% Test on samples
files = {
    'emailSample1.txt'
    'emailSample2.txt'
    'emailSample3.txt'
    'spamSample1.txt'
    'spamSample2.txt'
    'spamSample3.txt'
};

for i = 1:length(files)
    filename = files{i};

    % Read and predict
    file_contents = readFile(filename);
    word_indices  = processEmail(file_contents);
    x             = emailFeatures(word_indices);
    p = svmpredict(0, x', model, '-q');

    fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
    fprintf('(1 indicates spam, 0 indicates not spam)\n\n');

    fprintf('\n\n');
    fprintf('\nProgram paused. Press enter to continue.\n');
    pause;
end
