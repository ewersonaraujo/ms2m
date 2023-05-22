cls
Remove-Variable * -ErrorAction SilentlyContinue

Import-Module ActiveDirectory
$secureString = convertto-securestring "123@Mudar" -asplaintext -force

$nome = @()
$sobrenome = @()
$login = @()
$email = @()
$empresa = "verdanatech.com" #@verdanatech.com

$csv = Import-Csv .\verdanatech.CSV -Delimiter ";" | ForEach-Object {

    $nome += $_.GivenName
    $sobrenome += $_.Surname
    $email += $_.Email
}

$ponto = "."
$login = $nome+$ponto+$sobrenome

for($i = 0; $i -lt 21; $i++){

    
    New-ADUser -Path "OU=Matrix,DC=matrix,DC=local" -Name $nome[$i] -GivenName $nome[$i] -Surname $sobrenome[$i] -SamAccountName $login[$i].ToLower() -DisplayName $nome[$i] -EmailAddress $email[$i] -UserPrincipalName $login[$i] -AccountPassword $secureString -ChangePasswordAtLogon $true -Enabled $true
    Write-Output("Usuário " +$nome[$i] +" " +$sobrenome[$i] +" criado com sucesso!! `n")

    
}