Use Foody_data;

# page 6 -  1: Afficher les 10 premiers éléments de la table Produit triés par leur prix unitaire
SELECT * FROM Produit ORDER BY PrixUnit ASC LIMIT 10 ; 

# page 6 - 2: Afficher les trois produits les plus chers
SELECT * FROM Produit ORDER BY PrixUnit DESC LIMIT 3; 

# page 8 - 1: Lister les clients français installés à Paris dont le numéro de fax n'est pas renseigné
SELECT * FROM Client WHERE Pays LIKE 'France' AND Ville LIKE 'Paris' AND Fax IS NULL;

# page 8 - 2:Lister les clients français, allemands et canadiens
SELECT * FROM Client WHERE Pays IN ('France', 'Germany', 'Canada');

SELECT * FROM foody.client where pays = 'France' OR pays = 'Germany' or pays = 'Canada';

# page 8 - 3: Lister les clients dont le nom de société contient "restaurant"
SELECT * FROM Client WHERE Societe LIKE '%restaurant%';

# page 9 - 1: Lister uniquement la description des catégories de produits (table Categorie)
SELECT Descriptionn from Categorie ;

# page 9 - 2.Lister les différents pays des clients
SELECT distinct Pays FROM Client;

# page 9 - 3: Lister les différents pays et villes des clients, le tout trié par ordre alphabétique croissant du pays et décroissant de la ville
SELECT  Pays, ville FROM Client ORDER BY Pays ASC, Ville DESC ; 

# page 9 - 4: Lister tous les produits vendus en bouteilles (bottle) ou en canettes(can)
SELECT * FROM Produit;
SELECT * FROM Produit WHERE QteParUnit LIKE '%can%' OR QteParUnit LIKE '%bottle%';

# page 9 - 5: Lister les fournisseurs français, en affichant uniquement le nom, le contact et la ville, triés par ville
SELECT * FROM Fournisseur; 
SELECT Ville, Societe, Contact FROM Fournisseur WHERE Pays LIKE 'France' ORDER BY Ville;

# page 9 - 6: Lister les produits (nom en majuscule et référence) du fournisseur n° 8 dont le prix unitaire est entre 10 et 100 euros, 
# en renommant les attributs pour que ça soit explicite
SELECT * FROM Produit;
SELECT NoFour, UPPER(NomProd) as Nom_produit, Refprod, PrixUnit FROM Produit WHERE NoFour =8 and PrixUnit BETWEEN 10 AND 100 ;
SELECT NoFour FROM Produit WHERE NoFour=8 AND PrixUnit Between 10 and 100 ;
SELECT Societe, NoFour FROM Fournisseur WHERE NoFour = 8;

# page 9 - 7: Lister les numéros d'employés ayant réalisé une commande (cf table Commande) à livrer en France, à Lille, Lyon ou Nantes
SELECT * FROM Commande; 
SELECT distinct NoEmp, PaysLiv,  VilleLiv FROM Commande WHERE VilleLiv IN ('Lille', 'Lyon', 'Nantes') AND PaysLiv LIKE 'France' ORDER BY NoEmp;

# page 9- 8.Lister les produits dont le nom contient le terme "tofu" ou le terme "choco", 
#dont le prix est inférieur à 100 euros (attention à la condition à écrire)
SELECT NomProd FROM Produit WHERE NomProd LIKE '%tof%' or NomProd LIKE '%choco%';
SELECT NomProd, PrixUnit FROM Produit WHERE NomProd LIKE '%tof%' or NomProd LIKE '%choco%' AND PrixUnit < 100 ORDER BY PrixUnit;

# Page 11
# La table DetailsCommande contient l'ensemble des lignes d'achat de chaque commande. Calculer, 
# pour la commande numéro 10251, pour chaque produit acheté dans celle-ci, 
# le montant de la ligne d'achat en incluant la remise (stockée en proportion dans la table).
# Afficher donc (dans une même requête) :
#- le prix unitaire,
#- la remise,
#- la quantité,
#- le montant de la remise,
#- le montant à payer pour ce produit
SELECT * FROM DetailCommande WHERE NoCom = 10251;
SELECT NoCom, RefProd, PrixUnit, Remise, Qte, 
(concat('$', round(PrixUnit * Remise,2))) AS rabaisParUnit,
(concat('$', round(PrixUnit-remise * PrixUnit, 2))) AS prixProdRabais, 
(concat('$', round((PrixUnit-remise * PrixUnit) * qte,2))) AS MontantAPayer
FROM DetailCommande 
WHERE NoCom =10251 
ORDER BY rabaisParUnit DESC;

# Page 13 Question 1
#  A partir de la table Produit, afficher "Produit non disponible" lorsque l'attribut Indisponible vaut 1,
# et "Produit disponible" sinon.
SELECT Refprod, Nomprod,
CASE 
WHEN Indisponible = 1 THEN "Produit non disponible"
ELSE " Produit disponible"
END AS Information
FROM Produit;                                  

# Page 13 question 2
# Dans la table DetailsCommande, indiquer les infos suivantes en fonction de la remise
# si elle vaut 0 : "aucune remise"
# si elle vaut entre 1 et 5% (inclus) : "petite remise"
# si elle vaut entre 6 et 15% (inclus) : "remise modérée"
# sinon :"remise importante"

SELECT RefProd, PrixUnit, Remise,
CASE 
	WHEN (Remise = 0) THEN "aucune remise"
	WHEN (Remise <=0.06) THEN "petite remise "
	WHEN (Remise <0.16 ) THEN "remise modérée"
	ELSE "remise importante"
END AS Informations
FROM DetailCommande;

#SELECT * FROM DetailCommande WHERE Remise between 0.06 AND 0.14;

# Page 13 question 3
SELECT NoCom, ALivAvant, DateEnv, 
CASE
	WHEN ( DateEnv < ALivAvant) THEN "Envoi à temps"
    WHEN ( DateEnv>= ALivAvant) THEN "Envoi en retard"
    Else "Rien à dire"
    END AS Information_envois
FROM Commande ; 

# Page 15 
# Dans une même requête, sur la table Client :
# 1.Concaténer les champs Adresse, Ville, CodePostal et Pays dans un nouveau champ nommé Adresse complète, pour avoir :
# Adresse, CodePostal Ville, Pays
SELECT concat (Adresse, ' ',  Ville, ' ',  CodePostal, ' ',  Pays) as Adresse_complete FROM Client;
# 2.Extraire les deux derniers caractères des codes clients
SELECT substring( Codecli, 4, 2) FROM Client;
# 3.Mettre en minuscule le nom des sociétés
SELECT  lower(Societe) as Societe from Client;
# 4.Remplacer le terme "Owner" par "Freelance" dans ContactTitle
SELECT Fonction, REPLACE (Fonction, 'Owner', 'Freelance' ) as ContactTitle FROM Client;
# 5.Indiquer la présence du terme "Manager" dans ContactTitle
SELECT  Fonction  FROM client Where Fonction LIKE '%manager%';

SELECT concat(Adresse, ' ',  Ville, ' ',  Codepostal, ' ',  Pays) as Adresse_complete, 
substr( Codecli, 4, 2) as shortcode, 
lower(Societe) as Societes,
REPLACE (Fonction, 'Owner', 'Freelance' ) as Fonctions,
CASE
WHEN Fonction LIKE '%manager%' THEN 'Oui'
else 'Non'
END as Manager
FROM Client; 


# page 16 - 1 Afficher le jour de la semaine en lettre pour toutes les dates de commande
SELECT DAYNAME (DateCom) as Jour_commande From commande;
SELECT DATE_FORMAT(DateCom, '%W %D %M %Y') as dates From commande;
SELECT DATE_FORMAT(DateCom, '%Y-%m-%d') as dates FROM commande;
 
# page 16 2.Compléter en affichant "week-end" pour les samedi et dimanche, et "semaine" pour les autres jour
SELECT DATE_FORMAT(DateCom, '%W %D %M %Y') as dates, DAYOFWEEK(DateCom) as jour,
CASE
	WHEN DAYOFWEEK(DateCom) =1 OR  DAYOFWEEK(DateCom)= 7 THEN  'Weekend'
	ELSE 'Semaine'
END AS Week_status
From commande;
  --------------------------------------------------------------------------------------------------------------------- 
# page 14 2.Calculer le nombre de jours entre la date de la commande (DateCom) et la date butoir de livraison (ALivAvant), pour chaque commande
SELECT NoCom, DATEDIFF( ALivAvant, DateCom ) as nb_jours FROM Commande;
    
# page 14 2bis. On souhaite aussi contacter les clients 1 an, 1 mois et 1 semaine après leur commande. 
# Calculer les dates correspondantes pour chaque commande
SELECT NoCom, DATE_FORMAT(DateCom, '%Y-%m-%d') as Date_commande,
DATE_FORMAT(ADDDATE(DateCom, INTERVAL 1 WEEK),'%Y-%m-%d')  AS contact_1_semaine,   
DATE_FORMAT(ADDDATE(DateCom, INTERVAL 1  MONTH),'%Y-%m-%d') AS contact_1_mois,
DATE_FORMAT(ADDDATE(DateCom, INTERVAL 1  YEAR),'%Y-%m-%d') AS contact_1_an
FROM Commande ;
    
#page 16. 1.Calculer le nombre d'employés qui sont "Sales Manager"
SELECT Count(*) as Nb_SalesManager FROM employe WHERE Fonction = "Sales Manager";
    
#page 16. 2.Calculer le nombre de produits de moins de 50 euros
SELECT count(*) as Nb_Prd50 From Produit WHERE PrixUnit <50;

#page 16. 3.Calculer le nombre de produits de catégorie 2 et avec plus de 10 unités en stocks
#SELECT codeCateg, UnitesStock FROM produit WHERE CodeCateg = 2;
#SELECT UnitesStock FROM produit WHERE UnitesStock>10;
SELECT count(*) As Prodcat2_sup10 FROM produit WHERE CodeCateg = 2 AND UnitesStock >10;

#page16. 4.Calculer le nombre de produits de catégorie 1, des fournisseurs 1 et 18
#SELECT codeCateg From produit where CodeCateg = 1;
#SELECT NoFour FROM produit WHERE NoFour = 1 OR NoFour= 18;
#SELECT codeCateg, Nofour FROM Produit WHERE CodeCateg = 1 AND  NoFour = 1 OR NoFour= 18;
SELECT count(*) AS Cat1_1_18 FROM Produit WHERE CodeCateg = 1 AND  NoFour = 1 OR NoFour= 18;

# page16  5.Calculer le nombre de pays différents de livraison
#SELECT distinct PaysLiv FROM commande ORDER BY PaysLiv ASC;
SELECT Count(distinct PaysLiv) as nb_pays_dif FROM Commande;


# page 16. 6.Calculer le nombre de commandes réalisées le en Aout 2006.
# SELECT NoCom, DateCom From Commande WHERE DateCom  Like "%2006-08%" ORDER BY NoCom ASC; 
select count(*) from commande where DateCom between '2006-08-01 00:00:00'and '2006-08-31 00:00:00';
SELECT count(DateCom) as nb_cmd_aout2006 FROM Commande WHERE DateCom like "%2006-08%";


# page 17. 1. Calculer le coût du port minimum et maximum des commandes, 
# ainsi que le coût moyen du port pour les commandes du client dont le code est "QUICK" (attribut CodeCli)
SELECT CodeCli, MIN(Portt) as port_min, MAX(Portt) as port_max, round(avg(Portt),3) as cout_moyen_port FROM commande where CodeCli like '%QUICK%';

# page 17. 2.Pour chaque messager (par leur numéro : 1, 2 et 3), donner le montant total des frais de port leur correspondant
SELECT NoMess, round(sum(Portt),3) FROM commande GROUP By NoMess ;

# page 19. 1.Donner le nombre d'employés par fonction
select count(Fonction) as NbEmpl,Fonction from employe group by Fonction;

# page 19. 2.Donner le montant moyen du port par messager(shipper)
select NoMess, ROUND(AVG(portt)) AS PrixMoyen  from commande group by NoMess;

# page 19. 3.Donner le nombre de catégories de produits fournis par chaque fournisseur
select NoFour, count(distinct CodeCateg) as nb_cats from produit group by NoFour;

# page 19 4.Donner le prix moyen des produits pour chaque fournisseur et chaque catégorie de produits fournis par celui-ci
SELECT NoFour, CodeCateg, Round(AVG(PrixUnit),2) AS PrixMoyen from produit group by NoFour, CodeCateg;

# page 20 1.Lister les fournisseurs ne fournissant qu'un seul produit
SELECT NoFour, RefProd as nb_1prod FROM Produit Group by NoFour HAVING count(RefProd) <=1  ; 

# page 20. 2.Lister les catégories dont les prix sont en moyenne supérieurs strictement à 50 euros
SELECT CodeCateg, round(avg(PrixUnit),2) as Prix_moyen FROM Produit GROUP BY CodeCateg HAVING Prix_moyen > 50;

# page 20 .3.Lister les fournisseurs ne fournissant qu'une seule catégorie de produits
SELECT NoFour, CodeCateg FROM Produit GROUP BY NoFour HAVING Count(CodeCateg) <=1; 

# page 20 4.Lister le Products le plus cher pour chaque fournisseur, pour les Products de plus de 50 euro
SELECT NomProd, NoFour,  MAX(PrixUnit) AS Prix_max FROM Produit GROUP BY NomProd HAVING Prix_max > 50 ORDER BY Prix_max;

# page 22 1.Récupérer les informations des fournisseurs pour chaque produit
SELECT * FROM Produit NATURAL JOIN Fournisseur;

# page 22. 2.Afficher les informations des commandes du client "Lazy K Kountry Store" 
SELECT Societe, Commande.* FROM Client Natural Join Commande where Societe LIKE '%Lazy K Kountry Store%';

# page 22. 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom)
SELECT NoMess, NomMess, count(NoCom) as nb_cmd_mess FROM commande NATURAL JOIN Messager Group by NomMess ;

# page 24. 1.Récupérer les informations des fournisseurs pour chaque produit, avec une jointure interne
SELECT * FROM produit P INNER JOIN fournisseur f ON P.NoFour = f.NoFour;

# page 24. 2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec une jointure interne
SELECT * FROM client cl inner JOIN commande cd  on cl.Codecli = cd.CodeCli where Societe = 'Lazy K Kountry Store';

# page 24. 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec une jointure interne
SELECT NomMess as "Messager", COUNT(NoCom) AS "Nb commande" FROM commande c inner JOIN messager m on c.NoMess = m.NoMess group by NomMess;

# page 26. 1.Compter pour chaque produit, le nombre de commandes où il apparaît, même pour ceux dans aucune commande  (left join)
SELECT Pr.RefProd, count(NoCom) FROM Produit Pr LEFT OUTER JOIN DetailCommande Co ON Pr.RefProd = Co.RefProd;

SELECT Cl.CodeCli, COUNT(NoCom)
FROM Client Cl LEFT OUTER JOIN Commande Co
ON Cl.CodeCli = Co.CodeCli
GROUP BY Cl.CodeCli
ORDER BY 2;

# page 28. 1.Récupérer les informations des fournisseurs pour chaque produit, avec jointure à la main
# page 28. 2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec jointure à la main
# page 28. 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec jointure à la main

# page 30. 1.Lister les employés n'ayant jamais effectué une commande, via une sous-requête
# page 30. 2.Nombre de produits proposés par la société fournisseur "Ma Maison", via une sous-requête
# page 30. 3.Nombre de commandes

# page 30. 1.Lister les employés n'ayant jamais effectué une commande, via une sous-requête
SELECT NoEmp, Nom, Prenom  FROM Employe
WHERE NoEmp NOT IN (SELECT NoEmp FROM Commande);


# page 30 2.Nombre de produits proposés par la société fournisseur "Ma Maison", via une sous-requête
SELECT count(*) FROM Produit
WHERE NoFour = (SELECT NoFour FROM Fournisseur
WHERE Societe = "Ma Maison");

# page 30 3.Nombre de commandes passées par des employés sous la responsabilité de "Buchanan Steven"
# SELECT NoEmp, Nom, Prenom  RendCompteA  FROM employe WHERE RendCompteA = 5;
# SELECT NoEmp, count(NoCom) as Nb_commande FROM Commande Where NoEmp =6 Or NoEmp= 7 OR NoEmp=9 Group by NoEmp  ;
# SELECT count(NoCom) From Commande WHERE NoEmp IN (SELECT  NoEmp, Nom, Prenom  RendCompteA  FROM employe WHERE RendCompteA = 5);
SELECT Count(Nocom) AS "Commandes Passées" FROM Commande
	WHERE NoEmp IN (SELECT NoEmp FROM Employe
	WHERE RendCompteA = (SELECT NoEmp FROM Employe
	WHERE Nom = "Buchanan" AND Prenom = "Steven"));

# page 31. 1.Lister les produits n'ayant jamais été commandés, à l'aide de l'opérateur EXISTS
# page 31. 2.Lister les fournisseurs dont au moins un produit a été livré en France
# page 31. 3.Liste des fournisseurs qui ne proposent que des boissons (drinks)


# Page 33 1.Lister les employés (nom et prénom) étant "Representative" ou étant basé au Royaume-Uni (UK)
SELECT Nom, Prenom, Fonction, Pays FROM employe WHERE Fonction  LIKE "%representative%" UNION
SELECT Nom, Prenom, Fonction, Pays FROM employe WHERE Pays LIKE "UK";
# Si on veut "représentative" et "UK" on fait: 
SELECT Nom, Prenom, Fonction, Pays FROM employe WHERE Pays = "UK" AND Fonction LIKE "%Representative%";

# page 33. 2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) 
# ou ayant été livré par "Speedy Express"
select Societe, Pays
from client c where
Codecli in (select CodeCli from commande cd where NoEmp in (select NoEmp from employe where Ville = 'London') 
and NoMess not in (select NoMess from messager where NomMess="United Package"));

# page 34. 1.Lister les employés (nom et prénom) étant "Representative" mais n'étant pas basé au Royaume-Uni (UK)
SELECT Nom, Prenom, Pays FROM employe a
WHERE Fonction LIKE "%representatative%" AND 
NOT EXISTS (SELECT Nom, Prenom, Pays FROM employe b WHERE Pays = 'UK' and a.NoEmp = b.NoEmp);

# page 34. 2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) 
# et n'ayant jamais été livré par "United Package"
select Societe, Pays
from client c where
Codecli in (select CodeCli from commande cd where NoEmp in (select NoEmp from employe where Ville = 'London') 
and NoMess not in (select NoMess from messager where NomMess="United Package"));
