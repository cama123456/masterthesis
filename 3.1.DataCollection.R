library(academictwitteR)

set_bearer()

my_query <- build_query(c("telework", "teleworking", "teleworked", "teleworker", "teleworkers", "teleworkday", "teleworkdays", "teleworkingday", "teleworkingdays", "workfromhome", "work+from+home", "wfh", "work-from-home", "working+from+home", "workingfromhome", "workedfromhome", "wfhday", "wfhdays", "workingfromhomeday", "workingfromhomedays","remote+work", "working+remote", "working+remotely", "work+remote", "workremote", "remotework", "worked+remote", "worked+remotely", "workingremotely", "workingremote", "remoteworker", "workremotely", "remoteworkday", "remoteworkdays", "remoteworkingday", "remoteworkingdays", "workingremoteday", "workingremotedays", "wfhworker", "wfhworkers", "remoteworkers", "worked+from+home", "workedremote", "workedremotely", "workremotely", "WFH"))

#Query2020
tweets <-
  get_all_tweets(
    query = my_query,
    exact_phrase = FALSE,
    start_tweets = "2020-03-26T00:00:00Z",
    end_tweets = "2020-05-10T23:59:00Z",
    bearer_token = get_bearer(),
    is_retweet = FALSE,
    remove_promoted = TRUE,
    lang = "en",
    country = "GB",
    file = "tweets",
    data_path = "tweets2020",
    bind_tweets = TRUE,
    n = 100000
  )

#Transform to DF
df <- data.frame(text = tweets$text, id = tweets$id, date = tweets$created_at, author = tweets$author_id, source = tweets$source)
write.csv2(df, 'C:\\Users\\xxx\\tweets2020.csv', row.names = FALSE, fileEncoding = "UTF-8") 

#Query2019
tweets <-
  get_all_tweets(
    query = my_query,
    exact_phrase = FALSE,
    start_tweets = "2010-01-01T00:00:00Z",
    end_tweets = "2019-10-31T23:59:00Z",
    bearer_token = get_bearer(),
    is_retweet = FALSE,
    remove_promoted = TRUE,
    lang = "en",
    country = "GB",
    file = "tweets",
    data_path = "tweets2019",
    bind_tweets = TRUE,
    n = 16926
  )

#Transform to DF
df <- data.frame(text = tweets$text, id = tweets$id, date = tweets$created_at, author = tweets$author_id, source = tweets$source)
write.csv2(df, 'C:\\Users\\xxx\\tweets2019.csv', row.names = FALSE, fileEncoding = "UTF-8") 