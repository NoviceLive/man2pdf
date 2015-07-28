#!/usr/bin/env bash


#
# Convert Man Pages In Man Format To PDF Format With Bookmarks
#
# Copyright 2015 Gu Zhengxiong <rectigu@gmail.com>
#


temp_dir='_build'

test $# -eq 1 || exit 233
rm -rf $temp_dir || exit 233
mkdir -p $temp_dir || exit 233


for i in {1..8}
do
    for j in "$1"/man$i/*
    do
        linecount=$(wc -l < $j)
        if test $linecount -lt 10
        then
            printf "%s %s\n" $linecount $j
        else
            cat $j >> $temp_dir/man$i
        fi
    done
done


for i in 32 64
do
    for j in $(grep -oP '__NR_\K.+\s' /usr/include/asm/unistd_$i.h)
    do
        if test -f "$1"/man2/$j.2
        then
            cat "$1"/man2/$j.2 >> $temp_dir/$i
        else
            printf "$i: NOT FOUND: %s\n" $j.2
        fi
    done
done


# for converting 32- and 64-bit syscall-number-ordered manual section 2
ln -srf "$1"/man2 man2
ln -srf "$1"/man3 man3

for k in $temp_dir/*
do
    pdfroff -m man --pdf-output=$k.pdf $k || exit 233
done

rm -f man2 man3


regex='(?<=\nNAME\n)[\/_a-zA-RT-Z](.+|.+\n)+(?=\n(SYNOPSIS|DESC|CONFIG|\.))'

for k in $temp_dir/*.pdf
do
    output=$(basename -s .pdf $k).pdf
    pdfbookmark $k -o $output -r $regex || exit 233
done


rm -rf $temp_dir || exit 233
