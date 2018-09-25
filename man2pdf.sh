#!/usr/bin/env bash


#
# Convert Man Pages In Man Format To PDF Format With Bookmarks
#
# Copyright 2015-2018 Gu Zhengxiong <rectigu@gmail.com>
#
# This file is part of man2pdf.
#
# man2pdf is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# man2pdf is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with man2pdf.  If not, see <http://www.gnu.org/licenses/>.
#


set -e
set -u


verbose() {
    >&2 echo "==> verbose: ${*}" && "${@}"
}


temp_dir='_man2pdf_build'


[[ $# -lt 1 ]] && exit 1
verbose rm -rf "$temp_dir"
verbose mkdir -p "$temp_dir"


printf '\n%s\n' "Start of files with limited lines:"
for i in {1..8}; do
    for j in "$1"/man$i/*; do
        [[ -d $j ]] && continue
        linecount=$(wc -l < "$j")
        if [[ $linecount -lt 10 ]]; then
            printf '%s (%s) ' "$(realpath --relative-to "$1" "$j")" "$linecount"
        else
            cat "$j" >> "$temp_dir/man$i"
        fi
    done
done
printf '\n%s\n\n' "End of files with limited lines."


for _bits in 32 64; do
    grep -oP '__NR_\K.+\s' "/usr/include/asm/unistd_$_bits.h" | while read -r _func; do
        if [[ -f "$1/man2/$_func.2" ]]; then
            cat "$1/man2/$_func.2" >> "$temp_dir/$_bits"
        else
            printf '%s: NOT FOUND: %s\n' "$_bits" "$_func.2"
        fi
    done
done


# For converting 32- and 64-bit syscall-number-ordered manual section 2.
verbose ln -srf "$1"/man2 man2
verbose ln -srf "$1"/man3 man3

for k in $temp_dir/*; do
    verbose pdfroff -m man --pdf-output="$k.pdf" "$k"
done

verbose rm -f man2 man3


regex='(?<=\nNAME\n)[\/_a-zA-RT-Z](.+|.+\n)+(?=\n(SYNOPSIS|DESC|CONFIG|\.))'

for k in $temp_dir/*.pdf; do
    output="$(basename -s .pdf "$k").pdf"
    verbose pdfmark "${@:2}" "$k" -o "$output" -r "$regex"
done


verbose rm -rf "$temp_dir"
verbose mkdir -p build && mv ./*.pdf build/
