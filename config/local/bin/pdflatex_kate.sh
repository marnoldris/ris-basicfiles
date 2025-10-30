#!/bin/bash

if ! grep -q '%\\printanswers' "$1"; then
    echo "'%\\printanswers' not found, replacing..."
    sed -i '/\\printanswers/c\%\\printanswers' "$1"
fi

pdflatex "$1"

rm *.log *.aux
