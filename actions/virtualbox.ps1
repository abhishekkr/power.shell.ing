# VirtualBox-4.2.6
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

function VirtualBox {
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
    $virtualbox_bin = "C:\Program Files (x86)\VirtualBox-4.2.6-82870-Win"
    if(!(test-path $virtualbox_bin)){
      $virtualbox_url = "http://download.virtualbox.org/virtualbox/4.2.6/VirtualBox-4.2.6-82870-Win.exe"
      $virtualbox_file = "$($download_dir)\VirtualBox-4.2.6-82870-Win.exe"
      Download-URL $virtualbox_url $virtualbox_file

      EXe-Install $virtualbox_file "/s /runwgacheck"
      BANNER "Install VirtualBox-4.2.6 yourself in CUSTOM mode."
    } else {
      BANNER "VirtualBox-4.2.6 is already installed."
    }
  }
}

###############################################################################