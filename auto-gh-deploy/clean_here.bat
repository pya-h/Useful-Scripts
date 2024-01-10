@echo off
setlocal enabledelayedexpansion
set exception=%1
set git_folder=.git
rem Get the current batch file name
set current_file=%~nx0
echo %exception%
echo %git_folder%
echo %current_file%

rem Remove all files except the current batch file and the exection file name passed to the script
for %%I in (*) do (
    if %%~nxI neq %current_file% (
        if %%~nxI neq %exception%  (
            del "%%I" /q
        )
    )
)

rem Remove all subdirectories except the current batch file and the exection file name passed to the script
for /d %%I in (*) do (
    if %%~nxI neq %current_file%  (
        if %%~nxI neq %exception%  (
            if %%~nxI neq %git_folder%  (
                rmdir "%%I" /s /q
            )
        )
    )
)

endlocal