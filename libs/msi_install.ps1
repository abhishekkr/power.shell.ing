# MSI-Install
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
