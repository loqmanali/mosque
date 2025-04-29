#!/bin/bash

# Create fonts directory if it doesn't exist
mkdir -p assets/fonts

# Download Cairo font files
curl -L "https://github.com/Gue3bara/Cairo/raw/master/fonts/ttf/Cairo-Regular.ttf" -o assets/fonts/Cairo-Regular.ttf
curl -L "https://github.com/Gue3bara/Cairo/raw/master/fonts/ttf/Cairo-Medium.ttf" -o assets/fonts/Cairo-Medium.ttf
curl -L "https://github.com/Gue3bara/Cairo/raw/master/fonts/ttf/Cairo-SemiBold.ttf" -o assets/fonts/Cairo-SemiBold.ttf
curl -L "https://github.com/Gue3bara/Cairo/raw/master/fonts/ttf/Cairo-Bold.ttf" -o assets/fonts/Cairo-Bold.ttf

echo "Font files downloaded successfully!" 