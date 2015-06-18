import pandas as pd
from sklearn import svm, metrics
from sklearn.decomposition import PCA
train = pd.read_csv('../input/train.csv')
test = pd.read_csv('../input/test.csv')
train_x = train.ix[:,1:].values.astype('int32')
train_y = train.ix[:,0].values.astype('int32')
test_x = test.ix[:,:].values.astype('int32')
print('Loaded ' + str(len(train_x)))

# PCA reduction
pca = PCA(n_components=35, whiten=True)
pca.fit(train_x)
train_x = pca.transform(train_x)
test_x = pca.transform(test_x)

# print train_y
# print type(train_x), type(train_y)
# print len(train_y), len(train_x)
# print train_x[0], train_y[0]

# SVM classifier
clf = svm.SVC(gamma=0.001)
clf.fit(train_x, train_y)

# test output
def write_preds(preds, fname):
    pd.DataFrame({"ImageId": range(1,len(preds)+1), "Label": preds}).to_csv(fname, index=False, header=True)
test_y = clf.predict(test_x)
write_preds(test_y, 'out.csv')