# GoogleChrome
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

############################################################################### Google Chrome

function GoogleChrome {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Saving Destination")]
    [Alias("home_path")] [string]
    $home_dir
   )

  begin {
    echo "Downloading and Installing Google Chrome..."
  }

  process {
    $chrome_bin = "$($env:userprofile)\AppData\Local\Google\Chrome\Application\chrome.exe"
    if(!(test-path $chrome_bin)){
      $chrome_url = "http://dl.google.com/chrome/win/63F332AB1465CEA8/25.0.1364.29_chrome_installer.exe"
      $chrome_file = "$($download_dir)\ChromeSetup25.0.1364.29.exe"
      Download-URL $chrome_url $chrome_file
      EXE-Install $chrome_file "/S /runwgacheck"

      BANNER "Google Chrome installed."
    } else {
      BANNER "Google Chrome is already installed."
    }
    Create-Shortcut $chrome_bin "$($home_dir)\chrome.lnk"
  }
}

###############################################################################