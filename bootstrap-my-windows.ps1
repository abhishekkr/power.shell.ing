#!powershell -executionpolicy unrestricted -file
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

###############################################################################
#