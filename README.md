Krsc Compression Management
===========
This script allow you to easily make encrypted compressed copy of specified folder. Designed to be used with Dropbox to make your data more secure. Currently supports only rar, but can be easily extended to other compressors. Key features:<br/>
- content of every folder is made as separate archive
- empty folders are also inluded in copy
- structure of your folders is also anonymised
- only changed folders are copied to folder with archives; that implies, that your internet connection would only be used to upload data for folders, which have changed since last compression
- at the end of compression process you will see a summary, where you can see how many data were handled
- there is a seperate file "c.rar" where you have log from compression process. This can help you to locate archive with needed file in case you don't want to extract all files (for example using dropbox in browser 
- many settings, which can be customized ( see settings.sh )

Before you start
===========
Folder to which compressed data are extracted and source for compression is not set. Please change value of variable in settings.sh:6 (with "/" on end).<br/>
Folder where compressed archives are stored is not set. Please change value of variable in settings.sh:9 (with "/" on end).<br/>
If at least one of that parameter would not be set, application will notice you about that and terminate further action.

Usage
===========
If you want to compress data please use the command:
<pre>
./compress.sh
</pre>
If you want to extract data please use the command:
<pre>
./extract.sh
</pre>
Each time you would be requested for password (visible on the screen). Please take into the account, that extraction is made to the same folder, which is source for compression.
