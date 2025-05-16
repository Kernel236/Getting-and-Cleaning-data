#Downlloading data from web

URL <- "https://example.net/getdata%2Fdata%2Fss06hid.csv"  #specifying the URL
download.file(URL, destfile = "housing.csv", method = "curl")  #downloading the file
db <- read.csv("housing.csv", stringsAsFactors = FALSE)  #reading the file
which(db$ACR == 3 & db$AGS == 6)


#Usinng jpeg package to read the image
URLimg <- "https://example.net/getdata%2Fjeff.jpg"  #specifying the URL
download.file(URLimg, destfile = "jeff.jpg", method = "curl")  #downloading the file

#Reading the image and calculating the quantiles
library(jpeg)
img <- readJPEG("jeff.jpg", native = TRUE)  #reading the file
quantile(img, c(0.3, 0.8))  #calculating the quantiles


URL3 <-  "https://example.net/getdata%2Fdata%2FGDP.csv"
download.file(URL3, destfile = "GDP.csv", method = "curl")  #downloading the file
gdp <- read.csv("GDP.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE)  #reading the file

URL4 <- "https://example.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(URL4, destfile = "EDSTATS_Country.csv", method = "curl")  #downloading the file
edstats <- read.csv("EDSTATS_Country.csv", stringsAsFactors = FALSE)  #reading the file

names(gdp)[1] <- "CountryCode"  #rename column X in gdb in CountryCode
names(gdp)[2] <- "Ranking"  #rename column X.1 in gdb in Ranking
merged_data <- merge(gdp, edstats, by = "CountryCode", all = TRUE)  #merging the data frames

merged_data$Ranking <- as.numeric(merged_data$Ranking)  #converting the Ranking column to numeric
sorted_data <- merged_data[order(merged_data$Ranking, decreasing = TRUE), ]  #sorting the data frame in descending order by GDP rank
sorted_data[13, c("CountryCode", "Ranking")]  #getting the 13th country in the resulting data frame
