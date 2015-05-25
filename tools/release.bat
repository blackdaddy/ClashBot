@SET SOURCE_DIR=..
@SET TARGET=ClashBot
@SET TARGET_DIR=ClashBot
@SET ZIP_7Z_FILE=7z\7z.exe
@SET VER=v6_0_7
@SET ARCHIVE_FILE_NAME=%TARGET%_%VER%.zip

rmdir /Q /S %TARGET_DIR%\
mkdir %TARGET_DIR%

xcopy %SOURCE_DIR%\curl %TARGET_DIR%\curl\ /E /Y
xcopy %SOURCE_DIR%\Icons %TARGET_DIR%\Icons\ /E /Y
xcopy %SOURCE_DIR%\images %TARGET_DIR%\images\ /E /Y
xcopy %SOURCE_DIR%\skins %TARGET_DIR%\skins\ /E /Y
xcopy ..\COCBot.dll %TARGET_DIR%\
xcopy ..\*.exe %TARGET_DIR%\

::============================================
:: Archive zip file..
::============================================
del /F/Q/S ..\release\%ARCHIVE_FILE_NAME%
%ZIP_7Z_FILE% a -tzip ..\release\%ARCHIVE_FILE_NAME% %TARGET_DIR%\

rmdir /Q /S %TARGET_DIR%\

pause