library(ggvis)
library(class)
iris_data <- read.table(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), header=FALSE, 
                     sep=',')
set.seed(1234)
ind <- sample(2, nrow(iris_data), replace=TRUE, prob=c(0.66, 0.34))
iris_data.training <- iris_data[ind==1, 1:4]
iris_data.test <- iris_data[ind==2, 1:4]
iris_data.trainLabels <- iris_data[ind==1,5]
iris_data.testLabels <- iris_data[ind==2, 5]
iris_pred <- knn(train = iris_data.training, test = iris_data.test, cl = iris_data.trainLabels, k=3)
irisTestLabels <- data.frame(iris_data.testLabels)
merge <- data.frame(iris_pred, iris_data.testLabels)
names(merge) <- c("Predicted Species", "Observd Spicies")
merge
