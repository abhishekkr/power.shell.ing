# Package Manager
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

function MSI-Install {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a MSI Path")]
    [Alias("msi")] [string]
    $msi_file
   )

  process {
    $args = @(
            "/i"
            "`"$($msi_file)`""
            "/qn"
            "/norestart"
            )
    $process = Start-Process -FilePath msiexec.exe -ArgumentList $args -Wait -Passthru

    if( $process.ExitCode -eq 0 ){
      Write-Verbose "$msi_file got successfully installed."
    } else{
      Write-Verbose "$msi_file installation failed with ExitCode: $($process.ExitCode)."
    }
  }
}

###############################################################################
