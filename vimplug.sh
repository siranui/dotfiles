#!/bin/sh

vim -c "try | PlugUpdate | q! | finally | q! | endtry" #-e -s -V1
