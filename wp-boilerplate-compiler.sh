#! /bin/bash

# Rename all files and folders with the plugin name
realPluginName="$1"
pluginname=$(echo "$1" | sed "s/\s/-/g" | tr '[:upper:]' '[:lower:]')
classname=$([ ! -z "$2" ] && echo "$2" || echo echo "$pluginname" | sed "s/\s/_/g")
pluginURI="$3"
authorName="$4"
authorURI="$5"
authorEmail="$6"

if [ $# -eq 0 ]; then
	cat << EOF
Require:	Plugin boilerplate directory to be in the same folder with the script (Download link: https://github.com/DevinVinson/WordPress-Plugin-Boilerplate/archive/master.zip)
Usage:		$0 "Real Plugin Name" ClassPrefix "http://plugin-uri.net" "Author Name" "Author URI" "Author Email"
Example:	$0 "Ban Users" "Ban_Users" "http://banusers.net" "John Doe" "http://johndoe.com" "john@johndoe.com"

Description: 
	* Copies the boilerplate folder (plugin-name) and files to a folder named with your plugin name
	* Renames all files to your plugin name
	* Replaces all plugin headers to you liking eg. Author Name, Author Email, etc
	* Replaces and/or prefixes all functions, classes, variables and object names to your plugin name

EOF
fi

functionsAndVars=$(echo "$pluginname" | sed "s/-/_/g")
plugindir="$(find ../ -type d -name "plugin-name")"
rootpath="$(dirname $plugindir)"
newplugindir="$rootpath/$pluginname"

cat << EOF
Real 	Name:				$realPluginName
Plugin 	Name:				$pluginname
Plugin 	URI:				$pluginURI
Class,Package Name:			$classname
Functions and Variables:		$functionsAndVars
Author 	Name:				$authorName
Author 	URI:				$authorURI
Author	Email				$authorEmail
____________________________________

Plugin Folder:	$newplugindir

EOF

if [ ! -d "$newplugin" ]; then
	cp -R $plugindir $newplugindir
fi

if [ -d "$newplugindir" ]; then
	for i in $(find $newplugindir -type f -name "*plugin-name*" ) ; do
		II=$(echo $i | sed "s/plugin-name/$pluginname/g")
		mv $i $II
	done
fi

needles=("Plugin_Name#$classname" "plugin-name#$pluginname" "plugin_name#$functionsAndVars" "(Plugin Name:\s+)(.*)#\1$realPluginName" "(Plugin URI:\s+)(.*)#\1$pluginURI" "(Author:\s+)(.*)#\1$authorName" "(Author URI:\s+)(.*)#\1$authorURI" "(@author\s+)(.*)#\1$authorName <$authorEmail>" "(@link\s+)(.*)#\1$pluginURI")
for n in "${needles[@]}"; do
	needle=$(echo "$n" | awk -F# '{print $1}')
	replacement=$(echo "$n" | awk -F# '{print $2}')
	echo -e "Replacing $needle with $replacement ...\n"
	for i in $(grep -Ern "$needle" $newplugindir/* | awk -F: '{print $1}'); do
		sed -i -r "s%$needle%$replacement%g" $i
	done
done

echo -e "\nNew plugin boilerplate created at: $newplugindir"
