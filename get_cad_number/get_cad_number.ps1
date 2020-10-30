# New-Item "C:\Users\$env:UserName\Documents\cad_numbers_$env:UserName.txt"


$GlobalCsvPath = "C:\Users\michael.wettstein\Documents\git\powershell-scripts\get_cad_number\0000-000-XXX_Versuchszeichnungen.csv"


# PREP read and show global csv file:

$P = Import-Csv -Path "$GlobalCsvPath" -Delimiter ";"

 
Write-Output " "
Write-Output "Meine Zeichnungsnummern:"
$P | Format-Table -AutoSize


# Add entry to csv file

$NewDrwNumber=    "0000-000-006"
$NewDrwName=      "Zeichnung 6"
$NewDrwProject=   "MHC"
$NewDrwDesigner=  $env:UserName
$NewDrwDate=      Get-Date -Format "dddd dd/MM/yyyy HH:mm"

$NewEntryString = "$NewDrwNumber;$NewDrwName;$NewDrwProject;$NewDrwDesigner;$NewDrwDate"

$NewEntryString | Add-Content -Path $GlobalCsvPath





# PREP copy global csv file  to local file:




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
