# Table of Contents
1. [Data Clean](#data-clean)
2. [Correlation](#correlation)
3. [Feature Selection](#feature-selection)
4. [Data Split](#data-split)
5. [Machine Learning](#machine-learning)


## Data Clean
Mapping values in a column - i. e., change the value from smth1 to smth2 - package “plyt”

    df$col <- mapvalues(df$col, from=c(smth1), to=c(smth2))

Replace values - replace the pattern by the replacement, in a given column

    str_replace_all(df$col, pattern, replacement) # all pattern
    str_replace(df$col, pattern, replacement) # first pattern

Drop unnecessary rows - the lines that have some element with value NA

    df <- na.omit(df)

Normalize the data

    df[,cols] <- scale(df[,cols])

Convert column to type factor

    df$col <- as.factor(df$col)

## Correlation
### Simple correlation
to numeric variables
m = "pearson" | "spearman" | "kendall"

    cor(df[,cols],method=m)

### Scatterplot Matrix
to numeric variables
package "psych"

    pairs.panels(df[c("x1","x2", ... ,"xn","y")])

### Chi square test
to categorical variables
the lower the probability the greater the correlation

    CrossTable(x = df$col, y = df$col, chisq = TRUE) # package "gmodels"
    chisq.test(x = df$col, y = df$col)

### Contingency table
to categorical variables
package "gmodels"

    CrossTable(x = df$col, y = df$col)

## Feature Selection
### Packet "randomForest"
    mod <- randomForest(y~x, data=df, ntree=n, nodesize=n1, importance=T)
    varImpPlot(mod) # it’ll plot the most important one

### Packet "randomForest" and "caret"
    run.feature.selection <- function(num.iters=20, feature.vars, class.var){
      variable.sizes <- 1:10
      control <- rfeControl(functions = rfFuncs, method = "cv", verbose = FALSE, returnResamp = "all", number = num.iters)
      results.rfe <- rfe(x = feature.vars, y = class.var, sizes = variable.sizes, rfeControl = control)		
      return(results.rfe) 
    }

    # execute the feature selection
    rfe.results <- run.feature.selection(feature.vars = x, class.var = y) 

    # plot the most important columns
    varImpPlot(mod) 

### Packet "olsrr"
Stepwise forward regression -Começa com um modelo vazio e adiciona cada melhor variável sequencialmente. 

    ols_step_forward_p(modelo) 

Stepwise backward regression-Começa com um modelo saturado (contendo todas as variáveis possíveis) e remove a pior variável sequencialmente. 

    ols_step_backward_p(modelo) 

Stepwise regression-Começa com um modelo vazio e adicione uma variável por vez.  Adicionamos a melhor variável e, em seguida, removemos a pior variável. 

    ols_step_both_p(modelo) 

Stepwise AIC forward regression

    ols_step_forward_aic(modelo) 

Stepwise AIC backward regression

    ols_step_backward_aic(modelo) 

Stepwise AIC regression

    ols_step_both_aic(modelo)


## Data Split
Using a function - packet “caret”

    index <- createDataPartition(df$FieldY, p=n, list=FALSE) # n is the training data percentage (0.7)

Using custom variables 

    i <- 1:nrow(df)
    index <- sample(i, trunc(length(i)/2))

Getting the data

    training <- df[index,]
    testing <- df[-index,]

## Machine Learning
### Linear Regression - packet “caret”
    mod <- lm(y ~ x, data = df)
    bptest(mod) # Test Heteroskedasticity using Breusch-Pagan Test
    vif(mod) # Test multicollinearity using Variance Inflation Factor

### GLM w/ Lasso or Elasticnet Reg
    glmnet(x, y, alpha) # alpha=1 is lasso penalty, and, =0 is ridge penalty

### Logistic Regression - packet “caret”
family is a description of the error distribution and link func - others families

    mod <- glm(y ~ x, family=binomial(link="logit"), data=training)

### Decision Tree - package “party”
    mod <- ctree(y ~ x, training)

### Random Forest - package "randomForest"
    mod <- randomForest(y ~ x, data = training)

### KNN - package “class”
    mod <- knn(train = training, test = testing, cl = data_train_labels, k = n)

### SVM - package “e1071”
type can be: ‘C-classification’, ‘nu-classification’, ‘eps-regression’, ‘nu-regression’

kernel can be: ‘radial’, ‘linear’, ‘sigmoid’

    mod <- svm(y ~ x, data = training, type = 'C-classification', kernel = 'radial')

### Predictions
    predict(mod, testing[,-y])

### Confusion matrix
    table(Predicted = pred, Actual = testing$y) 

### Residuals
    resid(mod)

### Model Resume
    summary(mod)

### Get Coefficient
    mod$coefficients

### Model Bootstrap - package “car”
    varImp(mod) # important variablesS
    bootCase(mod, function(x) predict(x,testing[,-y],B=999))
