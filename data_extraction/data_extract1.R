library(rvest)
url <- paste0("https://www.tripadvisor.in/Restaurant_Review-g60827-d3741802-Reviews-Juliana_s_Pizza-Brooklyn_New_York.html")

reviews <- url %>%
  read_html() %>%
  html_nodes("#REVIEWS .innerBubble")

id <- reviews %>%
 html_node(".quote a") %>%
 html_attr("id")

quote <- reviews %>%
 html_node(".quote span") %>%
  html_text()

review <- reviews %>%
  html_node(".entry .partial_entry") %>%
  html_text()
df1 <-data.frame(id,quote,review, stringsAsFactors = FALSE)
for(i in 1:40)
{
url <- paste0("https://www.tripadvisor.in/Restaurant_Review-g60827-d3741802-Reviews-or",i,"0-Juliana_s_Pizza-Brooklyn_New_York.html#REVIEWS")

reviews <- url %>%
  read_html() %>%
  html_nodes("#REVIEWS .innerBubble")

id <- reviews %>%
 html_node(".quote a") %>%
 html_attr("id")

quote <- reviews %>%
 html_node(".quote span") %>%
  html_text()

review <- reviews %>%
  html_node(".entry .partial_entry") %>%
  html_text()
df2<-data.frame(id,quote,review, stringsAsFactors = FALSE)
df1 <- rbind(df1,df2)
}
write.table(df1,file="C:/Users/DELL LAPTOP/Sentiment-Analysis-TripAdvisor/data/restaurant2.csv",sep=",",row.names = F)