# New-Item "C:\Users\$env:UserName\Documents\cad_numbers_$env:UserName.txt"


$GlobalCsvPath = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"


# read and show global csv file:

$CsvGlobal = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";"

 
Write-Output " "
Write-Output "Meine Zeichnungsnummern:"
$CsvGlobal | Format-Table -AutoSize

# Get latest project where user worked on:

$CsvGlobalFilterdByUsername = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";" |
Where-Object ERSTELLER -like $env:UserName |
Select-Object -Last 1
$PrevProject = $CsvGlobalFilterdByUsername.PROJEKT
Write-Output $PrevProject

# Ask user to enter project:
Write-Output "Bitte Projektname eingeben oder Enter drücken für $PrevProject :"
$NewProject = Read-Host 
if ([string]::IsNullOrEmpty($NewProject)) {
    $NewProject = $PrevProject
}
#Ask user to enter Name:
$NewDrwName = Read-Host -Prompt 'Bitte Name des Teils oder der Baugruppe eingeben' 


# Get latest drawing number
$CsvGlobal = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";"
$LastRowGlobal = $CsvGlobal | Select-Object -Last 1
$LatestNumber = $LastRowGlobal.ZEICHNUNGSNUMMER
Write-Output $LatestNumber

# Increase number by one
$LatestNumber = $LatestNumber -replace "-", ""
$LatestNumber = $LatestNumber -as [int]
$NewNumber = $LatestNumber + 1
$NewNumber = $NewNumber -as [string]


# Fill up with trailing zeros
$ZerosToFillUp = 10 - $NewNumber.Length

for ($i = 0; $i -lt $ZerosToFillUp; $i++) {
    $NewNumber = "0" + $NewNumber
}
# Add dashes
$NewNumber = $NewNumber.Insert(7, "-")
$NewNumber = $NewNumber.Insert(4, "-")

#Create new Entry in Csv

#$NewDrwDesigner = $env:UserName
$NewDrwDate = Get-Date -Format "dddd dd/MM/yyyy HH:mm"

$NewEntryString = "$NewNumber;$NewDrwName;$NewProject;$env:UserName;$NewDrwDate"

$NewEntryString | Add-Content -Path $GlobalCsvPath

# Show Updated (user)-numberlist

# write new number to versuchszeichnungen

# write new number to cad_numbers_username

# open cad_numbers_username

# add new number to clipboard

# add possibility to get a block of new numbers
