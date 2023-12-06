#!/bin/bash

sed -e 's# / #\t#' \
    -e 's#^\(.*\) \([A-Z]\{2\}\) \([A-Z]\{3\}\) \([0-9]\{3\}\)$#\4\t\2\t\3\t\1#' \
    <names-independent-fixed.txt >names-independent.tsv

sed -e 's#^\(.*\) \([A-Z]\{2\}\) \([A-Z]\{3\}\) \([0-9]\{3\}\)\( > \)\?\(.\+\)\?$#\4\t\2\t\3\t\1\t\6#' \
    <names-other-fixed.txt >names-other.tsv
