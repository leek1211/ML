clear ; close all; clc

X = load('q2x.dat');
X = cat(2, ones(size(X,1),1),X);
Y = load('q2y.dat');

[theta] = normalEqn(X,Y);
plotData(X,Y);
pause;
hold on;
plot(X(:,2), X*theta, '-');
hold on;
rangeOfX = -5:0.1:15;
rangeOfX = rangeOfX'; 
rangeOfX = cat(2, ones(size(rangeOfX,1),1),rangeOfX);
plot(rangeOfX(:,2), lowess(X,Y, 0.8,rangeOfX), '.');
hold on;
%plot(rangeOfX(:,2), lowess(X,Y, 0.1,rangeOfX), '<');
%hold on;
%plot(rangeOfX(:,2), lowess(X,Y, 10,rangeOfX), '>');
%hold on;

pause;
% if tao is too small, it becomes overfit.
% if tao is too small, it's underfit.