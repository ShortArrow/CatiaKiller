if (Test-Path "C:\CatiaKiller"){
    Remove-Item "C:\CatiaKiller" -Force -Recurse
}
if (Test-Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\launch.lnk") {
    Remove-Item "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\launch.lnk" -Force
}
