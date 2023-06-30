# Criar certificado raiz

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

# Criar certificados de clientes
# Deve existir um arquivo chamado clientes.csv, com uma coluna chamada clientes e nas linhas os nomes dos clientes.

# Importar a coluna "clientes" do arquivo clientes.csv
$clientes = Import-Csv -Path ".\clientes.csv" | Select-Object -ExpandProperty clientes

# Loop para criar certificados para cada cliente
foreach ($client_name in $clientes) {
    # Criação do certificado usando o certificado raiz como assinador (signer)
    $certParams = @{
        Type = 'Custom'
        DnsName = $client_name
        KeySpec = 'Signature'
        Subject = "CN=$client_name"
        KeyExportPolicy = 'Exportable'
        HashAlgorithm = 'sha256'
        KeyLength = 2048
        CertStoreLocation = 'Cert:\CurrentUser\My'
        Signer = $cert
        TextExtension = @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
    }
    
    $cert = New-SelfSignedCertificate @certParams
    
    # Exportar o certificado como arquivo .cert codificado em Base64
    $certFilePath = ".\$client_name.cert"
    $certBytes = $cert.Export('Cert')
    $certBase64 = [System.Convert]::ToBase64String($certBytes)
    Set-Content -Path $certFilePath -Value $certBase64 -Encoding UTF8
    
    # Exibir informações sobre o certificado criado e o caminho do arquivo exportado
    Write-Host "Certificado criado para o cliente: $client_name"
    Write-Host "Thumbprint: $($cert.Thumbprint)"
    Write-Host "Certificado exportado como arquivo $certFilePath"
    Write-Host "------------------------------------"
}
