Clear-Variable $songPaths
Clear-Variable $arrayFromFile

#[string[]] $arrayFromFile = Get-Content -Path "E:\mkk\Playlists\PLs_Itunes\Beatles - Beatles for Sale.m3u"
[string[]] $arrayFromFile = Get-Content -Path "E:\mkk\Playlists\PLs_Itunes\50 Cent A.m3u"
#[string[]] $arrayFromFile = Get-Content -Path "C:\Users\PC\Desktop\pl_file.txt"

$playlists = @()
$songPaths = @()

$playlists = Get-ChildItem -Path "E:\mkk\Playlists\PLs_Itunes\"

foreach ($item in $playlists)
{
    $itemName = $item | % {$_.Name}
    $itemName = $itemName.replace(".m3u","")
    Write-Host $itemName
}

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
    $resultString = "C:/Users/PC/Desktop/pl_folder/${targetPathAndFile}"
 
    Write-Host $resultString
    Copy-Item -LiteralPath $element -Destination $resultString #-confirm 
}