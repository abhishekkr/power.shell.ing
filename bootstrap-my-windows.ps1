#!powershell -executionpolicy unrestricted -file
###############################################################################
# Defaults

$root="C:\"
$home_dir_name = "ABK"

###############################################################################
# Loading all shared PowerShell scripts

$fullPathIncFileName = $MyInvocation.MyCommand.Definition
$currentScriptName = $MyInvocation.MyCommand.Name
$currentExecutingPath = $fullPathIncFileName.Replace($currentScriptName, "")

$shared_libs_dir = "$($currentExecutingPath)\actions\"
$shared_libs = Get-ChildItem $shared_libs_dir
foreach ($shared_lib in $shared_libs) {
  . "$($shared_libs_dir)$($shared_lib)"
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

###############################################################################
#