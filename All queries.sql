

-- Creation de table Details factures

CREATE TABLE Detail_Facteurs
(
	Date_facture VARCHAR(200),
	Facture VARCHAR(200),
	Client VARCHAR(200),
	Vendeur VARCHAR(200),
	PU_HT FLOAT,
	Code_article INT,
	PROMO CHAR,
	Classe_Produit CHAR,
	Qté_facturée FLOAT
)

-- Remplissage du table
BULK INSERT Detail_Facteurs
FROM 'D:\BI\details_fact.csv'
WITH (FORMAT = 'CSV');

-- Creation de table Clients

CREATE TABLE Clients
(
	Client VARCHAR(200),
	Nom_Client VARCHAR(200),
	Actif VARCHAR(200),
	Secteur VARCHAR(200),
	Libelle_Secteur VARCHAR(200),
	Region VARCHAR(200),
	Ville VARCHAR(200),
	Last_resp VARCHAR(200),
	Nom_Last_rep VARCHAR(200)
)

-- Remplissage du table client 

BULK INSERT Clients
FROM 'D:\BI\list_clients.csv'
WITH (FORMAT = 'CSV');

-- Creation du table ListeArticles

CREATE TABLE ListeArticles
(
	Code_article INT,
	Description_article VARCHAR(200),
	Marque VARCHAR(200),
	Gamme VARCHAR(200),
	Libelle_Gamme VARCHAR(200),
	Ligne_prod VARCHAR(200),
	Fournisseur VARCHAR(200),
	Site_article VARCHAR(200), 
	PCB_vente VARCHAR(200),
	PCB_achat VARCHAR(200),
	Prix_unitaire VARCHAR(200),
	Poids_expedition  VARCHAR(200),
	Stock_type  VARCHAR(200),
	Point_de_commande  VARCHAR(200),
	Camion_C01 VARCHAR(200),
	Camion_C02 VARCHAR(200),
	Camion_C03 VARCHAR(200),
	Camion_C04 VARCHAR(200),
	Camion_C05 VARCHAR(200),
	Camion_C06 VARCHAR(200),
	Camion_C07 VARCHAR(200)
)
--Remplissage du table ListeArticles

BULK INSERT ListeArticles
FROM 'D:\BI\Liste_article.csv'
WITH (FORMAT = 'CSV');


-- Creation du vue pour TB1

CREATE VIEW TB1 AS 


SELECT a.Date_facture,a.PU_HT,a.Qté_facturée,a.Vendeur,b.Libelle_Secteur,a.Nom_Vendeur, b.Nom_Client,b.Region FROM
	
	(SELECT * from Detail_Facteurs,Vendeurs WHERE Detail_Facteurs.Vendeur = Vendeurs.Code) a

	LEFT JOIN

	(SELECT * FROM Clients) b
	ON a.Client = b.Client


-- Creation du vue pour TB2

CREATE VIEW TB2 AS 
SELECT a.Date_facture,a.PU_HT,a.Qté_facturée,a.Classe_Produit,b.Marque,b.Gamme,b.Libelle_Gamme FROM
	(SELECT * FROM Detail_Facteurs) a

	LEFT JOIN
	(SELECT * FROM ListeArticles) b
	ON a.Code_article = b.Code_article