# Package Manager
###############################################################################
# Loading all shared PowerShell scripts

$fullPathIncFileName = $MyInvocation.MyCommand.Definition
$currentScriptName = $MyInvocation.MyCommand.Name
$shared_libs_dir = $fullPathIncFileName.Replace($currentScriptName, "")
$shared_libs = Get-ChildItem $shared_libs_dir
foreach ($shared_lib in $shared_libs) {
  . "$($shared_libs_dir)$($shared_lib)"
}

############################################################################### 
#

function DDL-EXE-Install {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_url")] [string]
    $download_url,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Download Path with Filename")]
    [Alias("ddl_path")] [string]
    $download_path,

    [Parameter(Position=2,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a local path to check if it already is present.")]
    [Alias("check_path")] [string]
    $binary_path,

    [Parameter(Position=3,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type any arguments need to be provided with Exe-Install")]
    [Alias("args")] [string]
    $exe_args
   )

  begin {
    echo "Downloading and Installing $($download_url)..."
  }

  process {
	if(!(test-path $binary_path )) {
	  Download-URL $download_url $download_path
	  EXE-Install $download_path $exe_args
	  BANNER "$($download_path) has been installed successfully."
	} else {
	  BANNER "$($download_path) is already installed."
	}
  }
}

###############################################################################

function DDL-MSI-Install {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_url")] [string]
    $download_url,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Download Path with Filename")]
    [Alias("ddl_path")] [string]
    $download_path,

    [Parameter(Position=2,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a local path to check if it already is present.")]
    [Alias("check_path")] [string]
    $binary_path
   )

  begin {
    echo "Downloading and Installing $($download_url)..."
  }

  process {
	if(!(test-path $binary_path )) {
	  Download-URL $download_url $download_path
	  MSI-Install $download_path
	  BANNER "$($download_path) has been installed successfully."
	} else {
	  BANNER "$($download_path) is already installed."
	}
  }
}

###############################################################################
