#!/bin/bash

printf '%s\t%s\t%s\t%s\t%s\n' Numeric Alpha-2 Alpha-3 Short Full >names-independent.tsv
sed -e 's# / #\t#' \
    -e 's#^\(.*\) \([A-Z]\{2\}\) \([A-Z]\{3\}\) \([0-9]\{3\}\)$#\4\t\2\t\3\t\1#' \
    -e 's#^[^\t]\+\t[^\t]\+\t[^\t]\+\t[^\t]\+$#&\t#' \
    <names-independent-fixed.txt >>names-independent.tsv

printf '%s\t%s\t%s\t%s\t%s\n' Numeric Alpha-2 Alpha-3 Name Country >names-other.tsv
sed -e 's#^\(.*\) \([A-Z]\{2\}\) \([A-Z]\{3\}\) \([0-9]\{3\}\)\( > \)\?\(.\+\)\?$#\4\t\2\t\3\t\1\t\6#' \
    <names-other-fixed.txt >>names-other.tsv
