#!/bin/bash
# Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - part only for testing

echo 'Krsc Compression Management - TESTING'
source 'core.sh'

rm $fileArchiveTests
touch $fileArchiveTests

cd ${dropboxArchivesFolderName}

for archiveToTest in $(find $1 -maxdepth 1 -type f | grep .${extension})
do
    testArchive ${archiveToTest}
done

echo 'Tests made. See results here: '${actualDirectory}/${fileArchiveTests}

numberOfArchiveTested=$( cat ${actualDirectory}/${fileArchiveTests} | grep "${testingArchiveText}" | wc -l )
numberOfCorrectArchives=$( cat ${actualDirectory}/${fileArchiveTests} | grep "${testingArchiveSuccessText}" | wc -l )

echo 'Number of archives tested: '${numberOfArchiveTested}
echo 'Number of correct archives: '${numberOfCorrectArchives}