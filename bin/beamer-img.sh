#!/bin/sh
# Download image from clipboard via wget into current directory under sensible name. Copy beamer/tex snippet into clipboard that will paste the image.
# Dependencies:
#	xclip
#	wget
#	strings
image_url=$(xclip -selection clipboard -o)
normal_name=$(xclip -selection clipboard -o | rev | cut -d/ -f1)
if [ -f "$normal_name" ]; then
	temp_name=$(strings /dev/urandom | head -1)
	>&2 echo "An image with name $normal_name already exists. Saving as $temp_name."
	normal_name="$temp_name"
fi
wget "$image_url" -O "$normal_name" --no-check-certificate
echo "\\includegraphics[width=\\linewidth]{$normal_name}" | xclip -i -selection clipboard
