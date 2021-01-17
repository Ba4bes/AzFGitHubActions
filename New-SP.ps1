# Change these variables to your own information
$SPName = "GitHubAzConnection"
$AzSubscriptionName = "MSDN Platforms"

$Subscription = (Get-AzSubscription -SubscriptionName $AzSubscriptionName)
Set-AzContext $Subscription.Id
$Principal = New-AzADServicePrincipal -DisplayName $SPName

$OutputObject = [PSCustomObject]@{
    clientId = $Principal.ApplicationId
    clientSecret = ($Principal.Secret | ConvertFrom-SecureString -AsPlainText)
    subscriptionId = $Subscription.Id
    tenantId = $Subscription.TenantId
}

$OutputObject | ConvertTo-Json