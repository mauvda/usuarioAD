# Script de Criação de Usuários no Active Directory via CSV

Este repositório contém um script PowerShell que permite a criação automatizada de usuários no Active Directory com base em um arquivo `.csv`.

## 📄 Descrição

O script `criar-usuarios-ad.ps1` lê um arquivo CSV contendo dados de usuários (como nome, login, senha e departamento) e cria os usuários em uma Unidade Organizacional (OU) especificada no Active Directory.

## 🛠 Requisitos

- Windows Server com **RSAT (Remote Server Administration Tools)** instalado.
- Permissões administrativas no Active Directory.
- Módulo `ActiveDirectory` disponível.
- OU de destino já criada no AD.

## 📂 Estrutura do CSV

O arquivo `novos-usuarios.csv` deve conter as seguintes colunas:
 
| Usuario        | Senha          | NomeCompleto         | Nome     | Sobrenome | Departamento          | GrupoArea   | UserPrincipalName                   |
|----------------|----------------|----------------------|----------|-----------|-----------------------|-------------|-------------------------------------|
| usuario01      | senha123       | Mauricio Lamonatto   | Mauricio | Lamonatto | Fiscal / Contábil     | Fiscal      | mauricio.lamonatto@seu-dominio.srv  |

> Você pode editar ou adicionar linhas conforme necessário.

## ▶️ Como usar

1. **Clone o repositório ou baixe os arquivos**:

```bash
git clone https://github.com/mauvda/usuarioAD.git
```

2. **Abra o PowerShell como Administrador**:
   
3. **Edite o script e defina o caminho da OU corretamente, por exemplo**:
```bash
$ouPath = "OU=USUARIOS,DC=seu-dominio,DC=srv"
```
**Para descobrir o caminho do OU, use o seguinte comando no Powershell**:
```bash
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```
4. **Execute o script**:
```bash
.\criar-usuarios-ad.ps1
```
> O script verificará se o usuário já existe antes de criar um novo.
