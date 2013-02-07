# FileSystem Operations
###############################################################################

function Make-Dir {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("dir_pathname")] [string]
    $dir_path
    )

  process {
    $dir_path_split = $dir_path.split('\')
    $last_2    = $dir_path_split.length - 2
    $dir_root  = $dir_path_split[0..$last_2] -join "\"
    $dir_name  = $dir_path_split[-1]
    $cd_back_to = $pwd
    Set-Location $dir_root
    New-Item -name $dir_name -type directory -Force
    Set-Location $cd_back_to
  }
}

###############################################################################

function Create-Shortcut {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type path for Target")]
    [Alias("target")] [string]
    $target_path,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type link path")]
    [Alias("link")] [string]
    $link_path,

    [Parameter(Position=2,
    ValueFromPipeline=$true,
    HelpMessage="Please type arguments")]
    [Alias("args")] [string]
    $arguments
    )

  process {
    if(!(test-path $link_path) -and !(test-path $target_path)) {
      $WshShell = New-Object -ComObject WScript.Shell
      $shortcut = $WshShell.CreateShortcut( $link_path )
      $shortcut.TargetPath = $target_path
      $shortcut.Arguments = $arguments
      $shortcut.Description ="Shortcut to $target_path"
      $shortcut.Save()
    }
  }
}

###############################################################################
