# SteamClient
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

function SteamClient {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Steam Client..."
  }

  process {
    $steam_bin = "C:\Program Files (x86)\Steam\Steam.exe"
    if(!(test-path $steam_bin )) {
      $steam_client_url = "http://cdn.steampowered.com/download/SteamInstall.msi"
      $steam_client_file  = $download_dir + "\" + "SteamInstall.msi"
      Download-URL $steam_client_url $steam_client_file

      MSI-Install $steam_client_file
      BANNER "Steam Client has been installed successfully. You need to backup/install required games yourself."
    } else {
      BANNER "Steam Client is already installed. You can backup/install required games."
    }
  }
}

###############################################################################