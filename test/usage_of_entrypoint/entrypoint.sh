#!/bin/bash

first_fun() {
    echo "Running first_fun...."
}

second_fun() {
    echo "Running second_fun...."
}

if [ "$1" = "first" ]; then
	first_fun
elif [ "$1" = "second" ]; then
	second_fun
else
    echo "Invalid option. Use 'first', 'second'."
    exit 1
fi
