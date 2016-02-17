==============================
Documentation on SentiLex-PT01
==============================

Contents
========
1. Introduction
2. SentiLex-PT01 characterization
3. Polarity distribution
4. Polarity assignment
5. Citing use of SentiLex-PT01
6. Licensing terms
7. Acknowledgments

1. Introduction
===============
SentiLex-PT01 is a sentiment lexicon for Portuguese made up of 6,321 adjective lemmas (conventionally, the masculine singular form), and 25,406 inflected forms. The sentiment entries correspond to human predicate adjectives (i.e. adjectives modifying human nouns), compiled from various publicly available resources. The sentiment attributes described in this linguistic resource concern (i) the predicate polarity, (ii) the target of sentiment and (iii) the polarity assignment. 

SentiLex-PT01 is especially useful for opinion mining applications involving Portuguese, in particular for detecting and classifying sentiments and opinions targeting human entities.


2. SentiLex-PT01 characterization 
=================================
SentiLex-PT01 is available in two separate .txt files, namely SentiLex-lem-PT01.txt and SentiLex-flex-PT01.txt.

In SentiLex-lem-PT01.txt, the entries are represented by a lemma (conventionally, the masculine singular form) and its part-of-speech (Adj), followed by the sentiment attributes described below:

* polarity (POL), which can be positive (1), negative (-1) or neutral (0);
* target of polarity (TG), which corresponds to a human subject (HUM);
* polarity annotation (ANOT), which was performed manually (MAN) or automatically, by the Judgment Analysis Lexicon Classifier (JALC), developed by the project team.

E.g.
bonito.POS=Adj; POL=1; TG=HUM; ANOT=MAN
desligado. POS=Adj; POL=-1; TG=HUM; ANOT=JALC

In SentiLex-flex-PT01.txt, the adjectives are inflected in gender (G) and number (N), which are associated to their corresponding lemma. In addition to the linguistic information described in dictionary of lemmas, in SentiLex-flex-PT01.txt each adjective is classified as masculine (m) or feminine (f) and singular (s) or plural (p).

E.g.
bonita,bonito. POS=Adj; GN=fs; POL=1; TG=HUM; ANOT=MAN
bonitas,bonito. POS=Adj; GN=fp; POL=1; TG=HUM; ANOT=MAN
bonito,bonito. POS=Adj; GN=ms; POL=1; TG=HUM; ANOT=MAN
bonitos,bonito. POS=Adj; GN=mp; POL=1; TG=HUM; ANOT=MAN


3. Polarity distribution
=======================
In SentiLex-PT01, 3,494 adjective lemmas have a negative polarity, 1.243 have a positive polarity, and 1.584 have a neutral polarity.


4. Polarity assignment
======================
3.585 adjectives were manually labeled by a linguist and 2.736 adjectives were automatically labeled. The JALC algorithm used has an overall accuracy of 67%. It is more precise in classifying negative adjectives (precision of 82%) than positive adjectives (67%). The most problematic cases involve neutral polarity, which is, in average, correctly assigned only in 45% of the cases.


5. Citing use of SentiLex-PT01
==============================
Mário J. Silva, Paula Carvalho, Carlos Costa, Luís Sarmento, Automatic Expansion of a Social Judgment Lexicon for Sentiment Analysis Technical Report. TR 10-08. University of Lisbon, Faculty of Sciences, LASIGE, December 2010. doi: 10455/6694


6. Licensing terms
==================
SentiLex-PT01 is licensed under a Commons Attribution 3.0 License (CC-BY). 


7. Acknowledgments
==================
SentiLex-PT01 was supported in part by the REACTION project and the FCT grants SFRH/BPD/45416/2008 and SFRH/BD/65972/2009, and it was developed by the following researchers:

* Mário J. Silva (University of Lisbon, Faculty of Sciences)
* Paula Carvalho(University of Lisbon, Faculty of Sciences)
* Luís Sarmento (University of Porto & SAPO Labs)
* Carlos Costa (University of Lisbon, Faculty of Sciences)