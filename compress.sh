#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - part only for compression

echo 'Krsc Compression Management - COMPRESSION'
source 'core.sh'

compareArchive()
{
    md5Archive=$( md5sum $1.${extension} | awk '{print $1;}' )
    archiveSize=$( wc -c < $1.${extension} )
    echo 'md5 for' $1.${extension} ' ('$2'):' $md5Archive >> ${actualDirectory}/${fileWithSummary}
            
    # check whether file with that name already exists in a folder: if yes, compare md5
    if [ -f ${dropboxArchivesFolderName}${1}.${extension} ]
    then
        md5OldArchive=$( md5sum ${dropboxArchivesFolderName}${1}.${extension} | awk '{print $1;}' )
        oldArchiveSize=$( wc -c < ${dropboxArchivesFolderName}${1}.${extension} )
    fi
      
    if [ ! -f ${dropboxArchivesFolderName}${1}.${extension} ] || [[ ${ifEncryptedCheckOnlySize} == 1 && ${archiveSize} != ${oldArchiveSize} ]] || [[ ${ifEncryptedCheckOnlySize} != 1 && ${md5Archive} != ${md5OldArchive} ]]
    then
        md5sum ${dropboxArchivesFolderName}${1}.${extension} >> ${actualDirectory}/${fileWithSummary}
        echo 'new archive: ' >> ${actualDirectory}/${fileWithSummary}
        mv -f ${1}.${extension} $dropboxArchivesFolderName
    else   
        echo 'no change in archive: '${md5OldArchive} >> ${actualDirectory}/${fileWithSummary}
        rm ${1}.${extension}
    fi
}

makeArchive()
{
    cd $dropboxFolderName
    cd "$1"
    # check if catalog is not empty - empty catalog has two lines (".." and ".")
    lines=$( ls -a | wc -l )
    directoryHash=$( echo -n $1 | md5sum | awk '{print $1;}' )
    
    if [ ${lines} != 2 ]
    then
        echo 'Adding catalog:'$1
        
        cd $dropboxFolderName

        if [ $(find $1 -maxdepth 1 -type f | wc -l) != 0 ]
        then
            find $1 -maxdepth 1 -type f >> ${actualDirectory}/${fileToArchive}
            echo '---------------' >> ${actualDirectory}/${fileWithSummary}
            
            addFilesFromFolder $1 $directoryHash
            compareArchive $directoryHash $1
        fi        
    else
        echo '---------------' >> ${actualDirectory}/${fileWithSummary}
        echo 'Empty catalog: '$1 >> ${actualDirectory}/${fileWithSummary}
        if [ ${addEmptyFolders} == 1 ]
        then    
            cd $dropboxFolderName
            addEmptyFolder $1
            echo 'Empty catalog archived' >> ${actualDirectory}/${fileWithSummary}	
            # compare at the end
        fi
    fi
	
}

clearStatistics()
{
    mv $fileWithSummary ${fileWithSummary}.bak
    touch $fileWithSummary

    rm $fileToArchive
    touch $fileToArchive

    rm $fileIntegrity
    touch $fileIntegrity

    rm $fileLocation
    touch $fileLocation

    date > $fileWithSummary # clear previous content
}

doSummary()
{
    cd $dropboxFolderName
    numberOfFilesToCompress=$(find . -type f | wc -l)
    find . -type f|sed s/'\.\/'// > ${actualDirectory}/${fileLocation}
    
    cd $actualDirectory
    numberOfCompressedFiles=$( cat $fileWithSummary | grep 'Adding    ' | wc -l )

    addFile ${contentArchiveName} ${fileWithSummary}
    
    echo 'Statistics:'
    echo 'Number of files to compress:' $numberOfFilesToCompress
    echo 'Number of files compressed:' $numberOfCompressedFiles
    date
    echo 'End of script'
}

checkIntegrity()
{
    mkdir ${dropboxArchivesFolderName}${integrityFolderName}
    cd ${actualDirectory}
    for lineWithFile in $( cat $fileLocation )
    do
      if [ $( cat $fileWithSummary | grep "${lineWithFile} " | wc -l ) == 0 ]
      then
          echo 'Missing file:'$lineWithFile >> $fileIntegrity
          cp ${dropboxFolderName}${lineWithFile} ${dropboxArchivesFolderName}${integrityFolderName}/
      fi
    done
    
    cp ${actualDirectory}$/${integrityFolderName}/${fileIntegrity} ${dropboxArchivesFolderName}/${fileIntegrity}
}

clearStatistics
cd $dropboxFolderName

oldIFS=$IFS
IFS=$'\n' # now space in file name is not breaking line

for directory in $(find . -type d|sed s/'\.\/'//) # get all catalogs 
do
    echo $directory
    makeArchive $directory
done

# comparing archive with empty folders (only if exists)
if [ -f ${emptyFoldersArchiveName}.${extension} ]
then
    compareArchive ${emptyFoldersArchiveName} $1
fi

doSummary

if [ ${ifCheckingIntegrity} == 1 ]
then
    checkIntegrity
fi

IFS=$oldIFS
