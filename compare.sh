#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - part only for comparison


if [ -z ${dropboxArchivesFolderName} ]
then    # situation, when file was directly executed by user
    source 'core.sh'
    echo 'Getting data for comparison from: '${actualDirectory}/${fileWithSummary}' . Press anything to continue or CTRL-C to end.'
    read -s
fi

rm $fileToDelete
touch $fileToDelete

moveToTrash()
{
    archiveToTrash=$1

    if [ ! -f ${trashFolder} ]
    then
        mkdir -p ${trashFolder}
    fi

    mv -f ${archiveToTrash} ${trashFolder}
}

showFilesForDelete()
{
    fileWithSummaryPath=$1
    filesToDeleteNumber=0

    cd ${dropboxArchivesFolderName}

    for archiveToCompare in $(find . -maxdepth 1 -type f | sed s/'\.\/'// | grep .${extension})
    do
        linesWithArchive=$(cat ${fileWithSummaryPath} | grep ${archiveToCompare} | wc -l)
        if [ ${linesWithArchive} == 0 ]
        then
            moveToTrash ${archiveToCompare}

            echo 'File to delete: '${archiveToCompare} >> ${actualDirectory}/${fileToDelete}
            ((filesToDeleteNumber++))
        fi
    done

    echo 'Number of files to delete: '$filesToDeleteNumber >> ${actualDirectory}/${fileToDelete}
    echo 'Number of files to delete: '$filesToDeleteNumber
}

showFilesForDelete ${actualDirectory}/${fileWithSummary}