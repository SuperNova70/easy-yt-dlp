#!/bin/bash
echo "
 /\_/\  
( o.o ) 
 > ^ <
"
# Define the character to use for the line
line_character="-"

# Define the length of the line
line_length=100

# Print the line
printf "%s\n" "$(printf "%${line_length}s" "$line_character" | tr ' ' "$line_character")"

# Printing the welcome message for the user
echo "Welcome User"
echo "This tool will make your life easier and help you to automate the downloading from different platforms.\n"

# Prompt the user to enter the YouTube URL
read -p "Please enter the YouTube URL: " youtube_url

# Check if the URL contains "list"
if [[ $youtube_url == *"list"* ]]; then
    # if url contain list ask user for other things
    echo "Your link is of a playlist!"
    echo "Do you want to continue downloading the whole playlist? (Y/N)"
    
    # Read the user's response and convert to uppercase
    read response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

    # Check if the response is valid
    if [[ "$response" == "Y" ]]; then 
        #then go with downloading the whole playlist
        echo "do u want in video formate or mp3 (V/M)" 
        read formate
        formate =$(echo "formate" | tr '[:lower:]' '[:upper:]')
        if [[ "$formate" == "V" ]]; then
        # excute command that will download in video formate
        yt-dlp --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" "$youtube_url"
        else 
        #excute command this to download in this formate
        yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 "$youtube_url"
        # Perform actions to download the whole playlist
        fi
    elif [[ "$response" == "N" ]]; then
        cleaned_url=$(echo "$youtube_url" | sed 's/\&list=.*/ /')
        echo "Downloading your song"
        echo "$cleaned_url"
    
        yt-dlp  --extract-audio --audio-format mp3 --audio-quality 0 "$cleaned_url"
        # Perform actions for not downloading the playlist
    else
        echo "Invalid input. Please enter Y or N."
    fi
else
    # If the URL does not contain "list", execute command B
    yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 "$youtube_url"
    # Place your command B here
fi