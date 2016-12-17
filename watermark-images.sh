#! /bin/bash
# Syntax: watermark-images.sh /path/to/dir /path/to/dir /path/to/logo.png extention
sourcedir="$1"
targetdir="$2"
watermark="$3"
ext="$4"
imgs=$(find "$sourcedir" -name *.$ext -print)

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

if [ ! -d "$targetdir" ]; then
  mkdir "$targetdir"
fi
for i in $imgs; do
  composite -compose atop -gravity southeast -background none "$watermark" "$i" "$targetdir/$(basename $i)"
done
IFS=$SAVEIFS
