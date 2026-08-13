# Ecosysteme DemainSite

Depot officiel de structure et de production DemainSite.

## Identifiants officiels

- CLI-000001 : DemainSite
- SIT-000001 : Site public DemainSite
- Azure Static Web App : dse-sit-000001-public
- Depot GitHub : ecosysteme-demainsite

## Architecture

- SharePoint : source officielle metier
- GitHub : code et structure
- Azure Static Web Apps : site public
- Power Pages : espace prive connecte

## Structure propre

```text
src/                 Application publique DemainSite
api/                 Fonctions API futures
private-portal/      Notes structure espace prive Power Pages
clients/             Structures futures clients par CLI/SIT
sharepoint/          Mapping SharePoint non executable
azure/               Notes Azure
.github/workflows/   Deploiement Azure Static Web Apps
```

## Regle officielle

Le depot `ecosysteme-demainsite` garde son nom car il represente la structure generale.
Tous les autres clients, sites et ressources utilisent les identifiants permanents CLI-xxxxx et SIT-xxxxx.
