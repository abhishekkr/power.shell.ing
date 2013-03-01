# FreeDownloadManager
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

function FreeDownloadManager {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing ~..."
  }

  process {
    $freedownloadmanager_bin = "C:\Program Files (x86)\Free Download Manager\fdm.exe"
    if(!(test-path $freedownloadmanager_bin)){
      $freedownloadmanager_url = "http://files.freedownloadmanager.org/fdminst.exe"
      $freedownloadmanager_file = "$($download_dir)\freedownloadmanager.exe"
      Download-URL $freedownloadmanager_url $freedownloadmanager_file

      EXE-Install $freedownloadmanager_file
      BANNER "Install Free Download Manager yourself in CUSTOM mode."
    } else {
      BANNER "Free Download Manager is already installed."
    }
  }
}

###############################################################################