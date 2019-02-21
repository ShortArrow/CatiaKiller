@echo off
echo "ps1ファイルを実行します"
pushd %~dp0
powershell -NoProfile -ExecutionPolicy Unrestricted "./unset-schedule.ps1"
pause > nul
exit