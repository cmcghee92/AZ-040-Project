$computer = "LON-SVR1"
$os = Get-CimInstance -classname Win32_OperatingSystem -ComputerName $computer

$cDrive = Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $computer -Filter "DeviceID='C:'"

$uptime = $os.LocalDateTime - $os.LastBootUpTime

$info = [PSCustomObject]@{
    ComputerName    = $computer
    OS              = $os.Caption
    LastBootUpTime  = $os.LastBootUpTime
    CDriveSize      = [math]::Round(($cDrive.Size / 1GB), 2)
    CDriveFreeSpace = [math]::Round(($cDrive.FreeSpace / 1GB), 2)
    CDriveFreeSpaceGB = [math]::Round(($cDrive.FreeSpace / 1GB), 2)
    UptimeHours = [math]::Round($uptime.TotalHours, 2)
}
Write-Output $info 