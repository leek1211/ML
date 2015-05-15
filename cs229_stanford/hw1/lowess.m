function [ret] = lowess(X, Y, tao, qx)

m = size(X,1);
n = size(X,2);
insize = size(qx,1);
ret = zeros(insize,1);

for tc = 1: insize
  W = eye(m);
  xx = qx(tc,:);

  for ii = 1: m
    xi = X(ii,:);
    sqdiff = (xx-xi) * (xx-xi)';
    W(ii,ii) *= exp(-sqdiff/(2 * tao*tao));
  end

  theta = pinv(X'*W*X) * X' * W * Y;
  ret(tc,1) = xx * theta;
end

