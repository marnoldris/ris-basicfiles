#!/bin/bash

sed -i '/\\printanswers/c\\\\printanswers' "$1"

file="$1"
filename="${file%.*}"
#extension="${file##*.}"

output_file="${filename}_KEY"

pdflatex -jobname="$output_file" "$1"

sed -i '/\\printanswers/c\%\\printanswers' "$1"

rm *.log *.aux
