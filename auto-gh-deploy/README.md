# Auto gh-pages Deploy Script + Remove All Here Script

I wrote this script to overcome some problems that will happen when trying to use gh-apges package in react or angular or etc.

* Just provide user git username and reponame, and the project built folder, and this script will do the rest.

* I wrote powershell scipt for now, but soon I will add linux bash script too.

* Also For preventing existing file cause problem while pushing, I wrote a second script,
    That will remove all the existing files in the folder, except for itself, .git folder (which will be handled in gh-deploy script),
    And a second file name that will be passed by param.

    So gh-deploy will start by calling the clean_here.bat file, providing its filename as parameter to prevent clean_here.bat remove gh-deploy script.