#!/usr/bin/env bash

echo "Installing fonts locally"

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

cp *.ttf ~/.local/share/fonts/    
cp *.otf ~/.local/share/fonts/    
echo "Rebuilding cache... with fc-cache -f"
fc-cache -f
