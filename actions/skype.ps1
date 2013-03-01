# Skype
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

function Skype {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing Skype..."
  }

  process {
    $skype_bin = "C:\Program Files (x86)\Skype\Phone\Skype.exe"
    if(!(test-path $skype_bin)){
      $skype_url = "http://download.skype.com/052467f8a05ac588a5a956e332e6ac41/SkypeSetup.exe"
      $skype_file = "$($download_dir)\SkypeSetup.exe"
      Download-URL $skype_url $skype_file

      EXE-Install $skype_file
      BANNER "Install Skype yourself in CUSTOM mode."
    } else {
      BANNER "Skype is already installed."
    }
  }
}

###############################################################################