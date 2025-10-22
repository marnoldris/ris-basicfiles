#!/bin/bash

VENV_DIR=$1

echo "Creating directory $VENV_DIR..."
mkdir $VENV_DIR
python -m venv $VENV_DIR --upgrade-deps
source $VENV_DIR/bin/activate
python -m pip install spyder==5.5.6 numpy scipy pandas matplotlib sympy cython

cp ~/ris-basicfiles/spyder.ini ~/.config/spyder-py3/config/
