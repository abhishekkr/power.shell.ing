# JDK7u11
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

############################################################################### Oracle JDK 7u11

function JDK7u11 {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Oracle JDK 7u11..."
  }

  process {
    $jdk_bin = "C:\Program Files (x86)\jdk"
    if(!(test-path $jdk_bin)){
      $jdk_url = "http://download.oracle.com/otn-pub/java/jdk/7u11-b21/jdk-7u11-windows-x64.exe"
      $jdk_file = "$($download_dir)\jdk-7u11-windows-x64.exe"
      Download-URL $jdk_url $jdk_file

      EXe-Install $jdk_file "/S /runwgacheck"
      BANNER "Install JDK 7u11 yourself in CUSTOM mode."
    } else {
      BANNER "JDK 7u11 is already installed."
    }
  }
}

###############################################################################