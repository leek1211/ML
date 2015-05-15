function [theta] = normalEqn(X, Y)

theta = zeros(size(X, 2), 1);

theta = pinv(X' * X) * X' * Y;

end
