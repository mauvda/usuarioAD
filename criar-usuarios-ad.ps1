Import-Module ActiveDirectory

<#
 Utilize um arquivo .csv com as colunas padr�es
 Usuario,Senha,NomeCompleto,Nome,Sobrenome,Departamento,GrupoArea,UserPrincipalName
#>
# Caminho do CSV
$csvPath = "novos-usuarios.csv"

<#
 Para encontrar o valor para ouPath, utilize o comando a seguir:
 
 Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName

 Isso deve exibir as unidades organizacioanis no console do powershell
#> 
# Unidade organizacional padr�o
$ouPath = "OU=USUARIOS,DC=seu-dominio,DC=srv"

# Leitura do CSV
$usuarios = Import-Csv -Path $csvPath

foreach ($usuario in $usuarios) {
    $nomeCompleto = $usuario.NomeCompleto
    $usuarioSam = $usuario.Usuario
    $senha = ConvertTo-SecureString $usuario.Senha -AsPlainText -Force
    $userPrincipalName = $usuario.UserPrincipalName
    $departamento = $usuario.Departamento
    $nome = $usuario.Nome
    $sobrenome = $usuario.Sobrenome

    # Verifica se o usu�rio j� existe
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$usuarioSam'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $nomeCompleto `
            -GivenName $nome `
            -Surname $sobrenome `
            -SamAccountName $usuarioSam `
            -UserPrincipalName $userPrincipalName `
            -AccountPassword $senha `
            -Department $departamento `
            -Path $ouPath `
            -Enabled $true `
            -ChangePasswordAtLogon $false `
            -PasswordNeverExpires $true

        Write-Host "Usu�rio criado: $usuarioSam"
    } else {
        Write-Host "Usu�rio j� existe: $usuarioSam"
    }
}
