#!/bin/sh

vim -c " q! " #-e -s -V1
vim -c "try | PlugInstall | q! | finally | q! | endtry" #-e -s -V1
