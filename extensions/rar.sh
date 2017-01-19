#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - management of files compressed with rar

# text displayed while testing archive, when examination of archive is started
testingArchiveText="Testing archive"

# text displayed while testing archive, when result of test is successful
testingArchiveSuccessText="All OK"

addFilesFromFolder()
{
    folderPath=$1
    directoryHash=$2

    find $folderPath -maxdepth 1 -type f -print0 | xargs -0 rar a -hp$password $directoryHash.rar >> ${actualDirectory}/${fileWithSummary}
}

addFile()
{
    archiveName=$1
    addedFile=$2

    rar a -hp$password ${dropboxArchivesFolderName}${archiveName}.rar ${addedFile} >> ${actualDirectory}/${fileWithSummary}
}

addEmptyFolder()
{
    folderPath=$1

    rar a -hp$password ${emptyFoldersArchiveName}.rar $folderPath
}

extractArchive()
{
    archiveToUnpack=$1	
    unpackFolderName=$2

    unrar x -p${password} $archiveToUnpack $unpackFolderName
}

testArchive()
{
    archiveToTest=$1

    unrar t -p${password} ${archiveToTest} >> ${actualDirectory}/${fileArchiveTests}
}