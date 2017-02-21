#!/bin/bash

# 2/21/17 ~JLM
# gathers metatdata and umps to metadata.txt file in the current diretory

#variables
FILE=metadata.txt

curl -w "\n" http://169.254.169.254/latest/meta-data/hostname > $FILE
curl -w "\n" http://169.254.169.254/latest/meta-data/iam/info >> $FILE
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups >> $FILE



