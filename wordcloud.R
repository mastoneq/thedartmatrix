library(tm)
library(wordcloud)
library(RColorBrewer)

options(stringsAsFactors = FALSE)
Sys.setlocale('LC_ALL','C')

tryTolower <- function(x){
  y = NA
  try_error = tryCatch(tolower(x), error = function(e) e)
  if (!inherits(try_error, 'error'))
    y = tolower(x)
  return(y)
}

#Stopwords
indefinate.articles <- c("a","an","the")
pronouns <- c("I", "me", "he", "she", "herself", "you", "it", "that",
              "they", "each", "few", "many", "who", "whoever", "whose", "someone", "everybody")
conjunctions <- c("and", "for", "but", "or", "so", "yet", "nor", "either", "neither", "as")
custom.stopwords <- c(indefinate.articles, pronouns, conjunctions)

corp.collapse<-function(csv.name, text.column.name){
  x <- read.csv(file=csv.name, head=TRUE, sep=",")
  x <-iconv(x[,text.column.name], "latin1","ASCII",sub='')
  x <- VCorpus(VectorSource(x))
  x <- tm_map(x, removePunctuation)
  x <- tm_map(x, removeNumbers)
  x <- tm_map(x, tryTolower)
  x <- tm_map(x, removeWords, custom.stopwords)
  x <- paste(x, collapse=" ")
}

negative<-corp.collapse('TheDartMatrixNegative.csv','NOTE_TEXT')
positive<-corp.collapse('TheDartMatrixPositive.csv','NOTE_TEXT')

all <- c(negative, positive)
all.corpus <- VCorpus(VectorSource(all))

all.tdm <- TermDocumentMatrix(all.corpus)

all.tdm <- as.matrix(all.tdm)

colnames(all.tdm) = c("Negative", "Positive")
all.tdm[50:55,1:2]

pal <- brewer.pal(8, "Purples")
pal <- pal[-(1:2)]

commonality.cloud(all.tdm, max.words=500, random.order=FALSE,colors=pal)

set.seed(1237)
comparison.cloud(all.tdm, max.words=500, random.order=FALSE,
                 title.size=1.0,
                 colors=brewer.pal(ncol(all.tdm),"Dark2"))
