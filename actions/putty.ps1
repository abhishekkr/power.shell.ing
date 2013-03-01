# Putty
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

function Putty {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Putty..."
  }

  process {
    $putty_bin = "C:\Program Files (x86)\PuTTY\putty.exe"
    if(!(test-path $putty_bin)){
      $putty_url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.62-installer.exe"
      $putty_file = "$($download_dir)\putty-0.62-installer.exe"
      Download-URL $putty_url $putty_file

      EXE-Install $putty_file
      BANNER "Install Putty yourself in CUSTOM mode."
    } else {
      BANNER "Putty is already installed."
    }
  }
}

###############################################################################