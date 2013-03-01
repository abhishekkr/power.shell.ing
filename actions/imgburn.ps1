# ImgBurn
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

function ImgBurn{
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing ImgBurn..."
  }

  process {
    $imgburn_bin = "C:\Program Files (x86)\imgburn"
    if(!(test-path $imgburn_bin)){
      $imgburn_url = "http://download.imgburn.com/SetupImgBurn_2.5.7.0.exe"
      $imgburn_file = "$($download_dir)\SetupImgBurn_2.5.7.0.exe"
      Download-URL $imgburn_url $imgburn_file

      EXe-Install $imgburn_file "/S /runwgacheck"
      BANNER "Install ImgBurn yourself in CUSTOM mode."
    } else {
      BANNER "ImgBurn is already installed."
    }
  }
}

###############################################################################