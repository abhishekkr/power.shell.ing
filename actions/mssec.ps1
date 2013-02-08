# MSSEC
###############################################################################
# Loading all shared PowerShell scripts

$fullPathIncFileName = $MyInvocation.MyCommand.Definition
$currentScriptName = $MyInvocation.MyCommand.Name
$currentExecutingPath = $fullPathIncFileName.Replace($currentScriptName, "")

$shared_libs_dir = "$($currentExecutingPath)..\libs\"
$shared_libs = Get-ChildItem $shared_libs_dir
foreach ($shared_lib in $shared_libs) {
  . "$($shared_libs_dir)$($shared_lib)"
}

############################################################################### MSSecurityEssentials

function MSSEC {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Saving Destination")]
    [Alias("home_path")] [string]
    $home_dir
   )

  begin {
    echo "Downloading and Installing MS Security Essentials..."
  }

  process {
    $running_mssec = Get-Process msseces -ErrorAction SilentlyContinue
    if($running_mssec -eq $null){
      $mssec_url = "http://go.microsoft.com/fwlink?LinkID=231277"
      $mssec_file  = $download_dir + "\" + "mseinstall.exe"
      Download-URL $mssec_url $mssec_file

      EXE-Install $mssec_file "/S /runwgacheck"
      BANNER "MSSEC is installed successfully."
    } else {
      BANNER "MSSEC is already installed."
    }
    Create-Shortcut "C:\Program Files\Microsoft Security Client\msseces.exe" "$($home_dir)\MSSecurityEssentials.lnk"
  }
}

###############################################################################