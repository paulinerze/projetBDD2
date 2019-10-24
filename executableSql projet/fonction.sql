SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE best_employe (argument IN DATE)
IS
    numEmp Employes.noEmploye%type;
    nombrevente int;
    PAS_DACHAT EXCEPTION;

BEGIN
    SELECT noEmploye INTO numEmp
    FROM Achats
    GROUP BY noEmploye
    HAVING COUNT (noEmploye)=(SELECT MAX(mycount)
                   FROM ( SELECT noEmploye, COUNT(noEmploye) mycount
                         FROM Achats
            where dateAchat=argument
                       GROUP BY noEmploye));

    SELECT MAX (mycount) INTO nombrevente
    FROM (SELECT noEmploye,COUNT(noEmploye) mycount
        FROM Achats
        where dateAchat=argument
        GROUP BY noEmploye);


    IF numEmp IS NULL THEN
        RAISE PAS_DACHAT;
    ELSE
        DBMS_OUTPUT.put_line('Le meilleur vendeur pour la date: ' ||argument||' est '||numEmp||' avec '||nombrevente||'  vente ');
        END IF;

    EXCEPTION
        WHEN PAS_DACHAT
        THEN DBMS_OUTPUT.put_line('Pas de meilleure vente ou Aucun achat à cette date');

END;
/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE best_seller (laMarqueChoisie IN VARCHAR2)
IS
    ref Articles.refArticle%type;
    nombreArticles int;
    PAS_D_ARTICLE EXCEPTION;
BEGIN
    SELECT refArticle INTO ref
    FROM Achats NATURAL JOIN Articles
    WHERE Articles.marque = laMarqueChoisie
    GROUP BY refArticle
    HAVING COUNT (refArticle)=(SELECT MAX(mycount)
                   FROM ( SELECT refArticle, COUNT(refArticle) mycount
                         FROM Achats
                       GROUP BY refArticle));
    SELECT MAX (mycount) INTO nombreArticles
    FROM (SELECT refArticle,COUNT(refArticle) mycount
        FROM Achats NATURAL JOIN Articles
        WHERE Articles.marque = laMarqueChoisie
        GROUP BY refArticle);

    IF (ref is null) THEN RAISE PAS_D_ARTICLE;
    ELSIF (nombreArticles<2) THEN RAISE PAS_D_ARTICLE;
    ELSE
    DBMS_OUTPUT.put_line('L article qui se vend le mieux pour la marque: ' ||laMarqueChoisie||' est '||ref||' avec '||nombreArticles||' exemplaires');
    END IF;

    EXCEPTION
        WHEN PAS_D_ARTICLE
        THEN DBMS_OUTPUT.put_line('Pas de best seller pour cette marque ou marque inexistante');

END;
/


SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE ca_mois_annee (mois int, annee int)
IS
    revenu Articles.prix%type;
    PAS_D_ACHAT EXCEPTION;
BEGIN
    SELECT SUM(Articles.prix) INTO revenu
    FROM Achats NATURAL JOIN Articles
    WHERE (extract(month from Achats.dateachat) = mois
        AND extract(year from Achats.dateachat) = annee)
    ;

    IF (revenu is null) THEN RAISE PAS_D_ACHAT;
    ELSE
    DBMS_OUTPUT.put_line('Le ' ||mois|| '/' ||annee||', le revenu était de ' ||revenu|| '€.');
    END IF;

    EXCEPTION
        WHEN PAS_D_ACHAT
        THEN DBMS_OUTPUT.put_line('Aucun achat ne correspond à cette date.');

END;
/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE purchase_type (argument IN NUMBER)
IS
    moo Clients.noClient%type;
    PAS_D_ACHAT EXCEPTION;
BEGIN

    SELECT modele INTO moo
    FROM Achats NATURAL JOIN Articles
    WHERE noClient = argument
      ORDER BY modele DESC;

    
    IF moo is null THEN RAISE PAS_D_ACHAT;
    ELSE
    DBMS_OUTPUT.put_line('Le dernier article acheté par le client '||argument||' est '||moo);
    END IF;

    EXCEPTION
        WHEN PAS_D_ACHAT
        THEN DBMS_OUTPUT.put_line('Pas d’achat pour ce client ou client inexistant');

END;
/

