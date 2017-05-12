dir.create("data")
zipfile <- "data/Coursera-Swiftkey.zip"
if (!file.exists(zipfile)) download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", destfile = zipfile)
files_to_extract <- c("final/en_US/en_US.blogs.txt", "final/en_US/en_US.news.txt", "final/en_US/en_US.twitter.txt")
unzip(zipfile, files = files_to_extract, junkpaths = TRUE,  exdir = "data/extracted")

badwordsfile <- "data/bad-words.txt"
if (!file.exists(badwordsfile)) download.file("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt", destfile = badwordsfile)
