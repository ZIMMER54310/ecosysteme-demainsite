# DSE-PRODUCTION-STRUCTURE-V1.0.0

Objectif : mettre en production la structure DemainSite sans perdre de temps.

Architecture officielle :
- SharePoint = source officielle metier
- GitHub = code du site public
- Azure Static Web Apps = publication publique
- Power Pages = espace prive connecte proprietaires / utilisateurs autorises

Ordre d'execution :
1. Executer 01-sharepoint/01-DEMARRER.cmd pour creer/mettre a jour les listes SharePoint.
2. Creer ou utiliser le depot GitHub demainsite-public.
3. Copier le contenu de 02-demainsite-public dans le depot GitHub.
4. Relier Azure Static Web Apps au depot GitHub ou utiliser le workflow fourni.
5. Configurer Power Pages prive avec les pages et droits de 03-powerpages-prive.
6. Ajouter Acti'Dem et Carottagexpert avec les modeles dans 04-clients.

Regle officielle :
- Super Admin : Power Pages + GitHub + Azure + SharePoint.
- Proprietaire site : Power Pages uniquement, uniquement ses sites.
- Utilisateur autorise site : Power Pages uniquement, uniquement les sites autorises.
