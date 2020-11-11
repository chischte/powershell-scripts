$Dashline = "-------------------------------------------------------------------------------"

# Define path of "Versuchszeichnungen"
$PathToNumberList = "G:\Packaging_Technology\PT_Products\Entwicklung\Zchng-Nummern\9999-999-XXX.csv"
# @OfficeGit:     $PathToNumberList = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"
# @Flugchsichte:  $PathToNumberList = "C:\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"

# Read global csv file:
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"

# Show last n entries of numberlist:
$NumberOfEntries = 200
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

# Ask user to enter drawingname:
$NewDrwName = Read-Host -Prompt 'Bitte Name des Teils oder der Baugruppe eingeben' 

function GetNewDrawingNumber {
    # Get latest drawing number:
    $NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
    $LastRowGlobal = $NumberList | Select-Object -Last 1
    $LatestNumber = $LastRowGlobal.ZEICHNUNGSNUMMER

    # Increase number by one:
    $LatestNumber = $LatestNumber -replace "-", ""
    $LatestNumber = $LatestNumber -as [int]
    $NewNumber = $LatestNumber + 1
    $NewNumber = $NewNumber -as [string]

    # Fill up with trailing zeros:
    $ZerosToFillUp = 10 - $NewNumber.Length

    for ($i = 0; $i -lt $ZerosToFillUp; $i++) {
        $NewNumber = "0" + $NewNumber
    }

    # Add dashes:
    $NewNumber = $NewNumber.Insert(7, "-")
    $NewNumber = $NewNumber.Insert(4, "-")

    # Add new number to clipboard:
    Set-Clipboard $NewNumber

    Return $NewNumber
}
$NewNumber = GetNewDrawingNumber
$NewDrwDate = Get-Date -Format "dddd dd/MM/yyyy HH:mm";

function CreateNewCsvEntry {
    $NewEntryString = "$NewNumber;$NewDrwName;$NewProject;$env:UserName;$NewDrwDate"
    Return $NewEntryString
}
$NewEntryString = CreateNewCsvEntry

function WriteNewEntryToCsv {
    # Write new Entry to CSV:
    Set-ItemProperty -path $PathToNumberList -name IsReadOnly -Value $false
    $NewEntryString | Add-Content -Path $PathToNumberList
}
WriteNewEntryToCsv

function CheckIfEntryWasSuccess {

    $NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
    $LastRowGlobal = $NumberList | Select-Object -Last 1

    $EntryWasSuccess = $true

    if ($LastRowGlobal.ZEICHNUNGSNUMMER -ne $NewNumber) { $EntryWasSuccess = $false }

    if ($LastRowGlobal.NAME -ne $NewDrwName) { $EntryWasSuccess = $false }
    
    if ($LastRowGlobal.PROJEKT -ne $NewProject) { $EntryWasSuccess = $false }
    
    if ($LastRowGlobal.ERSTELLER -ne $env:UserName) { $EntryWasSuccess = $false }
    
    if ($LastRowGlobal.DATUM -ne $NewDrwDate) { $EntryWasSuccess = $false }
    
    Return $EntryWasSuccess
}

While ((CheckIfEntryWasSuccess) -ne $true) {
    Read-Host -Prompt 'Schreiben der Nummernliste nicht möglich, <Enter> Drücken um es erneut zu versuchen' 
    WriteNewEntryToCsv
}

Write-Output $Dashline

# Show latest entry:
$NumberOfEntries = 1
$NumberList = Import-Csv -Path "$PathToNumberList" -Delimiter ";"
$NumberListLastLines = $NumberList | Select-Object -Last $NumberOfEntries
$NumberListLastLines | Format-Table -AutoSize

Write-Output "Die neue Zeichnungsnummer $NewNumber wurde in die Zwischenablage kopiert."
Write-Output ""

Read-Host -Prompt 'Enter Drücken um das Fenster zu schliessen'