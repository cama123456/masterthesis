library(tm)
library(dplyr)
library(udpipe)

#Remove spam from user xxx
cond1 <- df$author == xxx
df2 <- df[!cond1,]

#Remove spam form source xxx. 
cond2 <- df2$source == "xxx" 
df3 <- df2[!cond2,]

#Remove duplicates
df4 <- df3 %>% distinct(text, .keep_all = TRUE)

#Text cleansing
text <- iconv(df4$text, to = "ASCII", sub="")
text[3]

clean_text <- gsub("((?:\\b\\W*@\\w+)+)", " ", text)  #usernames
clean_text[3]
clean_text = gsub("http.+ |http.+$", " ", clean_text)  # Remove html links
clean_text[3]
clean_text = gsub("http[[:alnum:]]*", " ", clean_text) # Remove html links
clean_text[3]
clean_text = gsub("[[:punct:]]", " ", clean_text)  # Remove punctuation
clean_text[3]
clean_text = gsub("[ |\t]{2,}", " ", clean_text)  # Remove tabs
clean_text[3]
clean_text = gsub("^ ", "", clean_text)  # Leading blanks
clean_text[3]
clean_text = gsub(" $", "", clean_text)  # Lagging blanks
clean_text[3]
clean_text = gsub(" +", " ", clean_text) # General spaces 
clean_text[3]
clean_text = tolower(clean_text) #Lower case
clean_text[3]

#Build Corpus from Vector
corpus <- Corpus(VectorSource(clean_text))

##Print Example
writeLines(as.character(corpus[[3]]))

##Stop Word Removal
corpus <- tm_map(corpus, removeWords, stopwords("english"))  
writeLines(as.character(corpus[[3]]))
corpus <- tm_map(corpus, removeNumbers)
writeLines(as.character(corpus[[3]]))
corpus = tm_map(corpus, removeWords, c("telework", "teleworking", "teleworked", "teleworker", "teleworkers", "teleworkday", "teleworkdays", 
                                       "teleworkingday", "teleworkingdays", "workfromhome", "work+from+home", "wfh", "work-from-home", 
                                       "working+from+home", "workingfromhome", "workedfromhome", "wfhday", "wfhdays", "workingfromhomeday", 
                                       "workingfromhomedays","remote+work", "working+remote", "working+remotely", "work+remote", "workremote", 
                                       "remotework", "worked+remote", "worked+remotely", "workingremotely", "workingremote", "remoteworker", 
                                       "workremotely", "remoteworkday", "remoteworkdays", "remoteworkingday", "remoteworkingdays", 
                                       "workingremoteday", "workingremotedays", "wfhworker", "wfhworkers", "remoteworkers", "worked+from+home", 
                                       "workedremote", "workedremotely", "workremotely", "WFH", "work", "from", "home", "working", "worked", 
                                       "remote", "remotely", "day"))
corpus = tm_map(corpus, removeWords, c("weve","iv", "its", "ive","id","isnt", "wasn", "werent","im","m", "it", "s", "amp", "ve", "will", "isn", 
                                       "t", "d", "id", "im", "one", "can", "cant", "really", "get", "dont", "getting", "still", "now", "one", "much", 
                                       "many", "just"))
writeLines(as.character(corpus[[3]]))
corpus <- tm_map(corpus, stripWhitespace)
writeLines(as.character(corpus[[3]]))

#Lemmatization
content <- iconv(corpus$content, to = "ASCII", sub="")
anno <- udpipe(content, "english")
anno[, c("doc_id", "token", "lemma", "upos")]
lemmatisation <- paste.data.frame(anno, term = "lemma", 
                                  group = c("doc_id"))

#Build Corpus from Vector
corpus_lemma <- Corpus(VectorSource(lemmatisation$lemma))
writeLines(as.character(corpus_lemma[[3]]))

#Stemming
corpus_stemm <- tm_map(corpus_lemma, stemDocument)
writeLines(as.character(corpus_stemm[[3]]))
