@echo off
setlocal ENABLEDELAYEDEXPANSION

SET GITPATH=D:\GitHub\XInsurgency



ECHO ------------------------------------
ECHO Bash script is running
ECHO Variables:
ECHO  GITPATH = %GITPATH%
ECHO ------------------------------------
CD /d "%GITPATH%"
FOR /F %%f IN ('DIR /AD/B/D') DO (
	ECHO.
	ECHO.
	ECHO Handling %%f
	ECHO ------------------------------------
	SET FILE=%%f
	if "!FILE:~0,1!"=="." (
		echo Ignoring !FILE! because of the initial dot
	) else (
		IF EXIST "%GITPATH%\!FILE!\.COPYTOHERE" (
			ECHO "COPY CODEBASE TO '!FILE!'"
			xcopy /S "%GITPATH%\codeBase\*" "%GITPATH%\!FILE!\"
		)
	)
)

pause