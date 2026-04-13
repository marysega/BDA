/*
GOEH AKUE Maryse
Numero etudiant : 12101028
Exercice 2
*/

SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE emp';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE emp (
    matr NUMBER(10) NOT NULL,
    nom VARCHAR2(50) NOT NULL,
    sal NUMBER(7,2),
    adresse VARCHAR2(96),
    dep NUMBER(10) NOT NULL,
    CONSTRAINT emp_pk PRIMARY KEY (matr)
);

INSERT INTO emp VALUES (1, 'Alice', 2000, 'Paris', 92000);
INSERT INTO emp VALUES (2, 'Benoit', 2500, 'Lyon', 75000);
INSERT INTO emp VALUES (3, 'Claire', 1800, 'Marseille', 92000);
COMMIT;

-- Question 1
DECLARE
    v_employe emp%ROWTYPE;
BEGIN
    v_employe.matr := 4;
    v_employe.nom := 'Youcef';
    v_employe.sal := 2500;
    v_employe.adresse := 'Avenue de la Republique';
    v_employe.dep := 92002;

    INSERT INTO emp VALUES v_employe;
    DBMS_OUTPUT.PUT_LINE('Employe ajoute');
END;
/

-- Question 2
DECLARE
    v_nb_lignes NUMBER;
BEGIN
    DELETE FROM emp WHERE dep = 10;
    v_nb_lignes := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Lignes supprimees : ' || v_nb_lignes);
END;
/

-- Question 3
DECLARE
    v_salaire emp.sal%TYPE;
    v_total emp.sal%TYPE := 0;

    CURSOR c_salaires IS
        SELECT sal FROM emp;
BEGIN
    OPEN c_salaires;

    LOOP
        FETCH c_salaires INTO v_salaire;
        EXIT WHEN c_salaires%NOTFOUND;

        IF v_salaire IS NOT NULL THEN
            v_total := v_total + v_salaire;
        END IF;
    END LOOP;

    CLOSE c_salaires;
    DBMS_OUTPUT.PUT_LINE('Somme des salaires : ' || v_total);
END;
/

-- Question 4
DECLARE
    v_salaire emp.sal%TYPE;
    v_total NUMBER := 0;
    v_nb NUMBER := 0;

    CURSOR c_salaires IS
        SELECT sal FROM emp;
BEGIN
    OPEN c_salaires;

    LOOP
        FETCH c_salaires INTO v_salaire;
        EXIT WHEN c_salaires%NOTFOUND;

        IF v_salaire IS NOT NULL THEN
            v_total := v_total + v_salaire;
            v_nb := v_nb + 1;
        END IF;
    END LOOP;

    CLOSE c_salaires;

    IF v_nb > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Salaire moyen : ' || (v_total / v_nb));
    END IF;
END;
/

-- Question 5
DECLARE
    v_total NUMBER := 0;
    v_nb NUMBER := 0;
BEGIN
    FOR ligne IN (SELECT sal FROM emp) LOOP
        IF ligne.sal IS NOT NULL THEN
            v_total := v_total + ligne.sal;
            v_nb := v_nb + 1;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Somme : ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Moyenne : ' || (v_total / v_nb));
END;
/

-- Question 6
DECLARE
    CURSOR c(p_dep emp.dep%TYPE) IS
        SELECT nom
        FROM emp
        WHERE dep = p_dep;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employes du departement 92000');
    FOR v_employe IN c(92000) LOOP
        DBMS_OUTPUT.PUT_LINE(v_employe.nom);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Employes du departement 75000');
    FOR v_employe IN c(75000) LOOP
        DBMS_OUTPUT.PUT_LINE(v_employe.nom);
    END LOOP;
END;
/

SELECT * FROM emp;
