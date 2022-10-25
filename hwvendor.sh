#!/bin/bash


is_apple=false

# Check if the computer is an Apple computer
if [[ $(hostnamectl | grep "Hardware Vendor" | awk '{print $3}') == "Apple" ]]; then
    is_apple=true
fi

echo $is_apple
