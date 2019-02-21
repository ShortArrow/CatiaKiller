param(
    [string]$Prompt = '���b�Z�[�W',
    [string]$Title  = '�ʒm',
    $CallBack = ''
)

Add-Type -AssemblyName System.Windows.Forms, System.Drawing

function Show-NotifyIcon {
    param(
        [string]$Prompt = '���b�Z�[�W',
        [string]$Title  = '�ʒm',
        [scriptblock]$CallBack = {}
    )
    
    [Windows.Forms.NotifyIcon]$notifyIcon =
        New-Object -TypeName Windows.Forms.NotifyIcon -Property @{
            BalloonTipIcon  = [Windows.Forms.ToolTipIcon]::Info
            BalloonTipText  = $Prompt
            BalloonTipTitle = $Title
            Icon    = [Drawing.SystemIcons]::Information
            Text    = $Title
            Visible = $true
        }
    
    # �C�x���g��`
    $notifyIcon.add_BalloonTipClicked( $CallBack )
    
    [int]$timeout = 10 # sec

    [DateTimeOffset]$finishTime = 
        [DateTimeOffset]::UtcNow.AddSeconds( $timeout )

    $notifyIcon.ShowBalloonTip( $timeout )
    
    # ���̂܂܂��ƃC�x���g������Ȃ��������ɏ����Ă��܂��̂œK��wait
    while ( [DateTimeOffset]::UtcNow -lt $finishTime ) {
        Start-Sleep -Milliseconds 1
    }
    $notifyIcon.Dispose()
}

$parameters = $MyInvocation.BoundParameters
$parameters.CallBack = [scriptblock]::Create( $CallBack )
Show-NotifyIcon @parameters