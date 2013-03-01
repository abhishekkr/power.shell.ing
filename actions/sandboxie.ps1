# Sandboxie
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

############################################################################### ~

function Sandboxie {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Sandboxie..."
  }

  process {
    $sandboxie_bin = "C:\Program Files\Sandboxie\Start.exe"
    if(!(test-path $sandboxie_bin)){
      $sandboxie_url = "http://www.sandboxie.com/SandboxieInstall.exe"
      $sandboxie_file = "$($download_dir)\Sandboxie.exe"
      Download-URL $sandboxie_url $sandboxie_file

      EXe-Install $sandboxie_file "/S /runwgacheck"
      BANNER "Install Sandboxie yourself in CUSTOM mode."
    } else {
      BANNER "Sandboxie is already installed."
    }
  }
}

###############################################################################