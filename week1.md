# Tasks to accomplish

1. Obtaining the data - Can you download the data and load/manipulate it in R?
2. Familiarizing yourself with NLP and text mining - Learn about the basics of natural language processing and how it relates to the data science process you have learned in the Data Science Specialization.

# Questions to consider

* What do the data look like?
* Where do the data come from?
* Can you think of any other data sources that might help you in this project?
* What are the common steps in natural language processing?
* What are some common issues in the analysis of text data?
* What is the relationship between NLP and the concepts you have learned in the Specialization?

## Possible answers

You can extract different features from text for different tasks.
Most features begin with the words in the text.
Some possible actions you can do on text are:
a. Tokenization - breaking the text into words. Many methods here.
b. Normalization - e.g. stemming, lemmatization, plural->singular.
c. Spelling correction.
d. Synonym injection.
e. Combination - recording word combinations (n-grams).
f. Part of Speech Tagging.
g. Parsing.
h. Common words removal.
i. Named Entity and Key Phrase Extraction.
j. Capitalization pattern.

Other than that, you can also include metadata, e.g.
a. Who wrote the text.
b. When was it written.
c. Text length.
d. Context - other related text documents.
e. Genre.
f. Language(s) of the document.
g. HTML Links.
h. Page rank.

These lists are not exhaustive, but I believe they give some direction for further research. I suggest the following workflow for an NLP task:
a. Start with a task definition.
b. Collect initial data.
c. Go over the data and try to define features for the task.
d. Extract the features.
e. Run an algorithm.
f. Check the results.
g. iterate - go back to item b (sometimes even to item a).

## Ideas

### Spell correction

First pass will count every occurence of a lowercase word/feature (will increment the meta-data for 1st-cap and all-caps).
Once I get the vocabulary, I can compute the Levenhstein distance of each pair of words. After choosing a threshold
on a distribution graph (and probably removing shortest words), I can create a list of equivalent words which I will
replace by the most recurrent spelling. I can then apply my "spell correction" to condense the feature matrix. This
method can be applied on 2-grams directly.

### Tokenization

As I must predict the next word, I can get rid of some of the punctuation. Interrogation marks, coming only at the end 
of a sentence, will never be used for prediction. This is not true of apostrophes, commas, colons and semi-colons.
