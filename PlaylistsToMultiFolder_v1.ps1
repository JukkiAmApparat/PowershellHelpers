Clear-Variable $songPaths
Clear-Variable $arrayFromFile

$playlists = Get-ChildItem -Path "E:\mkk\Playlists\PLs_Itunes\"

foreach ($item in $playlists)
{
    $itemName = $item | % {$_.Name}
    $itemPath = $item | % {$_.FullName}
    Write-Host $itemPath
    $itemName = $itemName.replace(".m3u","")
    $destinationFolder = "E:/pl_folder/${itemName}"
    New-Item -ItemType directory -Path $destinationFolder #-confirm
     
    [string[]] $arrayFromFile = Get-Content -Path $itemPath

    $playlists = @()
    $songPaths = @()

    foreach ($line in $arrayFromFile)
    {
        if ($line -like "*file*")
        {
            $correctedLine = $line.Substring(29)
            $correctedLine = "E:/mkk/${correctedLine}"
            $songPaths += $correctedLine
        }
    }

    foreach ($element in $songPaths)
    {  
        $targetPathAndFile =  $element.substring($element.lastIndexOf('/')+1)
        $resultString = "E:/pl_folder/${itemName}/${targetPathAndFile}"
        #Write-Host $resultString
        Copy-Item -LiteralPath $element -Destination $resultString #-confirm 
    }

}

