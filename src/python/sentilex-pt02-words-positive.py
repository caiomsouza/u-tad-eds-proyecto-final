# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 09:57:12 2016

@author: caiomsouza
"""

#import nltk
import codecs

def sentiLexFlexToDict():
  fileName = "/Users/caiomsouza/git/Bitbucket/u-tad/final-project/src/r-script/SentiLex-PT02/SentiLex-flex-PT02.txt"
  inputFile = codecs.open(fileName,"rb","utf-8")
  expressions = {}
  for line in inputFile:
        splitted = line.split(";")
        DicionarioAux = {}
        if(len(splitted[1].split('=')) == 1):
          DicionarioAux [splitted[1].split('=')[0]] = ''
        else:
          DicionarioAux [splitted[1].split('=')[0]] = splitted[1].split('=')[1] 
  
        DicionarioAux [splitted[2].split('=')[0]] = splitted[2].split('=')[1]
        DicionarioAux [splitted[3].split(':')[0]] = splitted[3].split(':')[1].split('=')[1]
  
        if (splitted[4].split('=')[0] == 'ANOT'):
          DicionarioAux [splitted[4].split('=')[0]] = splitted[4].split('=')[1]
        else:
          DicionarioAux [splitted[4].split('=')[0].split(':')[0] ] = splitted[4].split('=')[1]
        
        expressions[splitted[0].split(",")[0]] = DicionarioAux 
        expressions[splitted[0].split(",")[1]] = DicionarioAux
   
  return expressions #SentiLex-Flex em Dict



expressions =  sentiLexFlexToDict()

for key, value in expressions.iteritems():
    
    #print key, value['POL']    
    str = key
    
    # Replace .PoS=Adj from words
    key_clean = str.replace(".PoS=Adj", "")
    # Replace .PoS=N from words
    key_clean = key_clean.replace(".PoS=N", "")
    
        
    if value['POL'] == "1":   
        print key_clean.encode('utf8')



