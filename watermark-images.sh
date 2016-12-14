#! /bin/bash
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
  # echo "sourcedir: $i"
  # echo "targetdir: $targetdir"
  # echo "target filename: $(basename $i)"
  # echo -e "$watermark" "$i" "$targetdir/$(basename $i) \n"
  composite -compose atop -gravity southeast -background none "$watermark" "$i" "$targetdir/$(basename $i)"
done
IFS=$SAVEIFS
