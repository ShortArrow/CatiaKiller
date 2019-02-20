$TargetProcessName = "mspaint"
$Split = 10
$WaitTime = 15
$code = @'
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
'@
Add-Type $code -Name Utils -Namespace Win32
$Count = 0

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