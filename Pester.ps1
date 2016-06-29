﻿$TargetFolder ="C:\Pester"
if(!(Test-Path $TargetFolder))
{
    New-Item -Path $TargetFolder -ItemType Directory -Force
}
else
{
    Remove-Item -Path $TargetFolder -Recurse -Force
    New-Item -Path $TargetFolder -ItemType Directory -Force

}

$pesterUri = "https://spotlightautomation.blob.core.windows.net/sampledata/Pester-master.zip"
$pestFile =  "C:\Pester\Pester-master.zip"

Invoke-WebRequest -Uri $pesterUri -OutFile $pestFile -UseBasicParsing


Function Unzip()
{
    param([string]$ZipFile,[string]$TargetFolder)
    $shellApp = New-Object -ComObject Shell.Application
    $files = $shellApp.NameSpace($ZipFile).Items()
    $shellApp.NameSpace($TargetFolder).CopyHere($files)
}
#unzip the json files to target folder
unzip -ZipFile $pestFile -TargetFolder "C:\Pester"


$pester = "C:\Pester\Pester-master\pester.psd1"
Import-Module $pester
#Get-Module -Name Pester | Select -ExpandProperty ExportedCommands

Invoke-Pester -EnableExit -OutputFile "./CheckResult.xml" -OutputFormat NUnitXml #-Path "C:\Program Files (x86)\Jenkins\jobs\$ENV:JOB_NAME\workspace\Healthcheck.ps1"


 