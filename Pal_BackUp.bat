@echo off
setlocal enabledelayedexpansion

:: 设置源文件夹和备份文件夹
set "sourceFolder=C:\Steam\steamapps\common\PalServer\Pal\Saved\SaveGames\"
set "backupFolder=C:\Pal_BackUp"

:: 获取当前日期和时间，格式化为YYYYMMDDHHMMSS
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set "currentDate=!datetime:~0,8!!datetime:~8,6!"

:: 设置备份文件名
set "backupFile=%backupFolder%\Backup_!currentDate!.zip"

:: 确保备份文件夹存在
if not exist "%backupFolder%" mkdir "%backupFolder%"

:: 创建压缩文件
powershell -command "Compress-Archive -Path '%sourceFolder%' -DestinationPath '%backupFile%'"

:: 删除除最新五个备份以外的所有备份
for /f "skip=5 delims=" %%A in ('dir "%backupFolder%\*.zip" /b /a-d /o-d') do del "%backupFolder%\%%A"

:: 完成备份
echo Backup completed successfully.

endlocal