##Getting and Cleaning Data
###Getting the variable names of the features for averages and standard deviations
path <- paste(getwd(),'/features.txt', sep="")
features <- readLines(path)
ind <- grepl(".*(mean|std)[(][)]", features)
features_names <- gsub("[0-9]{1,3} ", "", features[ind])

##Creating a dataframe from train set
###Getting activities
path <- paste(getwd(),'/train/y_train.txt', sep="")
activities <- as.numeric(readLines(path))
activities <- factor(activities, levels = 1:6, labels = c("walking", "walking upstairs",
                                                          "walking downstairs", "sitting",
                                                          "standing", "laying"))
###Getting subjects 
path <- paste(getwd(),'/train/Subject_train.txt', sep="")
subjects <- as.numeric(readLines(path))

###Getting measures for the features previously selected
path <- paste(getwd(),'/train/X_train.txt', sep="")
measures <- readLines(path)
measures <- strsplit(measures, split=" +")
measures <- lapply(measures, function (elt) {as.numeric(elt[-1])})
M <- matrix(nrow = 7352, ncol = 66)
for (i in 1:7352) M[i,] <- measures[[i]][ind]

data_train <- data.frame(subjects, activities, M)
names(data_train) <- c("subjects", "activities", features_names)

##Creating a dataframe from test set
###Getting activities
path <- paste(getwd(),'/test/y_test.txt', sep="")
activities <- as.numeric(readLines(path))
activities <- factor(activities, levels = 1:6, labels = c("walking", "walking upstairs",
                                                          "walking downstairs", "sitting",
                                                          "standing", "laying"))
###Getting subjects 
path <- paste(getwd(),'/test/Subject_test.txt', sep="")
subjects <- as.numeric(readLines(path))

###Getting measures for the features previously selected
path <- paste(getwd(),'/test/X_test.txt', sep="")
measures <- readLines(path)
measures <- strsplit(measures, split=" +")
measures <- lapply(measures, function (elt) {as.numeric(elt[-1])})
M <- matrix(nrow = 2947, ncol = 66)
for (i in 1:2947) M[i,] <- measures[[i]][ind]

data_test <- data.frame(subjects, activities, M)
names(data_test) <- c("subjects", "activities", features_names)

##Merging the two dataframes
data <- rbind(data_train, data_test)
###Analysis
res <- data %>% group_by(activities, subjects) %>% summarise_each(funs(mean), 3:68)