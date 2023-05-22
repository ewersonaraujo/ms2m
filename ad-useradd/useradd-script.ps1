cls
Remove-Variable * -ErrorAction SilentlyContinue
Import-Module ActiveDirectory
$secureString = convertto-securestring "123@Mudar" -asplaintext -force

$nome = "Ewerson"
$sobrenome = "Ara�jo"
$ponto = "."
$login = $nome+$ponto+$sobrenome
$empresa = "verdanatech.com" #@verdanatech.com

if(Get-ADUser -Filter { SamAccountName -eq $login }){

    Write-Output("Usu�rio j� existe!! `n")

}

if(Get-ADUser -Filter { SamAccountName -ne $login }){

    Write-Output("Criando usu�rio" +" " +$nome +" " +$sobrenome +"... `n")
    New-ADUser -Name "$nome $sobrenome" -GivenName $nome -Surname $sobrenome -SamAccountName $login.ToLower() -DisplayName "$nome $sobrenome" -EmailAddress $nome"."$sobrenome"@"$empresa -UserPrincipalName $login"@matrix.local" -Path "OU=Matrix,DC=matrix,DC=local" -AccountPassword $secureString -ChangePasswordAtLogon $true -Enabled $true
    Write-Output("Usu�rio " +$nome +" " +$sobrenome +" criado com sucesso!! `n")
} 
