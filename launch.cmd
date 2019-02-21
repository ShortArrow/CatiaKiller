@echo off
echo "ps1ファイルを実行します"
pushd %~dp0
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Unrestricted "./main.ps1"
pause > nul
exit