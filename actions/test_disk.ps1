# TestDisk
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

############################################################################### TESTDISK

function TestDisk {
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
    $home_dir,

    [Parameter(Position=2,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Where all your programs go?")]
    [Alias("applications_dir")] [string]
    $app_dir
   )

  begin {
    echo "Downloading and Installing TestDisk..."
  }

  process {
    $testdisk_win_bin = "$($testdisk_unzip)\$($testdisk_pkg)\testdisk_win.exe"
    if(!(test-path $testdisk_win_bin )) {
      $running_testdisk = Get-Process testdisk_win -ErrorAction SilentlyContinue
      $running_photorec = Get-Process photorec_win -ErrorAction SilentlyContinue
      if($running_testdisk -eq $null -and $running_photorec -eq $null){
        $testdisk_pkg = "testdisk-6.14-WIP"
        $testdisk_url = "http://www.cgsecurity.org/$($testdisk_pkg).win.zip"
        $testdisk_file = $download_dir + "\" + "$($testdisk_pkg).win.zip"
        Download-URL $testdisk_url $testdisk_file

        $testdisk_unzip = $app_dir + "\" + "TestDisk"
        UnZIP $testdisk_file $testdisk_unzip

        Create-Shortcut $testdisk_win_bin "$($home_dir)\testdisk_win.lnk"
        Create-Shortcut "$($testdisk_unzip)\$($photorec_win)\photorec_win.exe" "$($home_dir)\photorec_win.lnk"
        BANNER "TestDisk utilities can be accessed at $($home_dir)"
      } else {
        BANNER "TestDisk is already running. Close it and re-run this task to refresh it's setup."
      }
    } else {
      BANNER "TestDisk is already present."
    }
  }
}

###############################################################################