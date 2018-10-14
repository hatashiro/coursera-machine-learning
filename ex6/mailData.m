function mailData()

Data = [];

spam_dir = 'mail_data/spam';
non_spam_dir = 'mail_data/non_spam';

for file = dir(spam_dir)'
    file_name = file.name;
    if file_name(1) == '.'; continue; end
        
    file_contents = readFile(strcat(spam_dir, '/', file_name));
    features = emailFeatures(processEmail(file_contents));
    
    Data = [Data; [features', 1]];
end

for file = dir(non_spam_dir)'
    file_name = file.name;
    if file_name(1) == '.'; continue; end
        
    file_contents = readFile(strcat(non_spam_dir, '/', file_name));
    features = emailFeatures(processEmail(file_contents));
    
    Data = [Data; [features', 0]];
end

% shuffle data
m = size(Data, 1);
Data = Data(randperm(m), :);

X = Data(:, 1:end-1);
y = Data(:, end);

% CV set
cv_set_size = floor(m * 0.2);
cv_set_rows = randperm(cv_set_size);
Xcv = X(cv_set_rows, :);
ycv = y(cv_set_rows);
X(cv_set_rows, :) = []; % remove from X
y(cv_set_rows) = []; % remove from y

% test set
test_set_size = floor(m * 0.2);
test_set_rows = randperm(test_set_size);
Xtest = X(test_set_rows, :);
ytest = y(test_set_rows);
X(test_set_rows, :) = []; % remove from X
y(test_set_rows) = []; % remove from y

save mailData X y Xcv ycv Xtest ytest

end