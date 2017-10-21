library(ggvis)
library(class)
library(gmodels)
# wczytanie danych
iris_data <- read.table(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), header=FALSE, 
                     sep=',')
#wybór generatora liczb losowych
set.seed(1234)
#dopisanie 1 lub 2 do ka¿dego wiersza z wybranym prawdopodobienstwem
ind <- sample(2, nrow(iris_data), replace=TRUE, prob=c(0.66, 0.34)) 
#utworzenie zbioru treningowego i testowego
iris_data.training <- iris_data[ind==1, 1:4]
iris_data.test <- iris_data[ind==2, 1:4]
#ustalenie nazwy klasy dla ka¿dej próbki
iris_data.trainLabels <- iris_data[ind==1, 5]
iris_data.testLabels <- iris_data[ind==2, 5]
#uzycie algorytmu knn (zbior teningowy, zbior testowy, klasy, wspolczynnik k)
for(k in c(1,3,7,13,17,67)) {
iris_pred <- knn(train = iris_data.training, test = iris_data.test, cl = iris_data.trainLabels, k=k)
#wrzucenie predykcji do tabeli
irisTestLabels <- data.frame(iris_data.testLabels)
#z³aczenie ze zbiorem testowym
results <- data.frame(iris_pred, iris_data.testLabels)
names(results) <- c("Predicted Species", "Test Data")
#wyœwietlenie wyników
print(paste("Wyniki dla k = ", k))
CrossTable(x = iris_data.testLabels, y = iris_pred, prop.chisq=FALSE, prop.r=FALSE, prop.c=FALSE, prop.t=FALSE)
}