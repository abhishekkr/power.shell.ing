# uTorrent
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

function uTorrent {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing uTorrent..."
  }

  process {
    $uTorrent_bin = "C:\Program Files (x86)\uTorrent\uTorrent.exe"
    if(!(test-path $uTorrent_bin)){
      $uTorrent_url = "http://download.utorrent.com/3.2.3/uTorrent.exe"
      $uTorrent_file = "$($download_dir)\uTorrent.exe"

      Download-URL $uTorrent_url $uTorrent_file

      EXE-Install $uTorrent_file "/S /runwgacheck"
      BANNER "uTorrent is getting installed."
    } else {
      BANNER "uTorrent is already installed."
    }
  }
}

###############################################################################