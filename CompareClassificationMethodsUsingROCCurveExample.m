%% Compare Classification Methods Using ROC Curve
% Load the sample data.

% Copyright 2015 The MathWorks, Inc.

load ionosphere
%%
% |X| is a 351x34 real-valued matrix of predictors. |Y| is a character
% array of class labels: |'b'| for bad radar returns and |'g'| for good radar
% returns.
%%
% Reformat the response to fit a logistic regression. Use the predictor
% variables 3 through 34.
resp = strcmp(Y,'b'); % resp = 1, if Y = 'b', or 0 if Y = 'g' 
pred = X(:,3:34);
%%
% Fit a logistic regression model to estimate the posterior
% probabilities for a radar return to be a bad one.
mdl = fitglm(pred,resp,'Distribution','binomial','Link','logit');
score_log = mdl.Fitted.Probability; % Probability estimates
%% 
% Compute the standard ROC curve using the probabilities for scores.
[Xlog,Ylog,Tlog,AUClog] = perfcurve(resp,score_log,'true');
%%
% Train an SVM classifier on the same sample data. Standardize the data.
mdlSVM = fitcsvm(pred,resp,'Standardize',true);
%%   
% Compute the posterior probabilities (scores).
mdlSVM = fitPosterior(mdlSVM);
[~,score_svm] = resubPredict(mdlSVM);
%%
% The second column of |score_svm| contains the posterior probabilities
% of bad radar returns.
%%
% Compute the standard ROC curve using the scores from the SVM model.
[Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(resp,score_svm(:,mdlSVM.ClassNames),'true');
%%
% Fit a naive Bayes classifier on the same sample data.
mdlNB = fitcnb(pred,resp);
%%
% Compute the posterior probabilities (scores).
[~,score_nb] = resubPredict(mdlNB);
%%
% Compute the standard ROC curve using the scores from the naive Bayes
% classification.
[Xnb,Ynb,Tnb,AUCnb] = perfcurve(resp,score_nb(:,mdlNB.ClassNames),'true');
%%
% Plot the ROC curves on the same graph.
plot(Xlog,Ylog)
hold on
plot(Xsvm,Ysvm)
plot(Xnb,Ynb)
legend('Logistic Regression','Support Vector Machines','Naive Bayes','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for Logistic Regression, SVM, and Naive Bayes Classification')
hold off
%%
% Although SVM produces better ROC values for higher thresholds, logistic
% regression is usually better at distinguishing the bad radar returns from the
% good ones. The ROC curve for naive Bayes is generally
% lower than the other two ROC curves, which indicates worse in-sample
% performance than the other two classifier methods.
%%
% Compare the area under the curve for all three classifiers.
AUClog
AUCsvm
AUCnb
%%
% Logistic regression has the highest AUC measure for classification and
% naive Bayes has the lowest. This result suggests that logistic regression
% has better in-sample average performance for this sample data.
