# MSysGit
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

###############################################################################


function MSysGit {
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
    echo "Downloading and Installing MSysGit..."
  }

  process {
	$msysgit_bin = "C:\Program Files (x86)\Git\bin\sh.exe"
	if(!(test-path $msysgit_bin )) {
	  $msysgit_url = "https://msysgit.googlecode.com/files/Git-1.8.0-preview20121022.exe"
	  $msysgit_file = "$($download_dir)\Git-1.8.0-preview20121022.exe"
	  Download-URL $msysgit_url $msysgit_file
	  EXE-Install $msysgit_file
	  BANNER "MSYS GIT has been installed successfully."
	} else {
	  BANNER "MSYS GIT is already installed."
	}
  }

  end {
    Create-Shortcut "C:\Windows\SysWOW64\cmd.exe /c C:\Program Files (x86)\Git\bin\sh.exe" "$($home_dir)\git.lnk" "--login -i"
  }
}

###############################################################################