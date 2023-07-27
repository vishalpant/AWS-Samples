<#
.SYNOPSIS
	Get metadata of Azure VM
.DESCRIPTION
	This PowerShell script gets metadata of Azure VM
.PARAMETER VmName
    Specifies the name of the VM for which metadata needs to be fetched
.PARAMETER SubscriptionId
    Subscription ID under which VM is located
.PARAMETER ResourceGroupName
    Resource Group under which VM is located
.PARAMETER Key
    Key(in PascalCase) that needs to be fetched from VM Metadata
.EXAMPLE
    PS> ./main -VmName example-vm -SubscriptionId 123456 -ResourceGroupName example-rg -Key Name
#>

Import-Module Az

param(
    [string]$VmName,
    [string]$SubscriptionId,
    [string]$ResourceGroupName,
    [string]$Key=""
)

Connect-AzAccount
Set-AzContext -Subscription $SubscriptionId

try {
    $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName
    $jsonOutput = ConvertTo-Json -InputObject $vm
    if ($Key) {
        $jsonOutput = ConvertTo-Json -InputObject $vm[$Key]
    }
    else {
        $jsonOutput = ConvertTo-Json -InputObject $vm
    }
    Write-Output $jsonOutput
    } 
catch {
    Write-Error "Error: $_"
}