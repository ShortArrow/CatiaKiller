@echo off
echo "ps1�t�@�C�������s���܂�"
pushd %~dp0
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Unrestricted "./main.ps1"
pause > nul
exit