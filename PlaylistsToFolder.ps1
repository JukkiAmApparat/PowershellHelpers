$targetFolderName = "C:\temp\source"
$sourceFolderName = "C:\temp\target"

$imagesList = (
"C:\temp\source/en/headers/test1.png",
"C:\temp\source/fr/headers/test2png"
 )

[string[]] $arrayFromFile = Get-Content -Path "C:\Users\PC\Desktop\pl_file.txt"
Clear-Variable $songPaths
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

foreach ($element in $songPaths) {
	Write-Host $element
}

Write-Host $songPaths

foreach ($element in $songPaths) #$itemToCopy in $imagesList)
{
    $targetPathAndFile =  $element.Replace('E:/mkk/', 'C:/Users/PC/Desktop/pl_folder/')
    
    #$fullparentPath = (get-item $element).parent.parent #$targetPathAndFile = Split-Path $outputPath -leaf
    $tempPath = $element.substring(0, $element.lastIndexOf('/'))
    $replaceFolderString = $tempPath.substring($tempPath.lastIndexOf('/')) 
    $resultString = $targetPathAndFile.Replace($replaceFolderString,'') 
    
    Write-Host $resultString
    
    #$targetfolder = Split-Path $targetPathAndFile -Parent
    #
    ##If destination folder doesn't exist
    #if (!(Test-Path $targetfolder -PathType Container)) {
    #    #Create destination folder
    #    New-Item -Path $targetfolder -ItemType Directory -Force
    #}

    Copy-Item -Path $element -Destination $resultString #-confirm #"C:/Users/PC/Desktop/pl_folder" 
}