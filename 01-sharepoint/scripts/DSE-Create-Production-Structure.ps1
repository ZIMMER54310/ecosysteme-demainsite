# DSE-PRODUCTION-STRUCTURE-V1.0.0
# Execute avec PowerShell 7 / PnP.PowerShell / DeviceLogin.
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$LogDir = Join-Path $Root 'logs'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$LogFile = Join-Path $LogDir ('DSE-PRODUCTION-STRUCTURE-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.log')
function Log($m){ $line = ('[{0}] {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $m); $line | Tee-Object -FilePath $LogFile -Append }

$Tenant = 'demainsite.com'
$ClientId = '5d607413-77c5-47b2-975a-eaca6827921c'
$SiteUrl = 'https://blogssite.sharepoint.com/sites/Bibliotheque'

Log 'Demarrage creation structure officielle DemainSite production.'
if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
  Log 'PnP.PowerShell absent. Installation pour l utilisateur courant.'
  Install-Module PnP.PowerShell -Scope CurrentUser -Force -AllowClobber
}
Import-Module PnP.PowerShell -ErrorAction Stop
Connect-PnPOnline -Url $SiteUrl -Tenant $Tenant -ClientId $ClientId -DeviceLogin
Log "Connecte a $SiteUrl"

function Ensure-List($Title, $Description){
  $l = Get-PnPList -Identity $Title -ErrorAction SilentlyContinue
  if($null -eq $l){
    New-PnPList -Title $Title -Template GenericList -OnQuickLaunch | Out-Null
    Log "Liste creee: $Title"
  } else { Log "Liste existe deja: $Title" }
  if($Description){ Set-PnPList -Identity $Title -Description $Description | Out-Null }
}
function Ensure-TextField($List, $Name, $DisplayName){
  $f = Get-PnPField -List $List -Identity $Name -ErrorAction SilentlyContinue
  if($null -eq $f){ Add-PnPField -List $List -InternalName $Name -DisplayName $DisplayName -Type Text -AddToDefaultView | Out-Null; Log "Champ cree: $List.$DisplayName" }
}
function Ensure-NoteField($List, $Name, $DisplayName){
  $f = Get-PnPField -List $List -Identity $Name -ErrorAction SilentlyContinue
  if($null -eq $f){ Add-PnPField -List $List -InternalName $Name -DisplayName $DisplayName -Type Note -AddToDefaultView | Out-Null; Log "Champ cree: $List.$DisplayName" }
}
function Ensure-BooleanField($List, $Name, $DisplayName){
  $f = Get-PnPField -List $List -Identity $Name -ErrorAction SilentlyContinue
  if($null -eq $f){ Add-PnPField -List $List -InternalName $Name -DisplayName $DisplayName -Type Boolean -AddToDefaultView | Out-Null; Log "Champ cree: $List.$DisplayName" }
}

$lists = @(
  @{T='DSE - Acces Sites';D='Droits par utilisateur, site et client pour Power Pages'},
  @{T='DSE - Roles';D='Roles logiques DemainSite'},
  @{T='DSE - Groupes Acces';D='Groupes logiques d acces'},
  @{T='SIT - Sites';D='Sites DemainSite et clients'},
  @{T='CLI - Clients';D='Clients et relations'},
  @{T='ART - Articles';D='Articles publics et prives'},
  @{T='MDU - Produits';D='Produits Media DemainSite Universal'},
  @{T='COM - Commandes';D='Commandes clients'},
  @{T='LIC - Licences';D='Licences et droits achat'},
  @{T='DOC - Documents Client';D='Documents rattaches aux clients et sites'},
  @{T='SUP - Tickets Support';D='Tickets et demandes support'},
  @{T='SOC - Reseaux Sociaux';D='Reseaux sociaux par site'}
)
foreach($item in $lists){ Ensure-List $item.T $item.D }

# Champs principaux
foreach($list in @('SIT - Sites','CLI - Clients','ART - Articles','MDU - Produits','COM - Commandes','LIC - Licences','DOC - Documents Client','SUP - Tickets Support','SOC - Reseaux Sociaux')){
  Ensure-TextField $list 'SiteCode' 'SiteCode'
  Ensure-TextField $list 'ClientCode' 'ClientCode'
  Ensure-TextField $list 'StatutREF' 'Statut REF'
  Ensure-BooleanField $list 'Actif' 'Actif'
}

$accessList = 'DSE - Acces Sites'
foreach($field in @(
  @{N='Utilisateur';D='Utilisateur'},@{N='Email';D='Email'},@{N='RoleDSE';D='Role'},@{N='ClientCode';D='ClientCode'},@{N='SiteCode';D='SiteCode'},@{N='ValidePar';D='Valide par'})){
  Ensure-TextField $accessList $field.N $field.D
}
foreach($field in @('PeutVoir','PeutModifier','PeutGererProduits','PeutGererArticles','PeutGererDocuments','PeutGererCommandes','Actif')){
  Ensure-BooleanField $accessList $field $field
}

# Import simple anti-doublon depuis CSV
$seed = Import-Csv (Join-Path $Root 'data/DSE-Acces-Sites.seed.csv')
foreach($r in $seed){
  $title = "$($r.Utilisateur) - $($r.SiteCode)"
  $existing = Get-PnPListItem -List $accessList -PageSize 2000 | Where-Object { $_['Title'] -eq $title } | Select-Object -First 1
  $values = @{
    Title=$title; Utilisateur=$r.Utilisateur; Email=$r.Email; RoleDSE=$r.Role; ClientCode=$r.ClientCode; SiteCode=$r.SiteCode; ValidePar=$r.ValidePar;
    PeutVoir=($r.PeutVoir -eq 'Oui'); PeutModifier=($r.PeutModifier -eq 'Oui'); PeutGererProduits=($r.PeutGererProduits -eq 'Oui');
    PeutGererArticles=($r.PeutGererArticles -eq 'Oui'); PeutGererDocuments=($r.PeutGererDocuments -eq 'Oui'); PeutGererCommandes=($r.PeutGererCommandes -eq 'Oui'); Actif=($r.Actif -eq 'Oui')
  }
  if($existing){ Set-PnPListItem -List $accessList -Identity $existing.Id -Values $values | Out-Null; Log "Acces mis a jour: $title" }
  else { Add-PnPListItem -List $accessList -Values $values | Out-Null; Log "Acces cree: $title" }
}
Log 'Termine. Aucune suppression effectuee.'
