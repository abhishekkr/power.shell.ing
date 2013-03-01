# OpenOffice.org
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

function OpenOffice {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir,
   )

  begin {
    echo "Downloading and Installing OpenOffice.org..."
  }

  process {
		$openofficeorg_bin = "C:\Program Files (x86)\OpenOffice.org 3\program\soffice.exe"
		if(!(test-path $openofficeorg_bin)){
		  $openofficeorg_url = "http://sourceforge.net/projects/openofficeorg.mirror/files/stable/3.4.1/Apache_OpenOffice_incubating_3.4.1_Win_x86_install_en-US.exe/download"
		  $openofficeorg_file = "$($download_dir)\Apache_OpenOffice_incubating_3.4.1_Win_x86_install_en-US.exe"
		  Download-URL $openofficeorg_url $openofficeorg_file

		  EXE-Install $openofficeorg_file "/S /runwgacheck"
		  BANNER "Install Apache_OpenOffice yourself in CUSTOM mode."
		} else {
		  BANNER "Apache_OpenOffice is already installed."
		}
  }
}

###############################################################################