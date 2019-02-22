param (
    [switch]$Debug # オプション
)
$LogFile = "\\192.168.0.170\supersub\Public Space\Installer【インストーラ】\CAD\CAD CATIA\KILLER\$env:COMPUTERNAME.log"
Get-Date | Out-File -LiteralPath $LogFile -Append -Force
if ($Debug) {
    $TargetProcessName = "mspaint"
    $Split = 5
    $WaitTime = 5
}
else {
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
        if ($item.ProcessName -eq $TargetProcessName) {
            $TargetProcess = $item
        }
    }
    if ($ForeWindow.ProcessName -ne $TargetProcessName) {
        $Count++
        if ($Debug) {
            Write-Host "$Count : $($ForeWindow.ProcessName)"
        }
        else {
            Write-Output "$Count : $($ForeWindow.ProcessName)" | Out-File -LiteralPath $LogFile -Append -Force
        }
        if ($Count -eq $Split) {
            if ($Debug) {
                Write-Host "Let's Kill"
            }
            else {
                Write-Output "Let's Kill" | Out-File -LiteralPath $LogFile -Append -Force
                Get-Date | Out-File -LiteralPath $LogFile -Append -Force
            }
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
        if ($Debug) {
            Write-Host "$($ForeWindow.ProcessName) is Target"
        }
        else {
            Write-Output "$($ForeWindow.ProcessName) is Target" | Out-File -LiteralPath $LogFile -Append -Force
        }
    }
    Start-Sleep -Seconds ($WaitTime / $Split)
}

function fff {
    Start-Process .\test.html
}
