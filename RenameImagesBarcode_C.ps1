#C:\BarcodeImages

$date = Get-Date -Format 'ddMMyyyy_hhmmss'
$folderpath = "C:\BarcodeImages\BarcodeFiles_${date}\"
New-Item -ItemType directory -Path $folderpath
$excelFile =  (Get-ChildItem -LiteralPath C:\BarcodeImages\ -Filter *.xls*).FullName

$excel = New-Object -Com Excel.Application
$wb = $excel.Workbooks.Open($excelFile)
$imageNames = @()
$barcodeNames = @()
for ($i = 1; $i -le $wb.Sheets.Count; $i++)
{
    $sh = $wb.Sheets.Item($i)
    #$endRow = $sh.UsedRange.SpecialCells($xlCellTypeLastCell).Row   
    $intRowMax = ($sh.UsedRange.Rows).count   
    for($intRow = 1 ; $intRow -le $intRowMax ; $intRow++)
    {
        $c1  = $sh.cells.item($intRow,1).value2
        $c2    = $sh.cells.item($intRow,2).value2      
        $imageNames += $c1
        $barcodeNames += $c2
    } 
}       
$excel.Workbooks.Close()
$excel.quit()
$files = Get-ChildItem -Path C:\BarcodeImages\* -Include *.jpeg, *.jpg, *.png, *.gif, *.bmp
foreach ($file in $files)
{
    $fileProps = Get-ItemProperty $file
    $counter = 0    
    foreach ($entry in $imageNames)
    {        
        $currentFileBaseName = $fileProps.BaseName
        $currentFilePath =  $fileProps.FullName
        if ($fileProps.BaseName -eq $entry)
        {
            $currentBarcode = $barcodeNames[$counter]
            Write-Host "${currentFileBaseName}_${currentBarcode}"         
            $destinationFileName = "${folderpath}\${currentBarcode}.jpg"
            Copy-Item -Path $currentFilePath -Destination $destinationFileName         
        }
        $counter = $counter + 1
    }
}