# EXE-Install
###############################################################################

function EXE-Install {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a EXE Path")]
    [Alias("exe")] [string]
    $exe_file,

    [Parameter(Position=1,
    Mandatory=$false,
    ValueFromPipeline=$true,
    HelpMessage="Please type extra args")]
    [Alias("args")] [string]
    $extra_args
   )

  process {
    $pc_name = Get-Content env:computername
    $process = [WMICLASS]"\\$($pc_name)\ROOT\CIMV2:win32_process"
    if($extra_args -eq $null -or $extra_args -eq ""){
      $extra_args = "/i /x /install /ignorewarnings /doNotRequireDRMPrompt /s /silent /q /quiet /passive /v"
    }
    $install = "cmd.exe /c $($exe_file) $($extra_args)"
    echo "Running... $ $($install)"
    $process.Create($install)
  }
}
# if Fails try calling with custom $extra_args
# like EXE-Install $installer_exe_file "/S /runwgacheck"
###############################################################################
