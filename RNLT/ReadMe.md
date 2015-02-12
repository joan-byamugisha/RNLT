RUNYAKITARA NATURAL LANGUAGE TOOLKIT (RNLT)

This toolkit contains several tools for performing various NLP tasks on Runyakitara, an indigenous Ugandan Language.
It is being availed here under the new General Public Licence for testing of the 1.0 version.
Most output messages are in Runyakitara.
A lot more functionality as described below is available to programmers who may wish to use the tool,
and the javadoc will be included in later versions in order to guide them.
Also, the corpus used by this current version is very very small and may in some cases affect the results.
However, future versions will solve this problem.

In order to use the tool as is, follow the instructions below on how to access each tool:

## The Language Classifier:

This is based on the Multinomial Naíve Bayes classifier and
supports three languages: Luganda, Kiswahili, and Runyakitara.
Due to the limited number of digital documents translated in all three languages to aid in classification,
the training set for this classifier is very very small.
Future versions will improve upon this.

java RNLT LanguageClassifier classify.txt
where "classify.txt" is the file whose language is to be determined
One also has the option to pass several file names as arguments:
java RNLT LanguageClassifier classify1.txt classify2.txt classify3.txt classify4.txt

One can also refer to the specific classifier tool as below:
java r.nlt.classify.LanguageClassifier classify.txt

## Concordance:

This enables one to obtain the context in which a word or phrase is used in Runyakitara.
The Orumuri corpus is the source of the information.

1. to specify a different corpus other than the default:
java RNLT Concordance omuntu corpus
or to access the concordance tool directly
java r.nlt.concordance.Concordance omuntu corpus

2. to use the default corpus
java RNLT Concordance omukazi ""
or to access the concordance tool directly
java r.nlt.concordance.Concordance omukazi ""

## The N-Gram Model:

This class enables one to obtain unigrams, bigrams, trigrams, ... n-grams from the Orumuri corpus.
Basic usage is as below:

java RNLT NGramModel 3 "" output 50
where:
"3" is the number of grams to get (n);
"" is the default corpus to be used (another file can be specified here instead);
"output" is the directory to which the output will be written; and
"50" dictates that the n-gram should exist in the corpus at least 50 times (frequency) in order to be considered.

or to access the tool directly:
java r.nlt.ngrams.NGramModel 5 data\\corpus.txt output 4

Programmers can additionally create objects and use methods in this class to get the count and probability distribution of a specific n-gram from the corpus.
Programmers can also use this class to obtain the most likely n-gram(s) given sample input.
the soon to be released javadoc will describe how to do this.

## The Tagged Named-Entity Extractor:

This class enables one to extract the tagged entities, placing each tag category in its own output file.
For example, all entities tagged "PERSON," "LOCATION," "ORGANIZATION," and "MISC" are saved
in "Persons.txt," "Locations.txt," "Organizations.txt," and "Misc.txt" files respectively.
One has the option of whether to include the preceeding and proceeding "O" tagged words; this can help to identify possible features of an entity.

Usage:
java RNLT TaggedEntityExtractor ner.txt false false output
or to access the tool directly:
java r.nlt.ner.TaggedEntityExtractor ner.txt false false output
where:
"ner.txt" is a file with tagged data;
"false" implies that preceeding words with "O" tags will be ignored; "true" is the opposite;
"false" implies that proceeding words with "O" tags will be ignored; "true" is the opposite; and
"output" is the directory to where the entity files will be written

Consider the effects below:
The sentence
Purezidenti/O wa/O South/B-LOCATION Sudan/I-LOCATION ni/O Salva/B-PERSON Kiir/I-PERSON ./O
would result in the following different outputs for the different options of whether to include preceeding and/or proceeding "O" tagged words
(punctuation marks are ignored):

java RNLT TaggedEntityExtractor tagged.txt true true output
output:
wa South Sudan ni
ni Salva Kiir

java RNLT TaggedEntityExtractor tagged.txt true false output
output:
wa South Sudan
ni Salva Kiir

java RNLT TaggedEntityExtractor tagged.txt false true output
output:
South Sudan ni
Salva Kiir

java RNLT TaggedEntityExtractor tagged.txt false false output
output:
South Sudan
Salva Kiir

## The Bigram Segmentor:

java RNLT WordSegmentor abaanaboona
or to use the tool directly:
java r.nlt.segmentor.WordSegmentor abaanaboona

Future versions will expand this to support n-grams,
and it will also be included as part of the functionality of the spell checker.

## The Spell Checker:

This spell checker is based on the four operations of edit distance,
namely: delete, insert, substitute, and transpose.
Only options of edit distances 1 and 2 are considered.

Usage:
java RNLT SpellChecker spell.txt
or to use the tool directly:
java r.nlt.spellchecker.SpellChecker spell.txt
where":
"spell.txt" is the file whose contents' spellings are to be checked.
It will result in the creation of a new file with a "-spell checked" added to the original file name.

The RNLT also has a util package which has classes that are relied upon by the other tools,
and can also be used in isolation by programmers to perform specific tasks as below:

** Token class:

This class contains methods for investigating and changing the structure of a token.
Specifically, this class does the following:
1. obtains the tag of a token (if a tag is present);
2. removes the tag of a token (if a tag is present);
3. checks whether a token has: a tag, an old tag, a proper tag, an entity tag (any tag but "NA" or "O");
4. checks whether a token has a person, misc, location, organization, or other ("NA" or "O") tag;
5. checks whether a token is a punctuation mark or a word with a punctuation mark;
6. checks whether a token has a next token (or a next token with a tag) in an ArrayList;
7. checks whether a token has a previous token (or a previous token with a tag) in an ArrayList; and
8. checks whether a token has a specified prefix or surfix.

This class is unlikely to be used by non-programmers of this tool.
Work on availing the javadoc to programmers is ongoing.

** ConvertToProperTags class:

This class can be used to convert basic NER tags (BP, IP, BO, IO, BL, and IL)
to better tags (B-PERSON, I-PERSON, B-ORGANIZATION, I-ORGANIZATION, B-LOCATION, and I-LOCATION respectively, as well as MISC and O).
This can assist in the preprocessing tasks of the training data before Named-Entity Recognition is to be carried out.

Usage:
java r.nlt.util.ConvertToProperTags old.txt new.txt
where:
"old.txt" is the file with improper tags
"new.txt" is the file to which the converted output will be written

** PrepTrainAndTestFiles class:

This class can be used to preprocess training and test files for use in a NER
or POS tagger by ensuring that their contents are in the format below:
For training files:
Kampala B-LOCATION
ni O
disiturikiti O
ya O
Uganda B-LOCATION
. O

For test files:
Mugisha
n'omuntu
murungi
.

When preparing a training file:
java r.nlt.util.PrepTrainAndTestFiles --train unpreped.txt preped.txt
When preparing a test file:
java r.nlt.util.PrepTrainAndTestFiles --test unpreped.txt preped.txt
where:
"unpreped.txt" is the file name whose contents are to be processed;
"preped.txt" is the file name to which the output will be written
