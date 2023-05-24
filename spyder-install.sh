#!/bin/bash

VENV_DIR=spyder-test-venv

mkdir $VENV_DIR
python -m venv $VENV_DIR
source $VENV_DIR/bin/activate
python -m pip install spyder numpy scipy pandas matplotlib sympy cython
python -m pip install --upgrade $(pip freeze)

cp ~/basicfiles/spyder.ini ~/.config/spyder-py3/config/
