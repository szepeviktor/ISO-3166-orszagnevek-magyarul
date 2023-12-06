#!/bin/bash

cat names-independent.txt \
    | tr '\n' ' ' \
    | sed -e 's#[A-Z]\{2\} [A-Z]\{3\} [0-9]\{3\}#&\n#g' \
    | sed -s 's#^[ ,;]\+##' \
    >names-independent-fixed.txt

{
    LINE=""
    while read -r FRAGMENT; do
        if grep -qEw '[A-Z]{2}' <<<"${FRAGMENT}"; then
            echo "${LINE}"
            LINE="${FRAGMENT}"
        else
            LINE+=" ${FRAGMENT}"
        fi
    done <names-other.txt
    echo "${LINE}"
} >names-other-fixed.txt
