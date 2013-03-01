# VLC
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

function VLC {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing VLC..."
  }

  process {
    $vlc_bin = "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe"
    if(!(test-path $vlc_bin)){
      $vlc_url = "http://fs32.filehippo.com/2316/2ef745e691b64698ac0e7f03828cef34/vlc-2.0.5-win32.exe"
      $vlc_file = "$($download_dir)\vlc-2.0.5-win32.exe"
      Download-URL $vlc_url $vlc_file

      EXE-Install $vlc_file "/S /runwgacheck"
      BANNER "VLC is getting installed."
    } else {
      BANNER "VLC is already installed."
    }
  }
}

###############################################################################