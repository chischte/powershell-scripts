# Define path of "Versuchszeichnungen"
#$PathToNumberList = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"
$PathToNumberList = "C:\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"

# Read and show global csv file:
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$NumberList | Format-Table -AutoSize

# Get latest project where user worked on:
$NumberListFilterdByUsername = Import-Csv -Path "$PathToNumberList" -Delimiter ";" |
Where-Object ERSTELLER -like $env:UserName |
Select-Object -Last 1
$PrevProject = $NumberListFilterdByUsername.PROJEKT

# Ask user to enter project:
Write-Output "Bitte <Projektname> eingeben oder <Enter> drücken für <$PrevProject> :"
$NewProject = Read-Host 
if ([string]::IsNullOrEmpty($NewProject)) {
    $NewProject = $PrevProject
}
# Ask user to enter Drawingname:
$NewDrwName = Read-Host -Prompt 'Bitte Name des Teils oder der Baugruppe eingeben' 



# Check if CSV is blocked:
$FileIsBlocked = (Get-ChildItem $PathToNumberList).IsReadOnly

While ($FileIsBlocked) {
    Write-Output "Nummernliste ist besetzt durch einen anderen Benutzer!"
    Read-Host -Prompt 'Enter Drücken um es erneut zu versuchen' 
    $FileIsBlocked = (Get-ChildItem $PathToNumberList).IsReadOnly
}

# Set CSV as readonly (block access for other users)
Set-ItemProperty -path $PathToNumberList -name IsReadOnly -Value $true

Read-Host -Prompt 'PAUSE BIS ENTER' 

# Get latest drawing number
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$LastRowGlobal = $NumberList | Select-Object -Last 1
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

# Add new number to clipboard
Set-Clipboard $NewNumber

#Create new Entry for Csv
$NewDrwDate = Get-Date -Format "dddd dd/MM/yyyy HH:mm"

$NewEntryString = "$NewNumber;$NewDrwName;$NewProject;$env:UserName;$NewDrwDate"

# Unblock file and make new entry:
Set-ItemProperty -path $PathToNumberList -name IsReadOnly -Value $false
$NewEntryString | Add-Content -Path $PathToNumberList

# read and show global csv file:
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$NumberList | Format-Table -AutoSize

Write-Output "Die neue Zeichnungsnummer wurde in die Zwischenablage kopiert."
Write-Output "--------------------------------------------------------------"
Write-Output ""
Write-Output ""

# ... Press W für wiederholen und Esc um das fenster zu schliessen


exit