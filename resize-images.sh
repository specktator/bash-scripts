#! /bin/bash
path=$1
sizes=("mobile:640" "tablet:1100") #EDIT THIS ARRAY to your liking!
# [ -z "$path" ] && echo "Empty"; exit 2;

echo -e "\nIn Path: $path"
echo -e "Resizing ... to mobile (640px)\n"
findings=`find $path -name "*.jpg" -o -name "*.png"`

for f in $findings
do
  for type in "${sizes[@]}"; do
    width=$(echo $type | awk -F: '{print $2}')
    device=$(echo $type | awk -F: '{print $1}')

    fdirectory="$(dirname $f)"
    filename="$(basename $f)"
    extention="${filename##*.}"
    targetFilename=$fdirectory"/"${filename%.*}"_"$device"_"$width"."$extention
    echo "Resizing: "$targetFilename
    # convert $f -resize $width $targetFilename
  done
done
exit 1;
