# splits .xslx to .csv files
# pretty much straight from: https://zeleskitech.com/2014/10/26/convert-xlsx-csv-powershell/

Function ExcelCSV ($File)
{
 
    $excelFile = "$pwd\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $false
    $Excel.DisplayAlerts = $false
    $wb = $Excel.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
	$ws.SaveAs("$pwd\" + "_" + $ws.name + ".csv", 6)
    }
    $Excel.Quit()
}
$FileName = "argot"
ExcelCSV -File "$FileName"