#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - part only for extraction


echo 'Krsc Compression Management - EXTRACTION'
source 'core.sh'

echo 'CAUTION: data in folder '$dropboxFolderName' can be overwritten! Press "Y" to proceed. Any other reply will terminate program.'
read answer

if [ $answer != 'Y' ]
then
    echo 'Program interrupted. No action was made'
    exit
fi

cd $dropboxArchivesFolderName

for archiveToUnpack in $( ls | grep \.${extension} )
do
    extractArchive $archiveToUnpack $dropboxFolderName
done
