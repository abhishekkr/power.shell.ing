# Internet
###############################################################################

function Download-URL {
  param (
    [Parameter(Position=0,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a URL")]
    [Alias("url")] [string]
    $from_url,

    [Parameter(Position=1,
    Mandatory=$true,
    ValueFromPipeline=$true,
    HelpMessage="Please type a Saving Destination")]
    [Alias("file")] [string]
    $to_file
   )

   begin {
     echo "Downloading $url"
   }

   process {
     $url = New-Object System.Uri($from_url)
     $file = $to_file
     $file
     if (!(test-path $file)){
       (New-Object System.Net.WebClient).DownloadFile($url, $file)
     }
   }

   end {
     echo "Saved as $file"
   }
}

###############################################################################
