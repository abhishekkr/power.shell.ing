# Google Drive
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

############################################################################### Google Drive

function GoogleDrive {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing google Drive..."
  }

  process {
    $gsync_bin = "C:\Program Files (x86)\Google\Drive\googledrivesync.exe"
    if(!(test-path $gsync_bin)){
      $gsync_url = "http://fs35.filehippo.com/3437/2480709d70e64efe8ac6e8ce466eb2e1/gsync.msi"
      $gsync_file = "$($download_dir)\gsync.msi"
      Download-URL $gsync_url $gsync_file

      MSI-Install $gsync_file
      BANNER "Install GoogleDrive yourself in CUSTOM mode."
    } else {
      BANNER "GoogleDrive is already installed."
    }
  }
}

###############################################################################