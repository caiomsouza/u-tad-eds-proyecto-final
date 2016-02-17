# Installing SparkR
#https://amplab-extras.github.io/SparkR-pkg/

#SparkR - Code
library(SparkR) # Load the library
spark_path <- strsplit(system("brew info apache-spark",intern=T)[4],' ')[[1]][1] # Get your spark path
.libPaths(c(file.path(spark_path,"libexec", "R", "lib"), .libPaths())) # Navigate to SparkR folder
sc <- sparkR.init(master="local")
#SparkR - Code

setwd("~/git/Bitbucket/u-tad/final-project/src/r-script")

# http://thinktostart.com/sentiment-analysis-on-twitter/
# https://jeffreybreen.wordpress.com/2011/07/04/twitter-text-mining-r-slides/

#http://www.r-bloggers.com/mining-twitter-for-consumer-attitudes-towards-hotels/

#library(devtools)
#install_github("twitteR", username="geoffjentry")

#install.packages("ROAuth")
#install.packages("RCurl")
#install.packages("bitops")
#install.packages("digest")
#install.packages("rjson")


library(twitteR)
library(plyr)
library(ROAuth)
library(bitops)
library(digest)
library(rjson)


#api_key <- "YOUR API KEY"
#api_secret <- "YOUR API SECRET"
#access_token <- "YOUR ACCESS TOKEN"
#access_token_secret <- "YOUR ACCESS TOKEN SECRET"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#searchTwitter("dilma")
#word_search = "dilma"
#word_search = "pentaho"
#word_search = "brasil"
word_search = "dilma"

tweets = searchTwitter(word_search, n=2000)
tweets

Tweets.text = laply(tweets,function(t)t$getText())

Tweets.text

# Wordbanks from https://github.com/mjhea0/twitter-sentiment-analysis/tree/master/wordbanks
pos = scan('wordbanks/positive-words.txt', what='character', comment.char=';')
neg = scan('wordbanks/negative-words.txt', what='character', comment.char=';')

head(pos)
head(neg)

# SentiLex-PT01
pos = scan('/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT01/pos-pt01.txt', what='character', comment.char=';')
neg = scan('/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT01/neg-pt01.txt', what='character', comment.char=';')

head(pos,20)
head(neg,20)

# SentiLex-PT02
pos = scan('/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT02/pos.txt', what='character', comment.char=';')
neg = scan('/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT02/neg.txt', what='character', comment.char=';')

head(pos,20)
head(neg,20)



clean.text <- function(some_txt)
{
  some_txt = gsub("&amp", "", some_txt)
  
  some_txt = gsub("(RT|via)((?:\b\\W*@\\w+)+)", "", some_txt)
  
  some_txt = gsub("@\\w+", "", some_txt)
  
  some_txt = gsub("[[:punct:]]", "", some_txt)
  
  some_txt = gsub("[[:digit:]]", "", some_txt)
  
  some_txt = gsub("http\\w+", "", some_txt)
  
  some_txt = gsub("[ t]{2,}", "", some_txt)
  
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  
  # define "tolower error handling" function
  
  try.tolower = function(x)
    
  {
    
    y = NA
    
    try_error = tryCatch(tolower(x), error=function(e) e)
    
    if (!inherits(try_error, "error"))
      
      y = tolower(x)
    
    return(y)
    
  }
  
  some_txt = sapply(some_txt, try.tolower)
  
  some_txt = some_txt[some_txt != ""]
  
  names(some_txt) = NULL
  
  return(some_txt)
  
}


clean_text = clean.text(Tweets.text)


score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use 
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}


analysis = score.sentiment(clean_text, pos, neg)

#View(analysis)

table(analysis$score)

mean(analysis$score)

hist(analysis$score)


colnames(analysis)
#View(analysis)

analysis.df <- as.data.frame(analysis)

analysis.df
head(analysis.df)

#SparkR - Code
sc <- sparkR.init()
sqlContext <- sparkRSQL.init(sc)
# Create the DataFrame
df <- createDataFrame(sqlContext, analysis.df) 
#head(df)
#str(df)
#summary(df)
#SparkR - Code


# Word Cloud

library(tm)
tweet_corpus = Corpus(VectorSource(clean_text))

tdm = TermDocumentMatrix(tweet_corpus, control = list(removePunctuation = TRUE,stopwords = c("machine", "learning", stopwords("english")), removeNumbers = TRUE, tolower = TRUE))

#install.packages(c("wordcloud","tm"),repos="http://cran.r-project.org")

library(wordcloud)

require(plyr)

m = as.matrix(tdm) #we define tdm as matrix

word_freqs = sort(rowSums(m), decreasing=TRUE) #now we get the word orders in decreasing order
dm = data.frame(word=names(word_freqs), freq=word_freqs) #we create our data set
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2")) #and we visualize our data
png("~/git/Bitbucket/u-tad/final-project/src/r-script/Cloud_Test2.png", width=12, height=8, units="in", res=300)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()


write.table(dm, "dm2.txt", sep="\t")
write.table(m, "m2.txt", sep="\t")
write.table(analysis.df, "analysis-df2.txt", sep="\t")
write.table(clean_text, "clean_text2.txt", sep="\t")

sparkR.stop()


