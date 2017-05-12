library(tm)
library(readr)

clean <- function(line) {
    str <- iconv(line, to = "UTF-8", sub = "")
    # inspired by http://davevinson.com/cmscu-tutorial.html
    str <- tolower(str)
    # strip-out control characters
    str <- gsub('[\u0001-\u001f]', '', str)
    # strip-out small html tags
    str <- gsub('<[^>]{1,2}>', '', str);
    # strip-out dash when not joining words
    str <- gsub('[[:space:]]?-+[[:space:]]', ' ', str)
    str <- gsub('[[:space:]]-+', ' ', str)
    # replace curly apostrophes
    str <- gsub('[\u0092\u2019]([a-z])', '\'\\1', str)
    # replace any terminal punctuation with a period
    str <- gsub('[[:space:]]*[.?!:;]+[[:space:]]*', '.', str)
    # replace any non-relevant character by a space (added accented chars for foreign languages inclusion)
    str <- gsub('[^\'a-zàéè .-]', ' ', str)
    # collapse whitespace
    str <- gsub('[[:space:]]+', ' ', str);
    # remove heading whitespace
    str <- gsub('^[[:space:]]', '', str)
    # make sure contraction's are "tight"
    str <- gsub(' ?\'', '\'', str);
    str <- gsub('([^s])\' ?', '\\1\'', str)
    # make sure terminal . are tight
    str <- gsub(' ?\\. ?', '.', str);
    return(str)
}

extractSets <- function(filetype) {
    
    totalLineCounter <- 0
    trainLineCounter <- 0
    validLineCounter <- 0
    testLineCounter <- 0
    
    contentFile <- file(paste0("data/extracted/en_US.", filetype, ".txt"), "rb", encoding = "UTF-8-BOM")
    if (!dir.exists("data/train")) dir.create("data/train")
    if (!dir.exists("data/test")) dir.create("data/test")
    if (!dir.exists("data/valid")) dir.create("data/valid")
    trainFile <- file(paste0("data/train/", filetype, ".txt"), "w+b")
    validFile <- file(paste0("data/valid/", filetype, ".txt"), "w+b")
    testFile <- file(paste0("data/test/", filetype, ".txt"), "w+b")
    
    processLines <- function(lines, index) {
        for (line in lines) {
            totalLineCounter <<- totalLineCounter + 1
            line <- clean(line)
            take <- rbinom(1, 1, .6) == 1
            if (take) {
                writeLines(line, trainFile)
                trainLineCounter <<- trainLineCounter + 1
            } else {
                take <- rbinom(1, 1, .5) == 1
                if (take) {
                    writeLines(line, validFile)
                    validLineCounter <<- validLineCounter + 1
                } else {
                    writeLines(line, testFile)
                    testLineCounter <<- testLineCounter + 1
                }
            }
        }
    }
    
    print(paste("Reading", filetype))
    
    read_lines_chunked(contentFile, processLines)
    
    print(paste(totalLineCounter, "lines read for", filetype, ":", trainLineCounter, "for training,", testLineCounter, "for testing and ", validLineCounter, "for validation"))
    
    close(contentFile)
    close(trainFile)
    close(validFile)
    close(testFile)
}

extractSets("blogs")
extractSets("news")
extractSets("twitter")
