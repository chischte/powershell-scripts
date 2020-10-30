# New-Item "C:\Users\$env:UserName\Documents\cad_numbers_$env:UserName.txt"


$GlobalCsvPath = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"


# read and show global csv file:

$CsvGlobal = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";"

 
Write-Output " "
Write-Output "Meine Zeichnungsnummern:"
$CsvGlobal | Format-Table -AutoSize


# Add entry to csv file

$NewDrwNumber = "0000-000-006"
$NewDrwName = "Zeichnung 6"
$NewDrwProject = "MHC"
$NewDrwDesigner = $env:UserName
$NewDrwDate = Get-Date -Format "dddd dd/MM/yyyy HH:mm"

$NewEntryString = "$NewDrwNumber;$NewDrwName;$NewDrwProject;$NewDrwDesigner;$NewDrwDate"

$NewEntryString | Add-Content -Path $GlobalCsvPath

# Get latest project where user worked on:

$CsvGlobalFilterdByUsername = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";" |
Where-Object ERSTELLER -like $env:UserName |
Select-Object -Last 1
$PrevProject = $CsvGlobalFilterdByUsername.PROJEKT
Write-Output $PrevProject

# Ask user to enter project and Name:
Write-Output "Bitte Projektname eingeben oder Enter drücken für $PrevProject :"
$CurrentProject = Read-Host 
if ([string]::IsNullOrEmpty($CurrentProject)) {
    $CurrentProject = $PrevProject
}
Write-Output $CurrentProject

$CurrentName = Read-Host -Prompt 'Bitte Name des Teils oder der Baugruppe eingeben' 


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
Write-Output $ZerosToFillUp

for ($i = 0; $i -lt $ZerosToFillUp; $i++)
 {
    $NewNumber = "0" + $NewNumber
}
# Add dashes
$NewNumber = $NewNumber.Insert(7,"-")
$NewNumber = $NewNumber.Insert(4,"-")

Write-Output $NewNumber







#$SplitLatestNumberArray = $LatestNumber.Split("-")
Write-Output $SplitLatestNumberArray[2]



# Create new entry in global csv







# show local cad numbers


# get default values for username and project


# ask if default are ok

# enter new part name

# get new number

# write new number to versuchszeichnungen

# write new number to cad_numbers_username

# open cad_numbers_username

# add new number to clipboard

# add possibility to get a block of new numbers
