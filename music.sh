#!/bin/bash

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
    # If the URL contains "list", execute command A
    echo "Your link is of a playlist!"
    echo "Do you want to continue downloading the whole playlist? (Y/N)"
    
    # Read the user's response and convert to uppercase
    read response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

    # Check if the response is valid
    if [[ "$response" == "Y" ]]; then
        echo "You entered yes"  

        # Perform actions to download the whole playlist
    elif [[ "$response" == "N" ]]; then
        cleaned_url=$(echo "$youtube_url" | sed 's/\&list=.*/ /')
        echo "Downloading your song"
        echo "$cleaned_url"
    
        yt-dlp --default-search --extract-audio --audio-format mp3 --audio-quality 0 "$cleaned_url"
        # Perform actions for not downloading the playlist
    else
        echo "Invalid input. Please enter Y or N."
    fi
else
    # If the URL does not contain "list", execute command B
    echo "URL does not contain 'list'. Executing command B..."
    # Place your command B here
fi