dot-files
=========

This repo holds my custom setting files.


Commands to remember
====================

**Set up your home directory:**  
create it on c:\home  
set HOME user env variable with:  
setx HOME c:\home  
exit

**Setting up GitHub authentication**  
ssh-keygen -t rsa -b 4096 -C "your email address"  
start ~/.ssh  
open id_rsa.pub
copy paste the key to your github account


**Creating hard links from Bash:**  
cd dot-files  
ln home/.bashrc ~/.bashrc  
mkdir ~/bin  
ln bin/tdiff.bat ~/bin/tdiff.bat  
ln bin/tcommit.bat ~/bin/tcommit.bat  

**Creating hard links from cmd:**  
// from home dir  
mklink /H .bashrc code\dot-files\home\\.bashrc  
mkdir bin  
mklink /H bin\tdiff.bat code\dot-files\bin\tdiff.bat  
mklink /H bin\tcommit.bat code\dot-files\bin\tcommit.bat  

