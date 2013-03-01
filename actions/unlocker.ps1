# UnLocker
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

function UnLocker {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Unlocker..."
  }

  process {
    $unlocker_bin = "C:\Program Files\Unlocker\Unlocker.exe"
    if(!(test-path $unlocker_bin)){
      $unlocker_url = "http://www.emptyloop.com/unlocker/Unlocker1.9.1-x64.exe"
      $unlocker_file  = "$($download_dir)\Unlocker1.9.1-x64.exe"
      Download-URL $unlocker_url $unlocker_file
      EXE-Install $unlocker_file "/S /runwgacheck"

      BANNER "Unlocker installed."
    } else {
      BANNER "Unlocker is already installed."
    }
  }
}

###############################################################################