# SublimeText
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

############################################################################### SUBLIMETEXT


function SublimeText {
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
    echo "Downloading and Installing MSysGit..."
  }

  process {

		$sublime_text_unzip = $app_dir + "\" + "SublimeText"
		$sublime_text_bin   = "$($sublime_text_unzip)\sublime_text.exe"
	  if(!(test-path $sublime_text_bin )) {
			$running_sublime_text = Get-Process sublime_text -ErrorAction SilentlyContinue
			if($running_sublime_text -eq $null){
			  $sublime_text_url = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1%20x64.zip"
			  $sublime_text_file  = $download_dir + "\" + "SublimeText_2.0.1x64.zip"
			  Download-URL $sublime_text_url $sublime_text_file

			  UnZIP $sublime_text_file $sublime_text_unzip

			  Create-Shortcut "$($sublime_text_unzip)\sublime_text.exe" "$($home_dir)\sublime_text.lnk"
			  BANNER "Sublime Text can be accessed at $($home_dir)"
			} else {
			  BANNER "Sublime Text is already running. Close it and re-run this task to refresh it's setup."
			}
		} else {
		  BANNER "Sublime Text is already present."
		}
	}
}
###############################################################################