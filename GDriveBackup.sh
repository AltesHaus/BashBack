#!/bin/bash

install_gupload() {
    if ! command -v gupload &> /dev/null; then
        echo "Installing gupload..."
        curl --compressed -Ls https://github.com/labbots/google-drive-upload/raw/master/install.sh | sh -s
        echo '[ -f "${HOME}/.google-drive-upload/bin/gupload" ] && [ -x "${HOME}/.google-drive-upload/bin" ] && PATH="${HOME}/.google-drive-upload/bin:${PATH}"' >> ~/.bashrc
        source ~/.bashrc
    fi
}

create_backup_zip() {
    backup_file_name="backup_$(date '+%Y-%m-%d_%H-%M-%S').zip"
    echo "Creating backup ZIP file: $backup_file_name"
    zip -r "$backup_file_name" ./*
    echo "$backup_file_name"
}

upload_to_drive() {
    local file="$1"
    local backup_folder="BACKUP"

    echo "Checking for existing BACKUP folder in Google Drive..."
    folder_id=$(gupload --list | grep "$backup_folder" | awk '{print $1}')

    if [ -z "$folder_id" ]; then
        echo "BACKUP folder not found. Creating new folder..."
        folder_id=$(gupload --create-folder "$backup_folder" | awk '{print $2}')
    fi

    echo "Uploading $file to Google Drive folder: $backup_folder"
    gupload --folder "$folder_id" "$file"
}

# Main script execution
install_gupload

backup_file=$(create_backup_zip)

if [ ! -f "${HOME}/.googledrive.conf" ]; then
    read -p "Do you already have a Gupload config file? (y/n): " conf
    if [ "$conf" == "y" ]; then
        read -p "Enter your file-path here (Format: /path/to/.googledrive.conf): " path
        gupload --config "$path" "$backup_file"
    else
        echo "Follow this tutorial to configure your credentials:"
        echo "https://labbots.github.io/google-drive-upload/setup/initial_setup/#enable-drive-api"
        exit 1
    fi
else
    upload_to_drive "$backup_file"
fi

# Remove the local ZIP file after uploading
echo "Removing local ZIP file: $backup_file"
rm "$backup_file"

echo "Backup completed successfully."
