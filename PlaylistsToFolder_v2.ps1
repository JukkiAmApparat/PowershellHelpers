Clear-Variable $songPaths
Clear-Variable $arrayFromFile
[string[]] $arrayFromFile = Get-Content -Path "E:\mkk\Playlists\PLs_Itunes\Beatles - Beatles for Sale.m3u"
#[string[]] $arrayFromFile = Get-Content -Path "E:\mkk\Playlists\PLs_Itunes\2Pac.m3u"
#[string[]] $arrayFromFile = Get-Content -Path "C:\Users\PC\Desktop\pl_file.txt"

$songPaths = @()

foreach ($line in $arrayFromFile)
{
    if ($line -like "*file*")
    {
        $correctedLine = $line.Substring(29)
        $correctedLine = "E:/mkk/${correctedLine}"
        Write-Host $correctedLine
        $songPaths += $correctedLine
    }
}

Write-Host $songPaths

foreach ($element in $songPaths)
{
    Write-Host $element
}

foreach ($element in $songPaths)
{
    #$targetPathAndFile =  $element.Replace('E:/mkk/', 'C:/Users/PC/Desktop/pl_folder/')
    
    $targetPathAndFile =  $element.substring($element.lastIndexOf('/'))
    $resultString = "C:/Users/PC/Desktop/pl_folder/${targetPathAndFile}"
    
    #$tempPath = $element.substring(0, $element.lastIndexOf('/'))
    #$replaceFolderString = $tempPath.substring($tempPath.lastIndexOf('/')) 
    #$resultString = $targetPathAndFile.Replace($replaceFolderString,'') 
    
    Write-Host $resultString
    Copy-Item -Path $element -Destination $resultString -confirm #"C:/Users/PC/Desktop/pl_folder" 
}
Write-Host $replaceFolderString