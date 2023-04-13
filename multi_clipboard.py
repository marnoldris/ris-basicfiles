#!/usr/bin/python

import pyperclip, sys

## Dictionary of predetermined text
text_outputs = {
    "1":
        """
        Text here
        """
    ,
    "2":
        """
        Text here
        """
    ,
    "3":
        """
        Text here
        """
    ,
    "4":
        """
        Text here
        """
    ,
    "5":
        """
        Text here
        """
    ,
    "6":
        """
        Text here
        """
    ,
    "7":
        """
        Text here
        """
    ,
    "8":
        """
        Text here
        """
    ,
    "9":
        """
        Text here
        """
    ,
    "0":
        """
        Text here
        """
    ,

}

pyperclip.copy(f'{text_outputs[sys.argv[1]]}')
