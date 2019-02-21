# Powershell version check
# PS version check
if (($PSversionTable.PSVersion.Major -lt 5)) {
    Write-Host "このバージョンのPowerShellには対応していません。`r`n" `
                + "Version 5 以上をインストールしてください。"
    exit
}
# Administrator authorization Check
# if (-not(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" ))) {
#     Write-Host "+++++++++ Administrator authorization is required +++++++++" -ForegroundColor White -BackgroundColor Red
#     Write-Host "Install failured!!"
#     Write-Host "You can close this window by anykey"
#     return
# }
New-Item "C:\CatiaKiller" -ItemType Directory -Force
Copy-Item "debug.cmd" "C:\CatiaKiller"
Copy-Item "launch.cmd" "C:\CatiaKiller"
Copy-Item "launch.lnk" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Copy-Item "main.ps1" "C:\CatiaKiller"
Copy-Item "toast.ps1" "C:\CatiaKiller"
Write-Host "Finish Install!!"