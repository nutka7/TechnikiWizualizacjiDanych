% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/chooseClassifier.R
\name{chooseClassifier}
\alias{chooseClassifier}
\title{Choose The Best Classifier}
\usage{
chooseClassifier(formula, train, test, choice = c(1, 1, 1, 0, 0, 0, 0, 0))
}
\arguments{
  \item{formula}{A \code{formula} for classifiers to
  compute.}

  \item{train}{A \code{data.frame} denoting the training
  set.}

  \item{test}{A \code{data.frame} denoting the test set.}

  \item{choice}{A \code{vecoter} of length 8 specifying
  which classifiers should be compared. The order is as
  follows: Naive Bayes, LDA, Logit, Probit, SVM,
  Classification Tree, Boosting, Bagging. The default is
  \code{c(1,1,1,0,0,0,0,0)} which corresponds to Naive
  Bayes, LDA and Logit classifiers.}
}
\description{
For an object of class \code{formula} and a data set the

\code{chooseClassifier} computes a \link{ggplot} showing
the Area Under the Curve (result of
\link[ROCR]{performance}) for classification algorithms
like \link{naiveBayes}, \link{lda}, logistic regression
\link{glm} with \code{logit} or \code{probit} link
function. Also there is shown precision for every
classifier on a \code{ggplot}. Any classifier can be added
if needed. Contact:
\href{https://github.com/sandersone/twd1/issues}{https://github.com/sandersone/twd1/issues}.
}
\note{
For naive Bayes a parameter \code{laplace} is set to 0.2.
For SVM parameters are \code{type='C'} and
\code{kernel="radial"}.
}
\examples{
library(foreign)
se <- read.arff("http://archive.ics.uci.edu/ml/machine-learning-databases/00266/seismic-bumps.arff")
index <- 1:(2*nrow(se)/3)
se <- se[,-c(14:16)]
se_wyb <- se[,-c(9,15)]
train <- se_wyb[ index, ]
test <- se_wyb[ -index, ]
chooseClassifier( class~., train, test, rep(1,8) )

###################
chooseClassifier( class~., train, test, c(1,0,1,0,1,0,1,0) )

################
lo <- read.table("http://www.ipipan.eu/~teisseyrep/TEACHING/DM/DANE/brach3-5klas.txt",
header=TRUE)
lo[, 7] <- ifelse(lo[, 7] \%in\% c(1,2),1,0 )
index <- sample(1:nrow(lo), size=1/2*nrow(lo))
train <- lo[index,]
test <- lo[-index,]
lo[, 7] <- as.integer(lo[, 7])

chooseClassifier( LOC~., train, test, c(1,0,1,0,0,0,0,0) )


###############
fit <- read.table("http://www.ipipan.eu/~teisseyrep/TEACHING/DM/DANE/fitness.txt",
header = TRUE)

fit[, 8] <- sample(0:1, size = nrow(fit), replace=TRUE)
names(fit)[8] <- "group"
index <- sample(1:nrow(fit), size=1/2*nrow(fit))
train <- fit[index,]
test <- fit[-index,]

chooseClassifier( group~., train, test,
                  sample(0:1, size = 8, replace=TRUE) )
}

