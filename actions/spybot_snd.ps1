# SpytBotSND
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

function SpytBotSND {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing SpyBot Search-n-Destroy..."
  }

  process {
    $spybot_bin = "C:\Program Files (x86)\Spybot - Search & Destroy 2\SDWelcome.exe"
    if(!(test-path $spybot_bin)){
      $spybot_url = "http://www.spybotupdates.com/files/SpybotSD2.exe"
      $spybot_file = "$($download_dir)\SpybotSD2.exe"
      Download-URL $spybot_url $spybot_file

      EXE-Install $spybot_file
      BANNER "Install SpybotSD2 yourself in CUSTOM mode."
    } else {
      BANNER "SpybotSD2 is already installed."
    }
  }
}

###############################################################################