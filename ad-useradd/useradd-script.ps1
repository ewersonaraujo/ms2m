cls
Remove-Variable * -ErrorAction SilentlyContinue
Import-Module ActiveDirectory
$secureString = convertto-securestring "123@Mudar" -asplaintext -force

$nome = "Ewerson"
$sobrenome = "Araújo"
$ponto = "."
$login = $nome+$ponto+$sobrenome
$empresa = "verdanatech.com" #@verdanatech.com

if(Get-ADUser -Filter { SamAccountName -eq $login }){

    Write-Output("Usuário já existe!! `n")

}

if(Get-ADUser -Filter { SamAccountName -ne $login }){

    Write-Output("Criando usuário" +" " +$nome +" " +$sobrenome +"... `n")
    New-ADUser -Name "$nome $sobrenome" -GivenName $nome -Surname $sobrenome -SamAccountName $login.ToLower() -DisplayName "$nome $sobrenome" -EmailAddress $nome"."$sobrenome"@"$empresa -UserPrincipalName $login"@matrix.local" -Path "OU=Matrix,DC=matrix,DC=local" -AccountPassword $secureString -ChangePasswordAtLogon $true -Enabled $true
    Write-Output("Usuário " +$nome +" " +$sobrenome +" criado com sucesso!! `n")
} 
