# zip7zip
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

function zip7zip {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("ddl_path")] [string]
    $download_dir
   )

  begin {
    echo "Downloading and Installing 7zip..."
  }

  process {
    $zip7zip_bin = "C:\Program Files\7-Zip\7zFM.exe"
    if(!(test-path $zip7zip_bin)){
      $zip7zip_url = "http://sourceforge.net/projects/sevenzip/files/7-Zip/9.22/7z922-x64.msi/download"
      $zip7zip_file  = $download_dir + "\" + "7z922-x64.msi"
      Download-URL $zip7zip_url $zip7zip_file

      MSI-Install $zip7zip_file
      BANNER "7zip has been installed successfully. You need to backup/install required games yourself."
    } else {
      BANNER "7zip is already installed."
    }
  }
}

###############################################################################
