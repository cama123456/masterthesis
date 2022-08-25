library(dplyr)
library(tidytext)
library(ggplot2)
library(readxl)

#Convert corpus to df
documents2020 <- data.frame(id=c(1:16436), text=corpus_stemm$content)

#import document ids
ids2020 <- read_excel("C:/Users/xxx/2020_topicCovid.xlsx")

#Create Subset with uploaded IDExcle
analyse2020 <- subset.data.frame(documents2020, id %in% ids2020$ID)

#Tokenize
token2020 = data.frame(text=analyse2020$text, stringsAsFactors = FALSE) %>% unnest_tokens(word, text)

#Matching sentiment words from the 'bing' sentiment lexicon
senti_bing2020 = inner_join(token2020, get_sentiments("bing")) %>%
  count(sentiment)
senti_bing2020$percent = (senti_bing2020$n/sum(senti_bing2020$n))*100
head(senti_bing2020)


#Negative and positive terms
sentiments_tweet2020 <- token2020 %>%  
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup() %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  facet_wrap(~sentiment, scales = "free_y") +
  ylim(0, 250) +
  labs(y = "Frequency of Words", x = "Words", subtitle = "Top10Words 2020  Covid") +
  coord_flip() +
  theme_minimal()

sentiments_tweet2020

