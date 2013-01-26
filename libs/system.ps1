# System
###############################################################################

function EXE-Cmd {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a EXE Path")]
    [Alias("cmds")] [string]
    $command
   )

  process {
    $pc_name = Get-Content env:computername
    $process = [WMICLASS]"\\$($pc_name)\ROOT\CIMV2:win32_process"
    $install = "cmd.exe /c $($command)"
    echo "Running... $ $($install)"
    $process.Create($install)
  }
}

###############################################################################
