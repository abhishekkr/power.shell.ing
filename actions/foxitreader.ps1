# FoxitReader
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

function FoxitReader {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Foxit Reader..."
  }

  process {
    $foxit_bin = "C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe"
    if(!(test-path $foxit_bin)){
      $foxit_url = "http://cdn04.foxitsoftware.com/pub/foxit/reader/desktop/win/5.x/5.4/enu/FoxitReader545.0114_enu_Setup.exe"
      $foxit_file = "$($download_dir)\FoxitReader545.exe"
      Download-URL $foxit_url $foxit_file

      EXE-Install $foxit_file
      BANNER "Install FoxitReader yourself in CUSTOM mode."
    } else {
      BANNER "FoxitReader is already installed."
    }
  }
}

###############################################################################