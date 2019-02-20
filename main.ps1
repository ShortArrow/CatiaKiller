$code = @'
    [DllImport("user32.dll")]
     public static extern IntPtr GetForegroundWindow();
'@
Add-Type $code -Name Utils -Namespace Win32
while (1) {
    $hwnd = [Win32.Utils]::GetForegroundWindow()
    Write-Host(Get-Process | 
            Where-Object { $_.mainWindowHandle -eq $hwnd } | 
            Select-Object processName, MainWindowTItle, MainWindowHandle).Tostring()
    Start-Sleep -Milliseconds 200
}