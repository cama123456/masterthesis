library(dplyr)
library(ggplot2)

#Matching sentiment words from the 'bing' sentiment lexicon
senti_bing = inner_join(token, get_sentiments("bing")) %>%
  count(sentiment)
senti_bing$percent = (senti_bing$n/sum(senti$n))*100
head(senti_bing)

#Matching sentiment words from the 'NRC' sentiment lexicon
senti = inner_join(token, get_sentiments("nrc")) %>%
  count(sentiment)
senti$percent = (senti$n/sum(senti$n))*100
senti

#Negative and positive terms
sentiments_tweet <- token %>%  
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup() %>%
  group_by(sentiment) %>%
  top_n(20) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  facet_wrap(~sentiment, scales = "free_y") +
  ylim(0, 1000) +
  labs(y = "Frequency of Words", x = "Words", subtitle = "DS1 - Enforced Telework") +
  coord_flip() +
  theme_minimal()

sentiments_tweet


