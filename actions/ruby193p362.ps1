# Ruby193p362
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

function Ruby193p362 {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Ruby193p362..."
  }

  process {
    $ruby193_bin = "C:\Ruby193\bin\irb.bat"
    if(!(test-path $ruby193_bin)) {
      $ruby193_url = "http://rubyforge.org/frs/download.php/76642/rubyinstaller-1.9.3-p362.exe" #p362
      $ruby193_file = "$($download_dir)\rubyinstaller-1.9.3-p362.exe"
      Download-URL $ruby193_url $ruby193_file

      EXE-Install $ruby193_file
      BANNER "Ruby193-p362 has been installed successfully."
    } else {
      BANNER "Ruby193-p362 is already installed."
    }
  }
}

###############################################################################