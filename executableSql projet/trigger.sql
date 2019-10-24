CREATE OR REPLACE TRIGGER err_dateachat
BEFORE INSERT OR UPDATE
ON Achats FOR EACH ROW
DECLARE
    datedujour Achats.dateAchat%type;
        error_date EXCEPTION;

BEGIN
    select to_char(sysdate,'YYYY-MM-DD') into datedujour
    from dual;
    IF :new.dateAchat IS NOT NULL THEN
        IF :new.dateAchat > datedujour THEN
            RAISE error_date;
        END IF;
    ELSE
        RAISE error_date;
    END IF;


EXCEPTION
      WHEN error_date
      THEN RAISE_APPLICATION_ERROR('2000S','err');

END;
/

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER err_prix_negatif
BEFORE INSERT OR UPDATE
ON Articles FOR EACH ROW
DECLARE
    error_price EXCEPTION;

BEGIN
    IF :new.prix IS NULL THEN
          RAISE error_price;
    ELSIF :new.prix < 0 THEN
          RAISE error_price;
    END IF;

    EXCEPTION
      WHEN error_price
      THEN RAISE_APPLICATION_ERROR('2000S','Erreur: vous ne pouvez pas saisir un prix nul ou négatif');

END;
/

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER before_ins_upd_err_ageClient
BEFORE INSERT OR UPDATE
ON Clients FOR EACH ROW
DECLARE
    error_ageClient EXCEPTION;

BEGIN
    IF :new.ageclient > 100 THEN
          RAISE error_ageClient;
    ELSIF :new.ageclient < 0 THEN
        RAISE error_ageClient;
    END IF;

    EXCEPTION
      WHEN error_ageClient
      THEN RAISE_APPLICATION_ERROR('2000S','Erreur : âge incorrect');

END;
/



CREATE OR REPLACE FUNCTION calculPoints (prix IN NUMBER)
RETURN NUMBER
IS
    pts Clients.ptFidelite%type;
BEGIN
    pts := prix*0.1;
    RETURN pts;
END;
/


SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER aug_points_fidelite
BEFORE INSERT OR UPDATE
ON Achats FOR EACH ROW
DECLARE
    monPrix Articles.prix%type;
BEGIN
    SELECT prix INTO monPrix
    FROM Articles
    WHERE Articles.refArticle = :new.refArticle;

    update Clients
    set ptFidelite = ptFidelite + calculPoints(monPrix)
    where Clients.noClient = noCLient;
END;
/

