# ZoneAlarm
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

############################################################################### ZoneAlarm

function ZoneAlarm {
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
    echo "Downloading and Installing Zone Alarm..."
  }

  process {
    $zonealarm_bin = "C:\Program Files (x86)\CheckPoint\ZoneAlarm\zatray.exe"
    if(!(test-path $zonealarm_bin)){
      $zonealarm_url = "http://download.zonealarm.com/bin/free/1001_za/zafwSetupWeb_110_000_038.exe"
      $zonealarm_file = "$($download_dir)\ZoneAlarmFreeFirewall2012.exe"
      Download-URL $zonealarm_url $zonealarm_file

      BANNER "Install ZONE ALARM yourself in CUSTOM mode."
    } else {
      BANNER "Unlocker is already installed."
    }
    Create-Shortcut $zonealarm_bin "$($home_dir)\zonealarm.lnk"
  }
}

###############################################################################