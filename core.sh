#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - core functionality, used by compression and extraction

source 'settings.sh'
source ${extensionsFolder}${extension}.sh

if [ ${dropboxFolderName} == "please_set_your_path" ]
then
    echo 'Folder to which compressed data are extracted and source for compression is not set! Please change value of variable in settings.sh:6 (with "/" on end!).'
fi

if [ ${dropboxArchivesFolderName} == "please_set_your_path" ]
then
    echo 'Folder where compressed archives are stored is not set! Please change value of variable in settings.sh:9 (with "/" on end!).'
fi

if [ ${dropboxFolderName} == "please_set_your_path" ] || [ ${dropboxArchivesFolderName} == "please_set_your_path" ]
then
    exit
fi

echo 'Write password for archives:'
read password
date
