# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 09:57:12 2016

@author: caiomsouza
"""

#import nltk
import codecs

def sentiLexFlexToDict():
  fileName = "/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT01/SentiLex-flex-PT01.txt"
  inputFile = codecs.open(fileName,"rb","utf-8")
  expressions = {}
  for line in inputFile:

        splitted = line.split(";")

        if splitted[3].replace("POL=", "") == "1":
#            print splitted[0].split(",")[0] + ", " + splitted[3].replace("POL=", "")    
            print splitted[0].split(",")[0].encode('utf8')    

  return expressions

expressions =  sentiLexFlexToDict()