#!powershell -executionpolicy Bypass -file
###############################################################################
# Defaults

$root="C:\"
$home_dir_name = "ABK"

###############################################################################
# Loading all shared PowerShell scripts

$fullPathIncFileName = $MyInvocation.MyCommand.Definition
$currentScriptName = $MyInvocation.MyCommand.Name
$bootstrap_currentExecutingPath = $fullPathIncFileName.Replace($currentScriptName, "")

$bootstrap_shared_libs_dir = "$($bootstrap_currentExecutingPath)actions\"
$bootstrap_shared_libs = Get-ChildItem $bootstrap_shared_libs_dir

foreach ($bootstrap_shared_lib in $bootstrap_shared_libs) {
  Write-Host "$bootstrap_shared_libs_dir"
  . "$($bootstrap_shared_libs_dir)$($bootstrap_shared_lib)"
}

###############################################################################
###############################################################################
# Action
###############################################################################
# FS

Set-Location $root
New-Item -name $home_dir_name -type directory -Force

Set-Location $home_dir
New-Item -name $download_dir_name -type directory -Force
New-Item -name $app_dir_name -type directory -Force

###############################################################################
# Installations

MSysGit $download_dir $home_dir
SublimeText $download_dir $home_dir $app_dir
TestDisk $download_dir $home_dir $app_dir
Python273 $download_dir $home_dir
MSSEC $download_dir $home_dir
ZoneAlarm $download_dir $home_dir
GoogleChrome $download_dir $home_dir
Firefox $download_dir $home_dir
JDK7u11 $download_dir
OpenOffice $download_dir
Putty $download_dir
Sandboxie $download_dir
VirtualBox $download_dir
ImgBurn $download_dir
FreeDownloadManager $download_dir
Pidgin $download_dir
Skype $download_dir
SpytBotSND $download_dir
FoxitReader $download_dir
VLC $download_dir
uTorrent $download_dir
UnLocker $download_dir
zip7zip $download_dir
Ruby193p362 $download_dir
SteamClient $download_dir
DDL-MSI-Install 'http://citylan.dl.sourceforge.net/project/hjt/2.0.4/HiJackThis.msi' "$($download_dir)\HiJackThis.msi" 'C:\Program Files\HijackThis'
###############################################################################
#
