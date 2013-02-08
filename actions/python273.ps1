# Python273
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

############################################################################### Python273

function Python273 {
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
    echo "Downloading and Installing Python 2.7.3..."
  }

  process {
    $python273_bin = "C:\Python27\python.exe"
    if(!(test-path $python273_bin )) {
      $python273_url = "http://www.python.org/ftp/python/2.7.3/python-2.7.3.msi"
      $python273_file = "$($download_dir)\python-2.7.3.msi"
      Download-URL $python273_url $python273_file 

      MSI-Install $python273_file
      BANNER "Python 2.7.3 has been installed successfully."
    } else {
      BANNER "Python 2.7.3 is already installed"
    }
    Create-Shortcut $python273_bin "$($home_dir)\python273.lnk"
  }
}

###############################################################################