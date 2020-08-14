#!/usr/bin/env bash

#################################################################
#                                                               #
#  Download all files from a site that has directory browsing   #
#                                                               #
#                                                               #
#################################################################

mkdir tick-workspace
cd tick-workspace
wget --limit-rate=800k --no-parent -r $1
tar czvf archive-tick_$(date +%Y%m%d%H%M%S%N).tgz ./*
cd ..
