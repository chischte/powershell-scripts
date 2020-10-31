# Todo Check if entry in csv worked for the extremly unlikely case a collision happend 
# Show only last ten personal and public entries

$Dashline = "-------------------------------------------------------------------------------"

# Define path of "Versuchszeichnungen"
#$PathToNumberList = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"
$PathToNumberList = "C:\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"

# Read global csv file:
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"

# Show last n entries of numberlist:
$NumberOfEntries = 100
Write-Output ""
Write-Output $Dashline
Write-Output "LETZTE $NumberOfEntries EINTRÄGE IN DER NUMMERNLISTE:"
Write-Output $Dashline
$NumberListLastLines = $NumberList | Select-Object -Last $NumberOfEntries
$NumberListLastLines | Format-Table -AutoSize

# Get latest project where user worked on:
$NumberListFilterdByUsername = Import-Csv -Path "$PathToNumberList" -Delimiter ";" |
Where-Object ERSTELLER -like $env:UserName |
Select-Object -Last 1
$PrevProject = $NumberListFilterdByUsername.PROJEKT

# Ask user to enter project:
$NewProject = Read-Host -Prompt "Bitte Projektname eingeben oder <Enter> drücken für <$PrevProject>"
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

# Get latest drawing number
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$LastRowGlobal = $NumberList | Select-Object -Last 1
$LatestNumber = $LastRowGlobal.ZEICHNUNGSNUMMER

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

Write-Output $Dashline

# Show latest entry:
$NumberOfEntries = 1
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$NumberListLastLines = $NumberList | Select-Object -Last $NumberOfEntries
$NumberListLastLines | Format-Table -AutoSize

Write-Output "Die neue Zeichnungsnummer $NewNumber wurde in die Zwischenablage kopiert."
Write-Output ""

# ... Press W für wiederholen und Esc um das fenster zu schliessen

$UserInput = Read-Host -Prompt 'Enter Drücken um das Fenster zu schliessen'

#While ($UserInput -eq "n")

#exit