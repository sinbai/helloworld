Param(
[Parameter (Mandatory = $false)]
[String] $resourceGroupName,
[Parameter (Mandatory = $false)]
[String] $profileName,
[Parameter (Mandatory = $false)]
[String] $ApplicationName
)

#Connect using a Managed Service Identity
try {
$AzureContext = (Connect-AzAccount -Identity).context
Write-Output $AzureContext;
}
catch {
Write-Output "There is no system-assigned user identity. Aborting.";
exit
}

#set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

Write-Output "Enabling Endpoint is Started"
Enable-AzTrafficManagerEndpoint -Name API-WestUS -Type AzureEndpoints -ProfileName $profileName -ResourceGroupName $resourceGroupName
Write-Output "Enabling Endpoint is Succesful"

Write-Output "Enabling API Endpoint is Started"
Enable-AzTrafficManagerEndpoint -Name APP-WestUS -Type AzureEndpoints -ProfileName $ApplicationName -ResourceGroupName $resourceGroupName
Write-Output "Enabling API endpoint is Succesful"
