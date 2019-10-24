DROP TABLE Clients CASCADE CONSTRAINTS;
DROP TABLE Articles CASCADE CONSTRAINTS;
DROP TABLE Employes CASCADE CONSTRAINTS;
DROP TABLE Achats CASCADE CONSTRAINTS;

CREATE TABLE Clients (
	noClient int,
	nomClient varchar2(25),
	prenomClient varchar2(25),
	ageClient int,
	ptFidelite int,
	mailClient varchar2(50),
	adresseClient varchar2(50),
	telClient int,
	CONSTRAINT Clients_PK PRIMARY KEY(noClient)
);

CREATE TABLE Articles (
	refArticle int,
	modele varchar2(25),
	prix int,
	categorie varchar2(25),
	marque varchar2(25),
	CONSTRAINT Articles_PK PRIMARY KEY(refArticle)
);

CREATE TABLE Employes (
	noEmploye int,
	postEmploye varchar2(25),
	nomEploye varchar2(50),
	prenomEmploye varchar2(50),
	CONSTRAINT Employes_PK PRIMARY KEY(noEmploye)
);

CREATE TABLE Achats (
	noAchat int,
	dateAchat date,
	refArticle int CONSTRAINT acha_refArticle_FK REFERENCES Articles(refArticle),
	noClient int CONSTRAINT acha_noClient_FK REFERENCES Clients(noClient),
	noEmploye int CONSTRAINT acha_noEmploye_FK REFERENCES Employes(noEmploye),
	CONSTRAINT Achat_PK PRIMARY KEY(noAchat)
);

--Création des tuples

INSERT INTO Clients values (1,'MARTIN','Emma',56,200,'emma.martin@mail.fr','60, rue de la Boétie 97110 POINTE-À-PITRE',0298675467);
INSERT INTO Clients values (2,'BERNARD','Léa',34,120,'lebernard@mail.fr','17, rue du Fossé des Tanneurs 83200 TOULON ',0298675468);
INSERT INTO Clients values (3,'ROUX','Nathan',22,140,'roux.nathan@mail.fr','28, rue de Groussay 93110 ROSNY-SOUS-BOIS',0298675469);
INSERT INTO Clients values (4,'THOMAS','Enzo',45,75,'thomas.enzo@mail.fr','12, rue Banaudon 69008 LYON',0298675445);
INSERT INTO Clients values (5,'PETIT','Maelys',45,110,'petit.maelys@mail.fr','43, Rue Bonnet 59150 WATTRELOS ',0298675446);
INSERT INTO Clients values (6,'DURAND','Clara',67,50,'durand.clara@mail.fr','10, rue de la Tadevinière 49270 ST SAUVEUR',0248675467);
INSERT INTO Clients values (7,'MICHEL','louis',47,21,'michel.louis@mail.fr','2 Les Moussins 18210 VERNAIS',0218223355);
INSERT INTO Clients values (8,'ROBERT','Hugo',25,148,'robert.hugo@mail.fr','30 Route de Viersat 03380 QUINSSAINES',0298255467);
INSERT INTO Clients values (9,'RICHARD','Gabriel',24,250,'richard.gabriel@mail.fr','6 D525 02190 GUIGNICOURT',0298675367);
INSERT INTO Clients values (10,'SIMON','Louna',36,198,'simon.louna@mail.fr','3 Route de Campo Dell Oro 20090 AJACCIO',0286871331);


INSERT INTO Articles values (7752718,'Veste1',30,'Veste','marque3');
INSERT INTO Articles values (8726187,'Veste2',50,'Veste','marque4');
INSERT INTO Articles values (7392045,'Pantalon1',30,'Pantalon','marque5');
INSERT INTO Articles values (3827403,'Pantalon2',35,'Pantalon','marque5');
INSERT INTO Articles values (3847209,'Veste1',40,'Veste','marque7');
INSERT INTO Articles values (8375436,'Veste2',25,'Veste','marque3');
INSERT INTO Articles values (3729847,'Chaussure1',30,'Chaussure','marque6');

INSERT INTO Employes values (1,'Directeur','Cousteau','Octave');
INSERT INTO Employes values (2,'Vendeuse','Desaulniers','Charlotte');
INSERT INTO Employes values (3,'Chef de rayon','Duplanty','Aliénor');
INSERT INTO Employes values (4,'Vendeur','Grandbois','Aurélien');
INSERT INTO Employes values (5,'Vendeur','Aubé','Léon');
INSERT INTO Employes values (6,'Comptable','Pelletier','Mathilde');
INSERT INTO Employes values (7,'Vendeur','Beauchamps','Antoine');

INSERT INTO Achats values (1,TO_DATE('2018-06-05', 'YYYY-MM-DD'),3847209,2,2);
INSERT INTO Achats values (2,TO_DATE('2018-05-15', 'YYYY-MM-DD'),8726187,3,2);
INSERT INTO Achats values (3,TO_DATE('2018-06-10', 'YYYY-MM-DD'),8375436,1,5);
INSERT INTO Achats values (4,TO_DATE('2018-04-25', 'YYYY-MM-DD'),7392045,2,7);
INSERT INTO Achats values (5,TO_DATE('2018-06-11', 'YYYY-MM-DD'),7752718,4,7);
INSERT INTO Achats values (6,TO_DATE('2018-06-29', 'YYYY-MM-DD'),7392045,5,7);
