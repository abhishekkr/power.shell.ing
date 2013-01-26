# Decorator
###############################################################################


function BANNER {
  param ( [Parameter(Position=0,
              Mandatory=$true,
              ValueFromPipeline=$true,
              HelpMessage="GIMME TEXT")]
            [string] $txt
          )

  begin {
    Write-Host "++++++++++++++++++++++++++++++++++++++++++++++++++" -ForegroundColor Blue
  }
  process {
    Write-Host $txt -ForegroundColor Yellow
  }
  end {
    Write-Host "++++++++++++++++++++++++++++++++++++++++++++++++++" -ForegroundColor Blue
  }
}

###############################################################################
