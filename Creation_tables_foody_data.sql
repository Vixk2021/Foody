# DROP DATABASE IF exists Foody_data; 

CREATE DATABASE IF NOT EXISTS Foody_data ;
USE Foody_data;

CREATE TABLE Client
(Codecli VARCHAR (50) PRIMARY KEY, 
Societe VARCHAR (50),
Contact VARCHAR (50), 
Fonction VARCHAR (50),
Adresse VARCHAR (100), 
Ville VARCHAR (50),
Region VARCHAR (50),
Codepostal VARCHAR (50),
Pays VARCHAR (50),
Tel VARCHAR (50),
Fax VARCHAR (50)
);

CREATE TABLE Messager
( NoMess INT PRIMARY KEY, 
NomMess VARCHAR(50), 
Tel VARCHAR(50)
);

CREATE TABLE Fournisseur
( NoFour INT PRIMARY KEY,
Societe VARCHAR(50),
Contact VARCHAR(50),
Fonction VARCHAR(50),
Adresse VARCHAR(100),
Ville VARCHAR(50),
Region VARCHAR(50),
CodePostal VARCHAR(50),
Pays VARCHAR(50),
Tel VARCHAR(50),
Fax VARCHAR(50),
PageAccueil VARCHAR(200)
); 

CREATE TABLE Categorie
(CodeCateg INT PRIMARY KEY,
NomCateg  VARCHAR(50),
Descriptionn VARCHAR(200)
);

CREATE TABLE Employe
(NoEmp INT PRIMARY KEY, 
Nom VARCHAR(50), 
Prenom VARCHAR(50), 
Fonction VARCHAR(50), 
TitreCourtoisie VARCHAR(50),
DateNaissance DATETIME, 
DateEmbauche DATETIME, 
Adresse VARCHAR(50), 
Ville VARCHAR(50), 
Region VARCHAR(50), 
Codepostal VARCHAR(50),
Pays VARCHAR(50),
TelDom VARCHAR(50),
Extension INT, 
RendCompteA INT
);

CREATE TABLE Produit
(RefProd INT PRIMARY KEY,
NomProd VARCHAR(50),
NoFour INT,
CodeCateg INT,
QteParUnit VARCHAR(50),
PrixUnit FLOAT, 
UnitesStock INT,
UnitesCom INT,
NiveauReap INT,
Indisponible INT
);

CREATE TABLE DetailCommande (  
NoCom INT,
RefProd INT,
PrixUnit FLOAT, 
Qte INT,
Remise FLOAT,
PRIMARY KEY (NoCom, RefProd)
);

CREATE TABLE Commande
( NoCom INT PRIMARY KEY, 
CodeCli VARCHAR (50),
NoEmp INT, 
DateCom DATETIME, 
ALivAvant DATETIME,
DateEnv DATETIME, 
NoMess INT, 
Portt FLOAT, 
Destinataire VARCHAR(50),
AdrLiv VARCHAR(50),
VilleLiv VARCHAR(50),
RegionLiv VARCHAR(50),
CodePostalLiv VARCHAR(50),
PaysLiv VARCHAR(50)
);

Alter TABLE DetailCommande ADD FOREIGN KEY (NoCom) references Commande(NoCom);
Alter TABLE DetailCommande ADD FOREIGN KEY (RefProd) references Produit(RefProd);
Alter TABLE Produit ADD FOREIGN KEY (NoFour) references Fournisseur (NoFour);
Alter TABLE Produit ADD FOREIGN KEY (CodeCateg) references Categorie(CodeCateg);
Alter TABLE Employe ADD FOREIGN KEY (RendCompteA) references Employe (NoEmp);
Alter TABLE Commande ADD FOREIGN KEY (NoEmp) references Employe (NoEmp);
Alter TABLE Commande ADD FOREIGN KEY (NoMess) references Messager(NoMess);
Alter TABLE Commande ADD FOREIGN KEY (CodeCli) references Client(CodeCli);

SHOW VARIABLES LIKE "local_infile";
SET GLOBAL local_infile = 'ON'; 
SHOW VARIABLES LIKE "secure_file_priv";
set global local_infile=1;
LOAD DATA LOCAL INFILE 
'C:\\Users\\Vixra KEO\\Dropbox\\Simplon_encrypted\\Programmation\\SQL\\Projet_Foody\\data_foody\\categorie.csv'
INTO TABLE Categorie
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# load data infile 'categorie.csv' into table Categorie;

SELECT * FROM Client;
SELECT * FROM Commande;
SELECT * FROM DetailCommande; 
SELECT * FROM Fournisseur;
SELECT * FROM Messager;
SELECT * FROM Employe; 
SELECT * FROM Produit;
SELECT * FROM Categorie; 

# Alter TABLE Employe DROP FOREIGN KEY RendCompteA_CONTRAINT, DROP KEY RendCompteA_FOREIGN_KEY;

ALTER TABLE table_name
  DROP FOREIGN KEY the_name_after_CONSTRAINT,
  DROP KEY the_name_after_FOREIGN_KEY;