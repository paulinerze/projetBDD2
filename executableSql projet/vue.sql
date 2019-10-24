CREATE VIEW achatsAnnee AS 
	SELECT EXTRACT(month from dateAchat), count(noEmploye) 
	FROM Achats 
	WHERE EXTRACT(year from dateAchat) = EXTRACT (YEAR FROM SYSDATE)
	GROUP BY dateAchat 
	ORDER BY EXTRACT(month from dateAchat) DESC, count(noEmploye) DESC ;


CREATE VIEW achatsArticle AS
	SELECT EXTRACT(month from dateAchat), refArticle, count(refArticle) 
	FROM achats NATURAL JOIN articles 
	WHERE EXTRACT(year from dateAchat) = EXTRACT (YEAR FROM SYSDATE)
	GROUP BY EXTRACT(month from dateAchat), refArticle 
	ORDER BY EXTRACT(month from dateAchat) DESC, count(refArticle) DESC ;


CREATE VIEW moyAgeMarque AS
	SELECT AVG(ageClient), marque
	FROM clients NATURAL JOIN achats NATURAL JOIN articles 
	WHERE EXTRACT(year from dateAchat) = EXTRACT (YEAR FROM SYSDATE)
	GROUP BY marque
	ORDER BY AVG(ageClient) ASC;


CREATE VIEW pointFidelite AS
	SELECT EXTRACT(month from dateAchat), noClient, nomClient, prenomClient, SUM ( ptFidelite)
	FROM achats NATURAL JOIN clients 
	WHERE EXTRACT (year from dateAchat) = EXTRACT (YEAR FROM SYSDATE)
	GROUP BY EXTRACT(month from dateAchat), noClient, nomClient, prenomClient
	ORDER BY EXTRACT(month from dateAchat) DESC, SUM (ptFidelite) DESC ;

