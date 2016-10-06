dot-files
=========

This repo holds my custom setting files.


Commands to remember
====================

mklink /H link source  
This makes a hard link on windows. I think it works since windows vista.

Example:
cd ~
mklink /H .bashrc code\dot-files\home\\.bashrc  
mkdir bin
mklink /H bin\tdiff.bat code\dot-files\bin\tdiff.bat
mklink /H bin\tcommit.bat code\dot-files\bin\tcommit.bat
