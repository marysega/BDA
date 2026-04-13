/*
GOEH AKUE Maryse
Numero etudiant : 12101028
Exercice 1
*/

SET SERVEROUTPUT ON;

-- Question 1
ACCEPT a PROMPT 'Entrer le premier entier : '
ACCEPT b PROMPT 'Entrer le deuxieme entier : '

DECLARE
    v_a NUMBER := &a;
    v_b NUMBER := &b;
BEGIN
    DBMS_OUTPUT.PUT_LINE('La somme est : ' || (v_a + v_b));
END;
/

-- Question 2
ACCEPT n PROMPT 'Entrer un nombre : '

DECLARE
    v_n NUMBER := &n;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_n || ' x ' || i || ' = ' || (v_n * i));
    END LOOP;
END;
/

-- Question 3
CREATE OR REPLACE FUNCTION puissance(x NUMBER, n NUMBER)
RETURN NUMBER
IS
BEGIN
    IF n = 0 THEN
        RETURN 1;
    ELSE
        RETURN x * puissance(x, n - 1);
    END IF;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('2 puissance 3 = ' || puissance(2, 3));
END;
/

-- Question 4
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE resultatFactoriel';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE resultatFactoriel (
    nombre NUMBER,
    factorielle NUMBER
);

ACCEPT f PROMPT 'Entrer un nombre strictement positif : '

DECLARE
    v_n NUMBER := &f;
    v_fact NUMBER := 1;
BEGIN
    FOR i IN 1..v_n LOOP
        v_fact := v_fact * i;
    END LOOP;

    INSERT INTO resultatFactoriel VALUES (v_n, v_fact);
    DBMS_OUTPUT.PUT_LINE('Factorielle de ' || v_n || ' = ' || v_fact);
END;
/

-- Question 5
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE resultatsFactoriels';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE resultatsFactoriels (
    nombre NUMBER,
    factorielle NUMBER
);

DECLARE
    v_fact NUMBER;
BEGIN
    FOR n IN 1..20 LOOP
        v_fact := 1;
        FOR i IN 1..n LOOP
            v_fact := v_fact * i;
        END LOOP;

        INSERT INTO resultatsFactoriels VALUES (n, v_fact);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Les resultats ont ete enregistres.');
END;
/

SELECT * FROM resultatsFactoriels;
