/*
GOEH AKUE Maryse
Numero etudiant : 12101028
Exercice 3
*/

SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE client';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE client (
    id_client NUMBER PRIMARY KEY,
    nom VARCHAR2(50) NOT NULL,
    ville VARCHAR2(50)
);

CREATE OR REPLACE PACKAGE gestion_client AS
    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2, p_ville VARCHAR2);
    PROCEDURE ajouter_client(p_nom VARCHAR2, p_ville VARCHAR2);
END gestion_client;
/

CREATE OR REPLACE PACKAGE BODY gestion_client AS

    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2, p_ville VARCHAR2) IS
    BEGIN
        INSERT INTO client VALUES (p_id, p_nom, p_ville);
        DBMS_OUTPUT.PUT_LINE('Client ajoute');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erreur : id deja existant');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur pendant l''ajout');
    END ajouter_client;

    PROCEDURE ajouter_client(p_nom VARCHAR2, p_ville VARCHAR2) IS
        v_id NUMBER;
    BEGIN
        SELECT NVL(MAX(id_client), 0) + 1 INTO v_id FROM client;

        INSERT INTO client VALUES (v_id, p_nom, p_ville);
        DBMS_OUTPUT.PUT_LINE('Client ajoute automatiquement');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur pendant l''ajout automatique');
    END ajouter_client;

END gestion_client;
/

BEGIN
    gestion_client.ajouter_client(1, 'Awa', 'Abidjan');
    gestion_client.ajouter_client('Mariam', 'Bouake');
    gestion_client.ajouter_client(1, 'Kone', 'Yamoussoukro');
END;
/

SELECT * FROM client;
