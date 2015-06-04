numTrainDocs = 700;
numTokens = 2500;
M = dlmread('train-features.txt', ' ');
spmatrix = sparse(M(:,1), M(:,2), M(:,3), numTrainDocs, numTokens);
train_matrix = full(spmatrix);

train_labels = dlmread('train-labels.txt');

m =length(train_labels);

phi_y1 = 0;
phi_y0 = 0;
phi_k_y = zeros(numTokens, 2);
for iter = 1:m
  if(train_labels(iter) == 1) 
    phi_y1 = phi_y1 + 1;
  else 
    phi_y0 = phi_y0 + 1;
    endif
    endfor

    phi_y1 = phi_y1 / m;
    phi_y0 = phi_y0 / m;
    for k = 1: numTokens
      ni = 0;
      for i = 1 : m
        if ( train_labels(i) == 1) 
          phi_k_y(k,2) += train_matrix(i, k);
    else 
      phi_k_y(k,1) += train_matrix(i, k);
    end
  end
  phi_k_y(k,2) ++;
  phi_k_y(k,1) ++;
end

n = zeros(numTrainDocs,1);
for i = 1 : m
  for kk = 1 : numTokens
    n(i) = n(i) + train_matrix(i,kk);
  end
end

for k = 1 : numTokens
  ni1 = 0;
  ni0 = 0;

  for i = 1 : m
    if(train_labels(i) == 1)
      ni1 += n(i);
    else
      ni0 += n(i);
    end
  end

  phi_k_y(k,1) /= (ni0 + numTokens);
  phi_k_y(k,2) /= (ni1 + numTokens);
end

numTestDocs= 260;
test_matrix = dlmread('test-features.txt', ' ');

phi_y_x = zeros(numTestDocs, 2);
for it = 1 : numTestDocs
  phi_y_x(it, 1) += phi_y0;
  phi_y_x(it, 2) += phi_y1;
end

for it = 1 : length(test_matrix)
  docid = test_matrix(it,1);
  wid = test_matrix(it,2);
  count = test_matrix(it,3);
  phi_y_x(docid, 1) += log(phi_k_y(wid,1)) * count;
  phi_y_x(docid, 2) += log(phi_k_y(wid,2)) * count;
end
'result'
res = zeros(numTestDocs,1);
for i = 1 : numTestDocs
  if(phi_y_x(i,1) > phi_y_x(i,2)) res(i) = 0;
  else res(i) = 1;
  end
end
res
