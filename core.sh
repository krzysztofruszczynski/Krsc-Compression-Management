#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - core functionality, used by compression, extraction and testing

source 'settings.sh'

if [ ! -z ${1} ] && [ ${1} == "-s" ]
then
    if [ -f ${2} ]
    then
        source ${2}
        echo 'Default settings overwritten by '${2}' .'
    else
        echo 'File with custom settings not found. Default settings loaded.'
    fi
else
    echo 'Default settings loaded. If you want to load custom settings, use: "-s file_with_settings.sh" .'
    echo 'In your file with settings you can overwrite variables set in settings.sh .'
fi

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

if [ ! -f ${statisticsFolderName} ]
then
    mkdir -p ${statisticsFolderName}
fi

echo 'Folder to which compressed data are extracted and source for compression: '${dropboxFolderName}
echo 'Folder where compressed archives are stored: '${dropboxArchivesFolderName}
if [ ! -z ${incrementalFolder} ]
then
    echo 'Folder where incremental archives are stored: '${incrementalFolder}
fi
echo 'Write password for archives:'
read password
date
