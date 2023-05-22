cls
Remove-Variable * -ErrorAction SilentlyContinue
$nome = @('Ewerson', 'Gabriela')
$sobrenome = @('Araujo', 'Silva')

for($i = 0; $i -le 1; $i++){

    $nome[$i]+" "+$sobrenome[$i]

}