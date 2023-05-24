#!/bin/bash

VENV_DIR=$1

mkdir $VENV_DIR
python -m venv $VENV_DIR --upgrade-deps
source $VENV_DIR/bin/activate
python -m pip install spyder numpy scipy pandas matplotlib sympy cython

cp ~/basicfiles/spyder.ini ~/.config/spyder-py3/config/
