# Google Drive Backup Script

This script allows you to create backups of your current directory by compressing it into a ZIP file and then uploading it to a dedicated folder on Google Drive.
TBC: Find a way to call this file from any folder with an env variable.

## Current Status
**This project is still in development and not fully ready for production use.**

## Features
- **Backup Creation**: Compresses the current directory into a ZIP file.
- **Google Drive Integration**: Uploads the backup ZIP to a "BACKUP" folder on Google Drive.
- **Automatic Folder Creation**: If the "BACKUP" folder doesn't exist on your Google Drive, the script will create it.
- **Configuration Check**: The script checks for the existence of a Google Drive configuration file and prompts the user to configure it if necessary.

## Requirements
- **Google Drive Upload Tool**: This script uses the `gupload` tool to upload files to Google Drive.
  
### Installation Instructions
1. Install the `gupload` tool using the script's `install_gupload` function.
2. Make sure you have a `.googledrive.conf` configuration file. If not, follow the instructions in the link provided by the script.

## Usage
1. **Run the script**: Execute the script in the terminal.
2. The script will check if `gupload` is installed and install it if necessary.
3. The script will create a backup of your current directory by compressing it into a ZIP file.
4. The backup file will then be uploaded to your Google Drive's "BACKUP" folder.
5. If the `.googledrive.conf` file is missing, the script will prompt you to configure it, or it will guide you to the setup instructions.

### Example Run:
```bash
$ ./backup_script.sh
```
