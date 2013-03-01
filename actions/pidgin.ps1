# Pidgin
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

function Pidgin {
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
    $pidgin_bin = "C:\Program Files (x86)\Pidgin\pidgin.exe"
    if(!(test-path $pidgin_bin)){
      $pidgin_url = "http://sourceforge.net/projects/pidgin/files/Pidgin/2.10.6/pidgin-2.10.6-offline.exe/download"
      $pidgin_file = "$($download_dir)\pidgin-2.10.6-offline.exe"
      Download-URL $pidgin_url $pidgin_file

      EXE-Install $pidgin_file "/S /runwgacheck"
      BANNER "Install Pidgin yourself in CUSTOM mode."
    } else {
      BANNER "Pidgin is already installed."
    }
  }
}

###############################################################################