library(randomForest)
library(caret)
data <- read.csv("fraudTest.csv")
View(data)
str(data)
summary(data)
data$cc_num <- as.factor(data$cc_num)
set.seed(123)
trainIndex <- createDataPartition(data$cc_num, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]
rf_model <- randomForest(cc_num ~ ., data = trainData, ntree = 100, mtry = sqrt(ncol(trainData) - 1))
print(rf_model)
rf_predictions <- predict(rf_model, newdata = testData)
confusionMatrix(rf_predictions, testData$cc_num)
importance(rf_model)
varImpPlot(rf_model)

