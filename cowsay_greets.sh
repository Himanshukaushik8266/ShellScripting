#!/bin/bash



for x in $(cat greets.txt);
do 
	cowsay "$x"
done
