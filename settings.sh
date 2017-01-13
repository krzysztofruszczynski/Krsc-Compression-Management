#!/bin/bash
# 2017 Krzysztof Ruszczyński ( https://github.com/krzysztofruszczynski )
# Krsc Compression Management - configuration part

# folder to which compressed data are extracted and source for compression (WITH / on end!)(CURRENT DATA CAN BE OVERWRITTEN, USE THAT WITH CAUTION) 
dropboxFolderName="please_set_your_path"

# folder where compressed archives are stored (WITH / on end!)
dropboxArchivesFolderName="please_set_your_path"

# folder where incremental archives are stored (if variable empty, than incremental copy is not made)
incrementalFolder=''

# name of subfolder in application folder where statistics regarding compression are stored
statisticsFolderName='stats/'

# name of file with summary about compression
fileWithSummary=${statisticsFolderName}"summary.txt"

# name of file with contents of archive testing
fileArchiveTests=${statisticsFolderName}"archive_tests.txt"

# name (with relative path) of files which are to be compressed
fileToArchive=${statisticsFolderName}"to_archive.txt"

# name (with relative path) of files in origin that were supposed to be compressed
fileLocation=${statisticsFolderName}"in_location.txt"

# name of files, which were unproperly managed during compression
fileIntegrity=${statisticsFolderName}"integrity.txt"

# name of folder in folder with archives (inside $dropboxArchivesFolderName), where file, which were unproperly managed are stored without compression
integrityFolderName="integrity/"

# flag, whether to add empty folders to compression ( 1 - yes, otherwise - no); if yes, they are added to archive with name as value from $emptyFoldersArchiveName
addEmptyFolders=1
emptyFoldersArchiveName='e'

# name of file with details of compressed content
contentArchiveName='c'

# name of extension, which is used (application will search for file with that name and extension sh in subfolder of application specified in $extensionsFolder
extension='rar'
extensionsFolder='extensions/'

# if encryption is used, only size of previous and current archive is compared ( 1 - yes, otherwise - no) (encrypted archive checksum differs also for the same content)
ifEncryptedCheckOnlySize=1 

# if set to 1, checkIntegrity method is executed (in seperate folder are placed all files, which were not compressed but should be - without encryption)
ifCheckingIntegrity=0

# getting into variable actual directory
actualDirectory=$(pwd)
