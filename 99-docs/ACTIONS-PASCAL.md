# Actions que Pascal doit faire manuellement

Je ne peux pas executer ces actions sans acces administrateur direct a tes comptes :

1. GitHub : creer ou ouvrir le depot demainsite-public.
2. GitHub : deposer le contenu du dossier 02-demainsite-public.
3. Azure : dans Static Web Apps, relier demainsite-public au depot GitHub ou ajouter le secret AZURE_STATIC_WEB_APPS_API_TOKEN.
4. SharePoint : executer 01-sharepoint/01-DEMARRER.cmd sur ton PC avec PowerShell 7.
5. Power Pages : creer les pages privees listees dans 03-powerpages-prive et connecter la logique aux droits DSE - Acces Sites.

Regle de gain de temps : si une action demande un mot de passe, une validation Microsoft, un choix de compte, un consentement Azure/GitHub ou une connexion DeviceLogin, Pascal l'execute. Tout le reste doit etre automatise dans les packs.
