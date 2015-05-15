X = load('q1x.dat');
X = cat(2,ones(size(X,1),1),X);
Y = load('q1y.dat');

[theta,ll] = newtonMethod(X,Y);

theta