library(tm)
library(topicmodels)
library(ldatuning)

#set options
options(stringsAsFactors = F)
options("scipen" = 100, "digits" = 4)

#compute document term matrix
minimumFrequency <- 1
DTM <- DocumentTermMatrix(corpus_stemm, control = list(bounds = list(global = c(minimumFrequency, Inf))))

inspect(DTM[1:5, 1:5])
dim(DTM)

#remove empty documents
sel_idx <- slam::row_sums(DTM) > 0
DTM <- DTM[sel_idx, ]

#calculate optimal topic number 
result <- ldatuning::FindTopicsNumber(
  DTM,
  topics = seq(from = 10, to = 80, by = 2),
  metrics = c("Griffiths2004", "CaoJuan2009"),
  method = "Gibbs",
  control = list(seed = 77),
  verbose = TRUE
)
FindTopicsNumber_plot(result)
write.csv(result,"C:\\Users\\xxx\\metrics.csv", row.names = FALSE)
result

#set number of topics
K <- 50
#set random number generator seed
set.seed(9161)
#compute the LDA model, inference via 1000 iterations of Gibbs sampling
topicModel <- LDA(DTM, K, method="Gibbs", control=list(iter = 3000, verbose = 25))

#Top 10 terms or words under each topic
top10terms = as.matrix(terms(topicModel,50))
top10terms
write.csv(top10terms,file = paste('LDAGibbs',50,'Topics.csv'))

#Docs to Topic
lda.topics = as.matrix(topics(topicModel))
write.csv(lda.topics,file = paste('LDAGibbs',50,'DocsToTopics.csv'))
summary(as.factor(lda.topics[,1]))

#Docs to Topic Propability
topicprob = as.matrix(topicModel@gamma)
write.csv(topicprob, file = paste('LDAGibbs', 50, 'DoctToTopicProb.csv'))
head(topicprob,1)




 