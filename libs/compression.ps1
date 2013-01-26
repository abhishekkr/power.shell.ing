# Compression

###############################################################################

function UnZIP {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("zip_file_name")] [string]
    $zip_file,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Saving Destination")]
    [Alias("unzip_dir_name")] [string]
    $unzip_dir
   )

  begin {
    echo "Un-Zipping $zip_file..."
  }

  process {
    MkDir $unzip_dir

    if(test-path($zip_file)){
      echo "$zip__file_name exists."
      $shell_application = new-object -com shell.application
      $shell_zip_file = $shell_application.NameSpace($zip_file)
      $shell_unzip_dir = $shell_application.NameSpace($unzip_dir)
# 0x10 OverWrite, 0x04 Hide Dialog,
      $shell_unzip_dir.Copyhere($shell_zip_file.Items(), 0x14)
    }
    else{
      echo "$zip_file file does not exist";
    }
  }

  end {
    echo "contents placed at $unzip_dir"
  }
}

###############################################################################
