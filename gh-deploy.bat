@echo off
cls
echo !!Warning!! Evrything except the scripts will be removed here.
echo If you don't want this, just close this script immediately, otherwise:
pause
set this_bat_file=%~nx0
set clean_here_bat=clean_here.bat
call %clean_here_bat% %this_bat_file%
echo All files/folders here removed.
rmdir /s /q .git
echo:
echo -/ Possible git folder removed.

set /p username=Enter your git username:
set /p repo_name=Enter your repo name:
set origin=https://github.com/%username%/%repo_name%
echo Your origin is %origin%
git init
echo:
echo -/ Git folder initialized.
git remote add origin %origin%
echo:
echo -/ Your repo origin has been set.
echo %this_bat_file% >> .gitignore
echo %clean_here_bat% >> .gitignore
echo .gitignore >> .gitignore
echo:
echo -/ .gitignore file created.

git add .
git commit -m "Starting-out"
echo:
echo -/ Test commit done.

git branch gh-pages
echo:
echo -/ gh-pages branch created.
git checkout gh-pages
echo:
echo -/ gh-pages branch selected as current branch.

git rm -r *
echo:
echo -/ all possible previous files in gh-pages removed.
git commit -m "Clean-ghpages"
echo:
echo -/ changes commited till now.

set /p build_folder=Enter the path to your build folder:
xcopy %build_folder% . /E /H /C /I
echo:
echo -/ All files from your build folder copied here. Your git status is now:

git status
echo:
echo -/ Adding changes ...
git add .
echo:
echo -/ All changes added to git.

git commit -m "Project-built-files"
echo:
echo -/ All changes committed till here.

echo:
echo -/ Pushing to gh-pages ...
git push origin gh-pages
echo:
echo -/ Pushing done.
pause

