library("tidyr")
library("tidytext")
library(tm)
library(stringr)
library(rvest)
library(dplyr)
library(data.table)
trip <- read.csv("C:/Users/DELL LAPTOP/Sentiment-Analysis-TripAdvisor/data/restaurant1.csv")
hotel_reviews <- as.character(trip$review)
myCorpus <- Corpus(VectorSource(hotel_reviews))
filtered_corpus_no_stopwords <- tm_map(myCorpus, removeWords, stopwords('english'))
inspect(filtered_corpus_no_stopwords)
filtered_corpus_no_puncts <- tm_map(filtered_corpus_no_stopwords, removePunctuation)
inspect(filtered_corpus_no_puncts)
filtered_corpus_no_numbers <- tm_map(filtered_corpus_no_puncts, removeNumbers)
inspect(filtered_corpus_no_numbers)
filtered_corpus_no_whitespace <- tm_map(filtered_corpus_no_numbers, stripWhitespace)
inspect(filtered_corpus_no_whitespace)
filtered_corpus_to_lower <- tm_map(filtered_corpus_no_whitespace, content_transformer(tolower))
inspect(filtered_corpus_to_lower)

# Load the stop words text file and explore
stop_words <- read.csv("C:/Users/DELL LAPTOP/Sentiment-Analysis-TripAdvisor/data/stopwords_en.txt")

# Remove stop words of the external file from the corpus and whitespaces again and inspect
stopwords_vec <- as.data.frame(stop_words)
final_corpus_no_stopwords <- tm_map(filtered_corpus_to_lower, removeWords, stopwords_vec[,1]) 
inspect(final_corpus_no_stopwords)
final_corpus <- tm_map(final_corpus_no_stopwords, stripWhitespace)
inspect(final_corpus)
stemmed_corpus <- tm_map(final_corpus, stemDocument)
size <- length(stemmed_corpus)
total_pos_count <- 0
total_neg_count <- 0
for(i in 1:size){
d <-data.frame(text = sapply(stemmed_corpus[[i]]$content, as.character), stringsAsFactors = FALSE)
da <- d %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
#print(da)
bigrams_separated <- da %>%
  separate(bigram, c("word1", "word2"), sep = " ")
#print(bigrams_separated)
AFINN <- get_sentiments("afinn")
negation_words <- c("not", "no", "never", "without")
negation_bigrams <- bigrams_separated %>%
  filter(word1 %in% negation_words) %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word1, word2, score, sort = TRUE) %>%
  mutate(contribution = n * score) %>%
  arrange(desc(abs(contribution))) %>%
  group_by(word1) %>%
  slice(seq_len(20)) %>%
  arrange(word1,desc(contribution)) %>%
  ungroup()
x<-(sum(negation_bigrams$contribution))
position_bigrams <- bigrams_separated %>%
  filter (word1 != "not" && word1 != "no" && word1 != "never" && word1 != "without") %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word1, word2, score, sort = TRUE) %>%
  mutate(contribution = n * score) 
y<-(sum(position_bigrams$contribution))
#print(x+y)
if((x+y)>0){
    total_pos_count=total_pos_count+1
  } else{
    total_neg_count=total_neg_count+1
  }
}
print(total_pos_count)
print(total_neg_count)
total_count <- total_pos_count + total_neg_count
overall_positive_percentage <- (total_pos_count*100)/total_count
overall_negative_percentage <- (total_neg_count*100)/total_count
overall_positive_percentage
overall_negative_percentage
percent_vec <- c(overall_positive_percentage, overall_negative_percentage)
percent_frame <- as.data.frame(percent_vec)
rownames(percent_frame) <- c("Positive Reviews","Negative Reviews")
colnames(percent_frame) <- c("Percentage")
percentage <- t(percent_frame)
barplot(percentage, ylab = "Percentage", main = "Sentiment Analysis of JW Marriot Reviews on TripAdvisor", col="lightblue")

