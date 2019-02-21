param (
    [switch]$Debug # ƒIƒvƒVƒ‡ƒ“
)
if ($Debug) {
    $TargetProcessName = "mspaint"
    $Split = 5
    $WaitTime = 5
}else {
    $TargetProcessName = "CNEXT"
    $Split = 90
    $WaitTime = 900
}
$code = @'
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
'@
Add-Type $code -Name Utils -Namespace Win32
$Count = 0
$TargetProcess = $null
while (1) {
    $hwnd = [Win32.Utils]::GetForegroundWindow()
    $ProsessList = Get-Process
    foreach ($item in $ProsessList) {
        if ($item.MainWindowHandle -eq $hwnd) {
            $ForeWindow = $item
        }
    }
    if ($ForeWindow.ProcessName -ne $TargetProcessName) {
        $Count++
        Write-Host "$Count : $($ForeWindow.ProcessName)"
        if ($Count -eq $Split) {
            Write-Host "Let's Kill"
            if ($null -ne $TargetProcess) {
                $TargetProcess.CloseMainWindow()| Out-Null
                $TargetProcess = $null
                . .\toast.ps1 "CATIA was not used for a while!" "CATIA KILLER"
            }
            $Count = 0 
        }
    }
    else {
        $Count = 0
        $TargetProcess = $ForeWindow
        Write-Host "$($ForeWindow.ProcessName) is Target"
    }
    Start-Sleep -Seconds ($WaitTime / $Split)
}

function fff {
    Start-Process .\test.html
}
