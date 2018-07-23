#-----------------------------------------------------------
#  Script Name : QAAutomationTest.ps1
#  Created Date: 23 March 2018
#  Author Name : Santosh Kumar Dora
#  Purpose: This powershell scripts executes the weekly regression test
#-----------------------------------------------------------------------

Function Write-Log {
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$False)]
    [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")]
    [String]
    $Level = "INFO",

    [Parameter(Mandatory=$True)]
    [string]
    $Message,

    [Parameter(Mandatory=$False)]
    [string]
    $logfile
    )

    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $Line = "$Stamp $Level $Message"
    If($logfile) {
        Add-Content $logfile -Value $Line
    }
    Else {
        Write-Output $Line
    }
}



#$sRootpath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$sRootpath = "C:\Users\amit.pandey\Documents\Testfolder\Testfolder"

$ConfigPath =$sRootpath + "\ConfigurationFiles"
$consolePath =$sRootpath +  "\BBConsole"
$LogPath =$sRootpath +  "\ExecutionLog"
$LogfileName = $LogPath + "\Execution-log.log"
$logFilesssss = "log-$(gc env:computername).log"

    If($LogfileName) {
        Add-Content $LogfileName -Value "------------------------------------------------------------------------------------"
    }

Write-Log -Level INFO -Message "Started the Weekly execution Process......." -logfile $LogfileName

Write-Log -Level INFO -Message "Setting up the global variables......." -logfile $LogfileName

$files = Get-ChildItem $ConfigPath -Filter *.txt 

$listConfigfiles = " " 
[string] $sfiles = " " 
Foreach ($txt in $files) 
            {          
                    IF([string]::IsNullOrWhiteSpace($listConfigfiles)) 
                    {            
     
                         $listConfigfiles= $ConfigPath + "\" + $txt 
                         $sfiles=  $txt      
                    } 
                    else {            
     
                            $listConfigfiles= $listConfigfiles + ";" + $ConfigPath + "\" + $txt  
                            $sfiles = $sfiles+ "`r`n" + $txt        
                         }   

               }

Write-Log -Level INFO -Message "Trying to colect all the configuration file names ......." -logfile $LogfileName

$commandpath= "javaws -open " +'"' + $listConfigfiles + '"' + " " + '"' +"BeatBlipConsole.jnlp" + '"'

Write-Log -Level INFO -Message "Preparing the Command Line arguments......." -logfile $LogfileName

Write-Log -Level INFO -Message "Preparing the email Body ......." -logfile $LogfileName

$EmailSub="Hi,`n `n The Weekly Execution has been strated at : $((Get-Date).ToString('dd/MM/yyyy hh:mm:ss'))"

$EmailSub= $EmailSub + " with following Configuration Files :- `n $sfiles `n`nRegards,`nTest Automation Team"

Write-Log -Level INFO -Message "Changing the command path to Console ......." -logfile $LogfileName

Set-Location -Path $consolePath

Write-Log -Level INFO -Message "Preparing to send the email ......." -logfile $LogfileName

#Send-MailMessage -to "santosh.dora@revionics.com" -Cc "Himanshu.Gautam@revionics.com" -from "Test Automation Team <santosh.dora@revionics.com>" -subject "Weekly Execution Started..." -body $EmailSub -smtpServer hdc-smtp.revionics.local
#Send-MailMessage -to "santosh.dora@revionics.com" -from "Test Automation Team <santosh.dora@revionics.com>" -subject "Weekly Execution Started..." -body $EmailSub -smtpServer hdc-smtp.revionics.local

Write-Log -Level INFO -Message "Email sent to Automation Team Successfully ......." -logfile $LogfileName

Write-Log -Level INFO -Message "Preparing to launch BeatBlip ......." -logfile $LogfileName

Invoke-Expression -Command "$commandpath"

Write-Log -Level INFO -Message "BeatBlip Launched successfully  ......." -logfile $LogfileName

#Write-Log -Level WARN -Message "The weekly execution Process Completed successfuly." -logfile $LogfileName
