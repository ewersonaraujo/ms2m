#Conectar no Automation Account
$azConn = Get-AutomationConnection -Name 'AzureRunAsConnection'
Add-AzureRMAccount -ServicePrincipal -Tenant $azConn.TenantID -ApplicationId $azConn.ApplicationId -CertificateThumbprint $azConn.CertificateThumbprint

#Definir TAG que será validada para o stop das VMs
$azVMs = Get-AzureRMVM | Where-Object {$_.Tags.Auto -eq 'Start-Stop-VMs-DEV'}

#Executar o start das VMs
$azVMS | Stop-AzureRMVM -Force
