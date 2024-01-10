#!/bin/bash
# Remove old revisions of snaps
# Close All snaps before running this
echo "removing unused apts ..."
apt autoremove -y
echo -n "remving apt cache..."
apt clean
echo " done;"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo -e; echo -n "removing snap cache..."
rm -rf /var/lib/snapd/cache/*

echo " done!"

echo "Removing old snap revisions:"

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
	while read snapname revision; do
		snap remove "$snapname"  --revision="$revision"
		echo "$snapname $revision removed."
	done
	
echo "All old revisions removed;"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - -"
home_dir=$(getent passwd "$SUDO_USER" | cut -d: -f6)
echo -e; echo -n "removing $home_dir/.cache folder in home...";
rm -rf "$home_dir"/.cache/*

echo " done;"
echo -e; echo -n "removing $home_dir/.npm/_cacache folder in home...";
rm -rf "$home_dir"/.npm/_cacache/*
echo " done;"

echo -e; echo -n "removing $home_dir/.gradle/caches folder in home...";
rm -rf "$home_dir"/.gradle/caches/*
echo " done;"
