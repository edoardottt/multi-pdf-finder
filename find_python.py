#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec  9 21:00:15 2019

@author: edoardottt
https://edoardoottavianelli.it
"""

import sys,os
word = sys.argv[1]

def find(word):
    result = set()
    path = os.getcwd()+'/find_result'
    for file in os.listdir(path):
        with open(path+'/'+file) as f:
            text = f.read()
        if word.lower() in text or word.upper() in text:
            result.add(file)
    if len(result)==0:
        return 'Input not present.'
    return sorted(result)

print(find(word))