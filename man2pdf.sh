#!/usr/bin/env bash


# Convert Man Pages In Man Format To PDF Format With Bookmarks
#
# 31 May 2015
#
# Copyright (C) 2015 谷征雄 (rectigu@gmail.com, http://novicelive.org/)


temp_dir='_pdf'

test $# -eq 1 || exit 233

rm -rf $temp_dir || exit 233

for i in {1..8}
do
    for j in $1/man$i/*
    do
        mkdir -p $temp_dir || exit 233
        lc=$(wc -l < $j)
        if test $lc -lt 10
        then
            printf "%s %s\n" $lc $j
        else
            cat $j >> $temp_dir/man$i
        fi
    done
done

for k in $temp_dir/*
do
    pdfroff -m man --pdf-output=$k.pdf $k || exit 233
done

regex='(?<=\nNAME\n)[\/_a-zA-RT-Z](.+|.+\n)+(?=\n(SYNOPSIS|DESC|CONFIG|\.))'

for k in $temp_dir/*.pdf
do
    output=$(basename -s .pdf $k).pdf
    pdfbookmark $k -o $output -r $regex || exit 233
done
