# SentimentAnalysis_TripAdvisor_Restaurants
This is the code of complete data extraction and sentiment analysis of restaurants in Newyork from the reviews available in Trip Advisor in R 


## Description


* Implemented a web scraper to fetch restaurant reviews of NewYork from TripAdvisor website.
* Conducted data pre-processing and cleaning by removing stop words, punctuation, special characters, numbers, and white-spaces from reviews.
* Performed tokenization and stemming of reviews, and built a corpus out of it.

### Lexicon-sentiment-analysis:

* Calculated the sentiment score of each review by comparing it's tokens with positive and negative lexicon and the overall sentiment score of the hotel depending on the number of positive and negative reviews it received.
* Visualized the results using bar-plot and box-plot charts.

### Bigram-sentiment-analysis:

* Constructed a list of bigrams from the available corpus of reviews.
* Filtered out the bigrams starting with negation words like not,nor,no and determined a sentiment score by negating the affinity of the following word.
* Similarly,the sentiment score of the rest of the bigrams is determined.
* Calculated the overall sentiment score of the restaurant depending on the total number of positive and negative reviews it received.
* Visualized the results using bar-plot and box-plot charts.

## Code

* data_extract.R - to extract reviews of a particular restaurant from TripAdvisor site
* bigram_analysis.R - to construct and perform the sentiment analysis on bigrams of the reviews.
* lexicon_sentiment_analysis.R - to process the review data and determine the overall sentiment score.

## Visualization
 
From the visualizations of the box-plots the following results are obtained regarding the sentiment scores



*           Name                     Lexicon-Analysis                 Bigram-Analysis            OriginalRating
*			                    positive         negative         positive         negative         
*                               sentiment-score sentiment-score sentiment-score sentiment-score 
* Restaurant1:McDonald's----------71.29485----------28.70515----------57.06806----------42.93194----------3.5 = 70.0
* Restaurant2:Juliana's Pizza--------88.16964----------11.83036----------50.46440----------49.53560----------4.5 = 90.0
* Restaurant3:Numero 28 Pizzeria--90.60403----------09.39597----------71.75141----------28.24859----------4.5 = 90.0
* Restaurant4:Rubirosa--------------86.10805----------13.89195----------83.17073----------16.82927----------4.5 = 90.0
* Restaurant5:Capizzi----------------86.05928----------13.94072----------82.68293----------17.31707----------4.5 = 90.0            
## Conclusion

1) The visualizations and the results show that the lexicon analysis is approximately equal to the original readings stated on the website and not much change can be observed
2) But when the bigram analysis results are considered there is a considerable difference in the sentiment scores predicted and the original sentiment scores as per the website.


## Programming Language

R

## Tools/IDE

RStudio

