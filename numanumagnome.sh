#!/bin/bash
echo "Getting current gnome wallpapers..."

wallpaper_uri=$(gsettings get org.gnome.desktop.background picture-uri)
echo $wallpaper_uri

if which yt-dlp >/dev/null 2>&1; then
    echo "yt-dlp is installed. Ignore it."
else
    echo "yt-dlp is not installed."
    echo "Install it using yay..."
    yay -S yt-dlp-git
fi

if which mpv >/dev/null 2>&1; then
    echo "mpv is installed. Ignore it."
else
    echo "mpv is not installed."
    echo "Install it using pacman..."
    sudo pacman -S mpv
fi

if which xwinwrap >/dev/null 2>&1; then
    echo "xwinwrap is installed. Ignore it."
else
    echo "xwinwrap is not installed."
    echo "Install it using yay..."
    yay -S xwinwrap-git
fi

echo "Install source video..."
output_path="/tmp/temp_playback.webm"

if [[ -e $output_path ]]; then
    echo "File already exists at $output_path"
else
    yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o "$output_path" https://www.youtube.com/watch?v=Cqd1Gvq-RBY
fi


echo "Start this party?"
echo "Hit any key to continue... (Ctrl+C to exit)"
read
clear

for i in {3..1}; do
    echo "$i..."
    sleep 1
done

xwinwrap -fs -fdt -ni -b -nf -- mpv -wid %WID "$output_path"
clear
echo "Cleaning...."
rm "$output_path"
