#! /bin/bash
# Syntax: watermark-images.sh /path/to/dir /path/to/dir /path/to/logo.png extention
if ([ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]); then
  cat <<EOF
# Usage: watermark-images.sh "path to source dir" "path to target dir" "path to watermark image" "extention"

EOF
exit
fi
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
