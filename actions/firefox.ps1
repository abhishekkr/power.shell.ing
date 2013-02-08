# Firefox
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

############################################################################### Mozilla Firefox

function Firefox {
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
    echo "Downloading and Installing Firefox..."
  }

  process {
    $firefox_bin = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
    if(!(test-path $firefox_bin)){
      $firfox_url = "http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/18.0.1/win32/en-US/Firefox%20Setup%2018.0.1.exe"
      $firfox_file = "$($download_dir)\Firefox%20Setup%2018.0.1.exe"
      Download-URL $firfox_url $firfox_file
      EXE-Install $firfox_file "/S /runwgacheck"

      BANNER "Mozilla Firefox installed."
    } else {
      BANNER "Mozilla Firefox is already installed."
    }
    Create-Shortcut $firefox_bin "$($home_dir)\firefox.lnk"
  }
}

###############################################################################