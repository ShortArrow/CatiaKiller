@echo off
echo "ps1�t�@�C�������s���܂�"
pushd %~dp0
powershell -NoProfile -ExecutionPolicy Unrestricted "./unset-schedule.ps1"
pause > nul
exit