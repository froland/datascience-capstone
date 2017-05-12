library(tm)
library(readr)
library(cmscu)

lineCounter <- 0
ngram_1 <- new(FrequencyDictionary, 4, 2^26)

processLines <- function(lines, index) {
    for (line in lines) {
        lineCounter <<- lineCounter + 1
        sentences <- unlist(strsplit(line, '\\.'))
        for (sentence in sentences) {
            unigrams <- unlist(strsplit(line, ' '))
            ngram_1$store(unigrams)
        }
    }
}

contentFile <- "data/train/news.txt"
read_lines_chunked(contentFile, processLines)

print(lineCounter)
