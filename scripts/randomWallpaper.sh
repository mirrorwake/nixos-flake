#!/bin/bash

DIR=~/Pictures/locks
PICK=$(find "$DIR" -type f | shuf -n 1)
