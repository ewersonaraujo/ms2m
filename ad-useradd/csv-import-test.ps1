cls
Remove-Variable * -ErrorAction SilentlyContinue

$nome = @()
$sobrenome = @()
$login = @()
$email = @()

$csv = Import-Csv .\verdanatech.CSV -Delimiter ";" | ForEach-Object {

    $nome += $_.GivenName
    $sobrenome += $_.Surname
    $email += $_.Email
    $login += $_.GivenName+"."+$_.Surname
}



$nome[1]
$sobrenome[1]
$email[1]
$login[1].ToLower()