-- 4
CREATE TABLE angajat(
    cod_angajat NUMBER(4) PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    salariu NUMBER(6),
    CONSTRAINT salariu_pozitiv CHECK (salariu > 0));
    
CREATE TABLE asistenta(
    cod_angajat NUMBER(4) PRIMARY KEY REFERENCES angajat(cod_angajat) ON DELETE CASCADE,
    ore_pe_sapt NUMBER(3));
    
CREATE TABLE doctor(
    cod_angajat NUMBER(4) PRIMARY KEY REFERENCES angajat(cod_angajat) ON DELETE CASCADE,
    ani_experieta NUMBER(3),
    specializare VARCHAR2(50));
    
CREATE TABLE camera(
    cod_camera NUMBER(4) PRIMARY KEY,
    nr_paturi NUMBER(2),
    etaj NUMBER(2));
    
CREATE TABLE lucreaza(
    cod_angajat NUMBER(4),
    cod_camera NUMBER(4),
    CONSTRAINT lucreaza_pk PRIMARY KEY (cod_angajat, cod_camera),
    CONSTRAINT fk_cod_angajat FOREIGN KEY (cod_angajat) REFERENCES asistenta(cod_angajat) ON DELETE CASCADE,
    CONSTRAINT fk_cod_camera FOREIGN KEY (cod_camera) REFERENCES camera(cod_camera) ON DELETE CASCADE);
    
CREATE TABLE pat(
    cod_pat NUMBER(4) PRIMARY KEY,
    cod_camera NUMBER(4),
    lungime NUMBER(4, 2),
    PRIMARY KEY (cod_pat, cod_camera),
    FOREIGN KEY (cod_camera) REFERENCES camera(cod_camera) ON DELETE CASCADE);
    
CREATE TABLE pacient(
    cod_pacient NUMBER(4) PRIMARY KEY,
    telefon VARCHAR2(10) NOT NULL,
    sex CHAR(1),
    CONSTRAINT verif_sex CHECK (sex IN ('M', 'F')));
    
CREATE TABLE ocupa(
    cod_pacient NUMBER(4),
    cod_pat NUMBER(4),
    cod_camera NUMBER(4),
    data_internare DATE NOT NULL,
    data_plecare DATE NOT NULL,
    PRIMARY KEY (cod_pacient, cod_camera, cod_pat),
    FOREIGN KEY (cod_pacient) REFERENCES pacient(cod_pacient) ON DELETE CASCADE,
    FOREIGN KEY (cod_pat, cod_camera) REFERENCES pat(cod_pat, cod_camera) ON DELETE CASCADE);

-- am schimbat niste detalii
ALTER TABLE ocupa MODIFY data_plecare NULL;
ALTER TABLE ocupa DROP PRIMARY KEY;
ALTER TABLE ocupa 
ADD CONSTRAINT pk_ocupa PRIMARY KEY (cod_pacient, cod_pat, cod_camera, data_internare);
    
CREATE TABLE consulta(
    cod_angajat NUMBER(4),
    cod_pacient NUMBER(4),
    data DATE DEFAULT SYSDATE,
    PRIMARY KEY (cod_angajat, cod_pacient),
    FOREIGN KEY (cod_angajat) REFERENCES doctor(cod_angajat) ON DELETE CASCADE,
    FOREIGN KEY (cod_pacient) REFERENCES pacient(cod_pacient) ON DELETE CASCADE);
    
CREATE TABLE tratament(
    cod_tratament NUMBER(4) PRIMARY KEY,
    cod_angajat NUMBER(4),
    durata_zile NUMBER(5),
    cost NUMBER(5,2),
    FOREIGN KEY (cod_angajat) REFERENCES doctor(cod_angajat));
    
CREATE TABLE medicament(
    cod_medicament NUMBER(4) PRIMARY KEY,
    denumire VARCHAR2(30),
    cantitate_stoc INT DEFAULT 0,
    doza_recomandata NUMBER(10, 2), 
    unitate_de_masura VARCHAR2(10) NOT NULL);
    
CREATE TABLE necesita(
    cod_tratament NUMBER(4),
    cod_medicament NUMBER(4),
    PRIMARY KEY (cod_tratament, cod_medicament),
    FOREIGN KEY (cod_tratament) REFERENCES tratament(cod_tratament) ON DELETE CASCADE,
    FOREIGN KEY (cod_medicament) REFERENCES medicament(cod_medicament) ON DELETE CASCADE);
    
CREATE TABLE boala(
    cod_boala NUMBER(4) PRIMARY KEY,
    denumire VARCHAR2(50) UNIQUE,
    tip_boala VARCHAR2(30),
    nr_cazuri INT);
    
CREATE TABLE primeste(
    cod_pacient NUMBER(4),
    cod_tratament NUMBER(4),
    cod_boala NUMBER(4),
    data DATE default SYSDATE,
    PRIMARY KEY (cod_pacient, cod_tratament, cod_boala),
    FOREIGN KEY (cod_pacient) REFERENCES pacient(cod_pacient) ON DELETE CASCADE,
    FOREIGN KEY (cod_tratament) REFERENCES tratament(cod_tratament) ON DELETE CASCADE,
    FOREIGN KEY (cod_boala) REFERENCES boala(cod_boala) ON DELETE CASCADE);

-- 5

-- Inseram in tabelul 'angajat' pentru asistente
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (101, 'Maria Popescu', 3000);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (102, 'Ion Ionescu', 3200);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (103, 'Elena Vasilescu', 3100);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (104, 'Carmen Dumitru', 3050);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (105, 'Ana Mihai', 3150);

select * from angajat;

Delete from angajat;

-- Inseram in tabelul 'asistenta'
INSERT INTO asistenta (cod_angajat, ore_pe_sapt) VALUES (101, 40);
INSERT INTO asistenta (cod_angajat, ore_pe_sapt) VALUES (102, 36);
INSERT INTO asistenta (cod_angajat, ore_pe_sapt) VALUES (103, 38);
INSERT INTO asistenta (cod_angajat, ore_pe_sapt) VALUES (104, 35);
INSERT INTO asistenta (cod_angajat, ore_pe_sapt) VALUES (105, 37);

select * from asistenta;

-- Inseram in tabelul 'angajat' pentru doctori
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (201, 'Dan Gheorghe', 7000);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (202, 'Radu Iliescu', 7500);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (203, 'Alina Tudor', 7200);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (204, 'Victor Pavel', 7300);
INSERT INTO angajat (cod_angajat, nume, salariu) VALUES (205, 'Andreea Marin', 7400);

select * from angajat;

-- Inseram in tabelul 'doctor'
INSERT INTO doctor (cod_angajat, ani_experieta, specializare) VALUES (201, 10, 'Cardiologie');
INSERT INTO doctor (cod_angajat, ani_experieta, specializare) VALUES (202, 12, 'Neurologie');
INSERT INTO doctor (cod_angajat, ani_experieta, specializare) VALUES (203, 8, 'Pediatrie');
INSERT INTO doctor (cod_angajat, ani_experieta, specializare) VALUES (204, 15, 'Oncologie');
INSERT INTO doctor (cod_angajat, ani_experieta, specializare) VALUES (205, 20, 'Ortopedie');

select * from doctor;

-- Inseram in tabelul 'camera'
INSERT INTO camera (cod_camera, nr_paturi, etaj) VALUES (1, 2, 1);
INSERT INTO camera (cod_camera, nr_paturi, etaj) VALUES (2, 3, 1);
INSERT INTO camera (cod_camera, nr_paturi, etaj) VALUES (3, 4, 2);
INSERT INTO camera (cod_camera, nr_paturi, etaj) VALUES (4, 2, 2);
INSERT INTO camera (cod_camera, nr_paturi, etaj) VALUES (5, 1, 3);

select * from camera;

-- Inseram in tabelul 'lucreaza'
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (101, 1);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (101, 2);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (102, 2);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (102, 3);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (103, 3);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (103, 4);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (104, 4);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (104, 5);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (105, 1);
INSERT INTO lucreaza (cod_angajat, cod_camera) VALUES (105, 5);

select * from lucreaza;

-- Inseram in tabelul 'pat'
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (101, 1, 2.00);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (102, 1, 1.95);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (103, 2, 2.10);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (104, 2, 1.85);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (105, 2, 2.00);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (106, 3, 2.00);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (107, 3, 2.10);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (108, 3, 1.90);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (109, 3, 2.05);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (110, 4, 1.80);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (111, 4, 1.95);
INSERT INTO pat (cod_pat, cod_camera, lungime) VALUES (112, 5, 2.20);

select * from pat;


-- Inseram in tabelul 'pacient'
INSERT INTO pacient (cod_pacient, telefon, sex) VALUES (201, '0712345678', 'M');
INSERT INTO pacient (cod_pacient, telefon, sex) VALUES (202, '0723456789', 'F');
INSERT INTO pacient (cod_pacient, telefon, sex) VALUES (203, '0734567890', 'M');
INSERT INTO pacient (cod_pacient, telefon, sex) VALUES (204, '0745678901', 'F');
INSERT INTO pacient (cod_pacient, telefon, sex) VALUES (205, '0756789012', 'M');

select * from pacient;

-- Inseram in tabelul 'ocupa'
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (201, 101, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (201, 102, 1, TO_DATE('2024-01-11', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (202, 103, 2, TO_DATE('2024-01-05', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (202, 104, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'), TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (202, 105, 2, TO_DATE('2024-01-26', 'YYYY-MM-DD'), TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (203, 106, 3, TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (204, 110, 4, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (204, 111, 4, TO_DATE('2024-01-26', 'YYYY-MM-DD'), TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (205, 112, 5, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO ocupa (cod_pacient, cod_pat, cod_camera, data_internare, data_plecare) VALUES (205, 102, 1, TO_DATE('2024-01-11', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'));

select * from ocupa;

-- Inseram in tabelul 'consulta'
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (201, 201, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (201, 202, TO_DATE('2024-01-02', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (201, 203, TO_DATE('2024-01-03', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (202, 201, TO_DATE('2024-01-04', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (202, 204, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (203, 205, TO_DATE('2024-01-06', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (204, 202, TO_DATE('2024-01-07', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (204, 203, TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (205, 204, TO_DATE('2024-01-09', 'YYYY-MM-DD'));
INSERT INTO consulta (cod_angajat, cod_pacient, data) VALUES (205, 205, TO_DATE('2024-01-10', 'YYYY-MM-DD'));

select * from consulta;

-- Inseram in tabelul 'tratament'
INSERT INTO tratament (cod_tratament, cod_angajat, durata_zile, cost) VALUES (401, 201, 10, 150.00);
INSERT INTO tratament (cod_tratament, cod_angajat, durata_zile, cost) VALUES (402, 202, 15, 200.00);
INSERT INTO tratament (cod_tratament, cod_angajat, durata_zile, cost) VALUES (403, 203, 7, 800.50);
INSERT INTO tratament (cod_tratament, cod_angajat, durata_zile, cost) VALUES (404, 204, 20, 900.75);
INSERT INTO tratament (cod_tratament, cod_angajat, durata_zile, cost) VALUES (405, 205, 5, 500.00);

select * from tratament;

-- Inseram in tabelul 'medicament'
INSERT INTO medicament (cod_medicament, denumire, cantitate_stoc, doza_recomandata, unitate_de_masura) VALUES (501, 'Paracetamol', 500, 2.00, 'mg');
INSERT INTO medicament (cod_medicament, denumire, cantitate_stoc, doza_recomandata, unitate_de_masura) VALUES (502, 'Ibuprofen', 300, 1.50, 'mg');
INSERT INTO medicament (cod_medicament, denumire, cantitate_stoc, doza_recomandata, unitate_de_masura) VALUES (503, 'Amoxicilina', 200, 3.00, 'capsule');
INSERT INTO medicament (cod_medicament, denumire, cantitate_stoc, doza_recomandata, unitate_de_masura) VALUES (504, 'Vitamina C', 1000, 1.00, 'g');
INSERT INTO medicament (cod_medicament, denumire, cantitate_stoc, doza_recomandata, unitate_de_masura) VALUES (505, 'Omeprazol', 150, 0.50, 'capsule');

select * from medicament;

-- Inseram in tabelul 'necesita'
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (401, 501);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (401, 502);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (402, 503);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (402, 504);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (402, 505);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (403, 501);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (404, 502);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (404, 503);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (405, 504);
INSERT INTO necesita (cod_tratament, cod_medicament) VALUES (405, 505);

select * from necesita;

-- Inseram in tabelul 'boala'
INSERT INTO boala (cod_boala, denumire, tip_boala, nr_cazuri) VALUES (601, 'Gripa', 'Virala', 250);
INSERT INTO boala (cod_boala, denumire, tip_boala, nr_cazuri) VALUES (602, 'Pneumonie', 'Bacteriala', 180);
INSERT INTO boala (cod_boala, denumire, tip_boala, nr_cazuri) VALUES (603, 'Diabet', 'Cronica', 300);
INSERT INTO boala (cod_boala, denumire, tip_boala, nr_cazuri) VALUES (604, 'Cancer pulmonar', 'Neoplazica', 120);
INSERT INTO boala (cod_boala, denumire, tip_boala, nr_cazuri) VALUES (605, 'Hipertensiune arteriala', 'Cardiovasculara', 400);

select * from boala;

-- Inseram in tabelul 'primeste'
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (201, 401, 601, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (201, 402, 601, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (202, 403, 602, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (202, 404, 602, TO_DATE('2024-01-12', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (202, 405, 602, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (203, 401, 603, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (204, 402, 604, TO_DATE('2024-01-22', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (204, 403, 604, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (205, 404, 605, TO_DATE('2024-01-30', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (205, 405, 601, TO_DATE('2024-02-01', 'YYYY-MM-DD'));
INSERT INTO primeste (cod_pacient, cod_tratament, cod_boala, data) VALUES (205, 401, 603, TO_DATE('2024-02-05', 'YYYY-MM-DD'));

select * from primeste;
-- 6 
-- Sa se creeze un tabel pacient_istoric_boli in care sa se retina toate bolile unui paicent si data la care a fost
-- diagnosticat cu aceasta (10 cele mai recente pentru fiecare boala). 
-- Sa se creeze o procedura care primeste numele unui pacient si le update-aza istoricul

CREATE OR REPLACE TYPE istoric_boala IS OBJECT (d DATE, denumire VARCHAR2(50));
/

CREATE OR REPLACE TYPE istoric_boli IS TABLE OF istoric_boala;
/

CREATE TABLE pacient_istoric_boli AS
SELECT cod_pacient FROM pacient;

ALTER TABLE pacient_istoric_boli
ADD (istoric istoric_boli) NESTED TABLE istoric STORE AS boli_tab;

CREATE OR REPLACE PROCEDURE update_istoric (cod pacient.cod_pacient%TYPE) IS
    TYPE tab_imb IS TABLE OF boala.cod_boala%TYPE;
    TYPE tab_ind IS TABLE OF boala.denumire%TYPE INDEX BY PLS_INTEGER;
    TYPE vec IS VARRAY(10) OF primeste.data%TYPE;
    boli tab_imb := tab_imb();
    boala_denumire tab_ind;
    date_boli vec := vec();
    denumire boala.denumire%TYPE;
    cheie boala.cod_boala%TYPE;
    istoric_nou istoric_boli := istoric_boli();
BEGIN
    -- colectez codurile bolilor pacientului
    SELECT cod_boala
    BULK COLLECT INTO boli
    FROM primeste 
    WHERE cod_pacient = cod;
    
    -- salvez in 'boala_denumire' perechi de forma -> cod_boala : denumire
    FOR i IN boli.FIRST..boli.LAST LOOP
        SELECT denumire
        INTO denumire
        FROM boala
        WHERE cod_boala = boli(i);
        
        boala_denumire(boli(i)) := denumire;
    END LOOP;
    
    -- iterez prin toate cheile tabelului 'boala_denumire'
    cheie := boala_denumire.FIRST;
    
    WHILE cheie IS NOT NULL LOOP
        -- salvez in vectorul 'date' ultimelele 10 date pentru pacientul si boala respectiva
        SELECT *
        BULK COLLECT INTO date_boli
        FROM (
            SELECT data
            FROM primeste
            WHERE cod_pacient = cod
            AND cod_boala = cheie
            ORDER BY data DESC
        )
        WHERE ROWNUM <= 10;

        -- adaug intrarile gasite in noul istoric
        FOR i IN date_boli.FIRST..date_boli.LAST LOOP
            istoric_nou.EXTEND;
            istoric_nou(istoric_nou.LAST) := istoric_boala(date_boli(i), boala_denumire(cheie));
        END LOOP;
        cheie := boala_denumire.NEXT(cheie);
    END LOOP;
    
    -- update pe coloana
    UPDATE pacient_istoric_boli
    SET istoric = istoric_nou
    WHERE cod_pacient = cod;
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(20001, 'Nu exista angajatul cu codul ' || cod);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(20000, 'Nu s-a putut updata istoricul pacientului ' || cod);
END;
/

-- testam

EXECUTE update_istoric(201);
EXECUTE update_istoric(202);
EXECUTE update_istoric(205);

select * from pacient_istoric_boli;

SELECT p.cod_pacient, t.*
FROM pacient_istoric_boli p, TABLE (p.istoric) t;

-- 7
-- 
-- Sa se creeze o procedura care sa afiseze toate asistentele care lucreaza in cel putin o camera cu mai mult 
-- de x paturi si cel putin y ore pe saptamana. Sa se afiseze pentru fiecare asistenta 
/
CREATE OR REPLACE PROCEDURE afisare_asistente(nr_paturi NUMBER, ore_minime asistenta.ore_pe_sapt%TYPE) IS
    TYPE tab_imb IS TABLE OF asistenta.cod_angajat%TYPE;
    asistente_afisate tab_imb := tab_imb();
    ang asistenta.cod_angajat%TYPE;
    -- cursor cu parametru care intoarce asistentele care lucreaza intr-o anumita camera si au mai mult de y ore pe sapt
    CURSOR c_asistente(cod camera.cod_camera%TYPE) IS
        SELECT cod_angajat 
        FROM asistenta a JOIN lucreaza l USING(cod_angajat)
        WHERE a.ore_pe_sapt >= ore_minime
            AND l.cod_camera = cod;
BEGIN 
    -- cicilu cursor cu subcerere care intoarce camerele cu mai mult de x paturi
    FOR i IN (SELECT cod_camera
              FROM camera c JOIN pat p USING(cod_camera)
              GROUP BY cod_camera
              HAVING COUNT(*) > nr_paturi) 
    LOOP
        OPEN c_asistente(i.cod_camera);
        LOOP
            FETCH c_asistente INTO ang;
            EXIT WHEN c_asistente%NOTFOUND;
            -- verific daca am afisat deja asistenta
            IF ang MEMBER OF asistente_afisate THEN
                CONTINUE;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Asistenta: ' || ang || ', lucreaza in camera: ' || i.cod_camera);
            -- adaug asistenta in lista pentru a nu mai fi luata in considerare ulterior
            asistente_afisate.EXTEND;
            asistente_afisate(asistente_afisate.LAST) := ang;
        END LOOP;
        CLOSE c_asistente;  
    END LOOP;
END;
/

-- testez
select * from asistenta join angajat using (cod_angajat);
select * from pat;
select * from lucreaza;
EXECUTE afisare_asistente(2, 37);

-- 8
--
-- Sa se creeze o functie care returneaza numele doctorului care a consultat cei mai multi pacienti de sex masculin de la o
-- data primita ca parametru

select * from consulta;

CREATE OR REPLACE FUNCTION doctor_consultatii_max(data_inceput VARCHAR2) RETURN angajat.nume%TYPE IS
    nume angajat.nume%TYPE;
    data_validata consulta.data%TYPE;
BEGIN
    -- validez mai intai data
    BEGIN
        data_validata := TO_DATE(data_inceput, 'DD-MON-YY');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Data nu este valida');
    END;

    SELECT a.nume
    INTO nume
    FROM angajat a JOIN doctor d USING(cod_angajat)
        JOIN consulta c USING(cod_angajat) 
        JOIN pacient p USING(cod_pacient)
    WHERE c.data > TO_DATE(data_inceput, 'DD-MON-YY')
            AND p.sex = 'M'
    GROUP BY cod_angajat, nume
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM doctor d JOIN consulta c USING(cod_angajat)
            JOIN pacient p USING(cod_pacient)
        WHERE c.data > TO_DATE(data_inceput, 'DD-MON-YY')
            AND p.sex = 'M'
        GROUP BY cod_angajat);
    RETURN nume;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Sunt mai multi doctori cu numarul maxim de consultatii');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu exista consultatii atat de recente');
    WHEN OTHERS THEN
         IF SQLCODE = -20002 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Data nu este valida');
        ELSE
            RAISE_APPLICATION_ERROR(-20003, 'Nu stiu ce s-a intamplat ' || SQLERRM);
        END IF;
END doctor_consultatii_max;
/

-- testez
select * from consulta;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Doctorul este '|| doctor_consultatii_max('nu o data'));
END;
/
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Doctorul este '|| doctor_consultatii_max('01-JAN-24'));
END;
/
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Doctorul este '|| doctor_consultatii_max('01-JAN-25'));
END;
/
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Doctorul este '|| doctor_consultatii_max('09-JAN-24'));
END;
/

-- 9
--
-- Sa se creeze o procedura care primeste ca parametri numele unui doctor si un string x (care reprezinta un numar)
-- si intoarce prin al doilea parametru x cele mai folosite medicamente in tratamentele prescrise de acesta

CREATE OR REPLACE PROCEDURE medicamente_folosite(nume_doctor angajat.nume%TYPE, nr_medicamente IN OUT VARCHAR2) IS
    v_nr NUMBER;
    v_ang angajat.nume%TYPE;
    NU_DOCTOR EXCEPTION;
    PREA_PUTINE_MEDICAMENTE EXCEPTION;
    TYPE refc IS REF CURSOR;
    c_medicamente refc;
    denumire_med medicament.denumire%TYPE;
    rez VARCHAR2(100) := '';
BEGIN 
    -- verific ca parametrul al doilea e numar
    v_nr := TO_NUMBER(nr_medicamente);
    -- verific ca primul parametru e numele unui angajat
    SELECT nume
    INTO v_ang
    FROM angajat
    WHERE nume = nume_doctor;
    -- verific ca primul parametru e numele unui doctor
    SELECT COUNT(*)
    INTO v_nr
    FROM angajat a JOIN doctor d USING(cod_angajat)
    WHERE a.nume = nume_doctor;
                    
    IF v_nr = 0 THEN
        RAISE NU_DOCTOR;
    ELSIF v_nr > 1 THEN
        RAISE TOO_MANY_ROWS;
    END IF;
    
    -- verific ca sunt destule medicamente diferite folosite de acel doctor
    SELECT COUNT(COUNT(*))
    INTO v_nr
    FROM angajat a JOIN doctor d USING(cod_angajat)
        JOIN tratament t USING(cod_angajat)
        JOIN necesita n USING(cod_tratament)
        JOIN medicament m USING(cod_medicament)
    WHERE a.nume = nume_doctor
    GROUP BY cod_medicament;
                    
    IF v_nr < TO_NUMBER(nr_medicamente) THEN
        RAISE PREA_PUTINE_MEDICAMENTE;
    END IF;
    
    v_nr := TO_NUMBER(nr_medicamente);
    v_ang := nume_doctor;
    -- cursor dinamic care returneaza denimrea si numarul celor mai folosite x medicamente
    OPEN c_medicamente FOR 
        'SELECT denumire, COUNT(*) "numar"
         FROM angajat a JOIN doctor d USING(cod_angajat)
         JOIN tratament t USING(cod_angajat)
         JOIN necesita n USING(cod_tratament)
         JOIN medicament m USING(cod_medicament)
         WHERE nume = :v_ang AND 
            cod_medicament IN (
            SELECT cod_medicament
            FROM (
                SELECT cod_medicament
                FROM angajat a JOIN doctor d USING(cod_angajat)
                JOIN tratament t USING(cod_angajat)
                JOIN necesita n USING(cod_tratament)
                JOIN medicament m USING(cod_medicament)
                WHERE nume = :v_ang
                GROUP BY cod_medicament
                ORDER BY COUNT(*) DESC)
            WHERE ROWNUM < :v_nr)
         GROUP BY denumire
        ' 
    USING v_ang, v_ang, v_nr;
    LOOP 
        FETCH c_medicamente INTO denumire_med, v_nr;
        EXIT WHEN c_medicamente%NOTFOUND;
        rez := rez || ' ' || denumire_med || ':' || TO_CHAR(v_nr);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(rez);
    nr_medicamente := rez;
    CLOSE c_medicamente;
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Parametrul nu este un numar valid');
        nr_medicamente := '-1';
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Numele dat nu este al unui angajat');
        nr_medicamente := '-1';
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Mai multi doctori cu acest nume');
        nr_medicamente := '-1';
    WHEN NU_DOCTOR THEN
        DBMS_OUTPUT.PUT_LINE('Numele dat nu este al unui doctor');
        nr_medicamente := '-1';
    WHEN PREA_PUTINE_MEDICAMENTE THEN
        DBMS_OUTPUT.PUT_LINE('Nu sunt destule medicamente diferite folosite de doctor');
        nr_medicamente := '-1';
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Alta eroare: ' || SQLERRM);
END;
/

-- testez
DECLARE
    nr_medicamente VARCHAR2(20) := 'nu numar';
BEGIN
    medicamente_folosite('Dan Gheorghe', nr_medicamente);
    DBMS_OUTPUT.PUT_LINE(nr_medicamente);
END;
/
DECLARE
    nr_medicamente VARCHAR2(20) := '3';
BEGIN
    medicamente_folosite('Gigel', nr_medicamente);
    DBMS_OUTPUT.PUT_LINE(nr_medicamente);
END;
/
DECLARE
    nr_medicamente VARCHAR2(20) := '3';
BEGIN
    medicamente_folosite('Maria Popescu', nr_medicamente);
    DBMS_OUTPUT.PUT_LINE(nr_medicamente);
END;
/
DECLARE
    nr_medicamente VARCHAR2(20) := '11';
BEGIN
    medicamente_folosite('Radu Iliescu', nr_medicamente);
    DBMS_OUTPUT.PUT_LINE(nr_medicamente);
END;
/
DECLARE
    nr_medicamente VARCHAR2(50) := '3';
BEGIN
    medicamente_folosite('Radu Iliescu', nr_medicamente);
    DBMS_OUTPUT.PUT_LINE(nr_medicamente);
END;
/
-- pentru teste am mai inserat:
INSERT INTO tratament VALUES(406, 202, 10, 300);
INSERT INTO necesita VALUES(406, 503);
INSERT INTO necesita VALUES(406, 504);

-- testare cerere sql
SELECT denumire, COUNT(*)
         FROM angajat a JOIN doctor d USING(cod_angajat)
         JOIN tratament t USING(cod_angajat)
         JOIN necesita n USING(cod_tratament)
         JOIN medicament m USING(cod_medicament)
         WHERE nume = 'Radu Iliescu' AND 
            cod_medicament IN (
            SELECT cod_medicament
            FROM (
                SELECT cod_medicament
                FROM angajat a JOIN doctor d USING(cod_angajat)
                JOIN tratament t USING(cod_angajat)
                JOIN necesita n USING(cod_tratament)
                JOIN medicament m USING(cod_medicament)
                WHERE nume = 'Radu Iliescu'
                GROUP BY cod_medicament
                ORDER BY COUNT(*) DESC)
            WHERE ROWNUM < 3)
         GROUP BY denumire;
         
SELECT *
FROM angajat a JOIN doctor d USING(cod_angajat)
    JOIN tratament t USING(cod_angajat)
    JOIN necesita n USING(cod_tratament)
    JOIN medicament m USING(cod_medicament)
WHERE nume = 'Radu Iliescu';
select * from angajat;
select * from necesita;
select * from tratament;
select * from medicament;


-- 10
--
-- Pentru orice schimbari in tabelul 'primeste', sa se actualizeze in tabelul 'boala' numarul de cazuri

CREATE OR REPLACE TRIGGER actualizare_boli
    AFTER UPDATE OR DELETE OR INSERT ON primeste
DECLARE 
    v_nr NUMBER;
BEGIN
    FOR i IN (SELECT cod_boala FROM boala) LOOP
        SELECT COUNT(*)
        INTO v_nr
        FROM primeste
        WHERE cod_boala = i.cod_boala;
        
        UPDATE boala
        SET nr_cazuri = v_nr
        WHERE cod_boala = i.cod_boala;
    END LOOP;
END;
/

-- testez
select * from boala;
select * from primeste;
UPDATE primeste
SET cod_boala = 601
WHERE cod_pacient = 201 AND cod_tratament = 401 AND cod_boala = 602;

INSERT INTO primeste(cod_pacient, cod_tratament, cod_boala) VALUES (201, 402, 605);

DELETE FROM primeste WHERE cod_pacient = 201 AND cod_tratament = 402 AND cod_boala = 605;

-- 11
--
-- Sa se creeze un trigger care sa introduca automat o intrare in tabelul 'angajat' atunci cand o noua asistenta este introudsa
-- in baza de date. Noua asistenta va avea salariul mediu al tuturor asistentelor.

CREATE OR REPLACE PACKAGE salariu_mediu AS
    salariu_mediu NUMBER;
END;
/

CREATE OR REPLACE TRIGGER calcul_salariu 
    BEFORE INSERT ON asistenta
BEGIN
    SELECT AVG(salariu)
    INTO salariu_mediu.salariu_mediu
    FROM angajat JOIN asistenta USING(cod_angajat);
END;
/

CREATE OR REPLACE TRIGGER adaug_asistenta
    BEFORE INSERT ON asistenta
    FOR EACH ROW    
DECLARE
    v_avg NUMBER;
    v_nr NUMBER;
    nume_salvat angajat.nume%TYPE := '&p_nume';
BEGIN
    -- verific ca nu exista deja angajatul
    SELECT COUNT(*)
    INTO v_nr
    FROM angajat
    WHERE cod_angajat = :NEW.cod_angajat;
    
    IF v_nr = 1 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Angajatul cu codul ' || :NEW.cod_angajat || ' exista deja');
    END IF;

    INSERT INTO angajat VALUES (:NEW.cod_angajat, nume_salvat, salariu_mediu.salariu_mediu);
END;
/

-- testez
select * from asistenta;
select * from angajat;
-- merge daca inserez doar o linie
INSERT INTO asistenta VALUES (106, 38);
-- mutating table daca folosesc un select (posibil inserez mai multe linii)
INSERT INTO asistenta SELECT 107, 38 FROM DUAL;

DELETE FROM angajat WHERE cod_angajat = 106;
-- 12 
--
-- Sa se creeze backup-uri automate pentru tabelele medicament, boala si pacient in cazul in care sunt sterse

CREATE OR REPLACE TRIGGER backup_tabele
    BEFORE DROP ON SCHEMA
DECLARE 
    nume VARCHAR2(100);
BEGIN
    IF SYS.DICTIONARY_OBJ_TYPE = 'TABLE'
        AND LOWER(SYS.DICTIONARY_OBJ_NAME) IN ('medicament', 'boala', 'pacient', 'test_trig_delete') THEN
        DBMS_OUTPUT.PUT_LINE('Se creeaza backup pentru: ' || SYS.DICTIONARY_OBJ_NAME);
        nume := SYS.DICTIONARY_OBJ_NAME || '_backup_' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');
        EXECUTE IMMEDIATE 'CREATE TABLE ' || nume || ' AS SELECT * FROM ' || SYS.DICTIONARY_OBJ_NAME;
    END IF;
END;
/

-- testez
CREATE TABLE test_trig_delete AS SELECT cod_angajat FROM angajat;

DROP TABLE test_trig_delete;

CREATE OR REPLACE PROCEDURE testare_ex12 IS
    v_nr NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nr
    FROM USER_TABLES
    WHERE TABLE_NAME = 'TEST_TRIG_DELETE';

    IF v_nr = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE test_trig_delete AS SELECT cod_angajat FROM angajat';
    END IF;

    EXECUTE IMMEDIATE 'DROP TABLE test_trig_delete';
END;
/

EXECUTE testare_ex12();

DELETE FROM boala;
DROP TABLE boala CASCADE CONSTRAINTS;

-- 13
-- Sa se creeze un pachet cu 3 proceduri: actualizare a valabilitatii tuturor paturilor 
-- (stocata ca tabel imbricat in pachet), afisare paturi disponibile, eliberare pat.
-- In plus, 2 functii: verificare daca o camera este plina (returneaza boolean), 
-- alocare pat pentru un pacient nou internat, intr-o anumita camera (returneaza numarul patului in care va fi internat)

CREATE OR REPLACE PACKAGE alocare_paturi AS
    TYPE rec_pat IS RECORD (
        cod_pat pat.cod_pat%TYPE,
        valabil NUMBER(1)
    );

    TYPE tab_paturi IS TABLE OF rec_pat;
    paturi tab_paturi := tab_paturi();
    
    PROCEDURE ACTUALIZARE_PATURI_VALABILE;
    FUNCTION CAMERA_PLINA(cod camera.cod_camera%TYPE) RETURN BOOLEAN;
    PROCEDURE AFISARE_PATURI_VALABILE;
    FUNCTION ALOCARE_PAT(
        p_cod_pacient NUMBER,
        p_cod_camera NUMBER,
        p_data_internare DATE
    ) RETURN pat.cod_pat%TYPE;
    PROCEDURE ELIBERARE_PAT(
        p_cod_pat NUMBER
    );
END alocare_paturi;
/

CREATE OR REPLACE PACKAGE BODY alocare_paturi AS
    PROCEDURE ACTUALIZARE_PATURI_VALABILE IS
    BEGIN
        -- initial setez pentru fiecare pat ca e ocupat (valoare '0')
        SELECT cod_pat, 0
        BULK COLLECT INTO paturi
        FROM pat;
        -- trec prin fiecare pat si verific daca e cineva internat in el
        FOR i IN paturi.FIRST..paturi.LAST LOOP
            SELECT CASE 
                        WHEN NOT EXISTS (SELECT 1
                                         FROM ocupa
                                         WHERE cod_pat = paturi(i).cod_pat
                                           AND data_plecare IS NULL) 
                        THEN 1
                        ELSE 0
                   END 
            INTO paturi(i).valabil
            FROM dual;
        END LOOP;
    END ACTUALIZARE_PATURI_VALABILE;
    
    PROCEDURE AFISARE_PATURI_VALABILE IS
    BEGIN
        FOR i IN paturi.FIRST..paturi.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(paturi(i).cod_pat || ':' || TO_CHAR(paturi(i).valabil));
        END LOOP;
    END AFISARE_PATURI_VALABILE;
    
    FUNCTION CAMERA_PLINA(cod camera.cod_camera%TYPE) RETURN BOOLEAN IS
        paturi_totale NUMBER;
        paturi_ocupate NUMBER;
    BEGIN 
        -- numar paturi totale din camera
        SELECT COUNT(*) INTO paturi_totale FROM pat WHERE cod_camera = cod;
        -- numar paturi ocupate din camera
        SELECT COUNT(*) INTO paturi_ocupate 
        FROM ocupa 
        WHERE cod_camera = cod AND data_plecare IS NULL;

        RETURN paturi_totale = paturi_ocupate;
    END CAMERA_PLINA;
    
    
    FUNCTION ALOCARE_PAT(p_cod_pacient IN NUMBER, p_cod_camera IN NUMBER, p_data_internare IN DATE) RETURN pat.cod_pat%TYPE IS
        v_pat pat.cod_pat%TYPE := 1;
        internat NUMBER;
    BEGIN
        ACTUALIZARE_PATURI_VALABILE;
        -- verific daca pacientul nu e deja internat
        SELECT COUNT(*)
        INTO internat
        FROM ocupa 
        WHERE cod_pacient = p_cod_pacient AND data_plecare IS NULL;
        
        IF internat > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Pacientul este deja internat');
        END IF;
        -- verifica ca camera in care vrea sa fie internat nu e plina
        IF CAMERA_PLINA(p_cod_camera) THEN
            RAISE_APPLICATION_ERROR(-20000, 'Camera e plina, pacientul nu poate fi internat');
        END IF;
        -- gasesc primul pat neocupat din acea camera
        SELECT cod_pat
        INTO v_pat
        FROM TABLE (paturi)
        WHERE ROWNUM <= 1 AND valabil = 1 AND cod_pat IN (
                                SELECT cod_pat 
                                FROM camera c JOIN pat p USING(cod_camera)
                                WHERE cod_camera = p_cod_camera
                                );
        
        DBMS_OUTPUT.PUT_LINE(v_pat);
        
        INSERT INTO ocupa (cod_pacient, cod_camera, cod_pat, data_internare, data_plecare)
        VALUES (p_cod_pacient, p_cod_camera, v_pat, p_data_internare, NULL);
        
        ACTUALIZARE_PATURI_VALABILE;
        RETURN v_pat;
    END ALOCARE_PAT;
    
    
    PROCEDURE ELIBERARE_PAT(p_cod_pat NUMBER) IS
        v_nr NUMBER(1);
    BEGIN
        ACTUALIZARE_PATURI_VALABILE;
        -- verific daca patul e ocupat
        SELECT valabil
        INTO v_nr
        FROM TABLE (paturi)
        WHERE cod_pat = p_cod_pat;
        
        IF v_nr = 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Patul nu este ocupat');
        END IF;
        
        UPDATE ocupa
        SET data_plecare = SYSDATE
        WHERE cod_pat = p_cod_pat AND data_plecare IS NULL;
        
        ACTUALIZARE_PATURI_VALABILE;
        
        END ELIBERARE_PAT;
END alocare_paturi;
/

-- testez

-- ocup camera 5 (are un singur pat)
INSERT INTO ocupa VALUES (201, 112, 5, SYSDATE, NULL);
EXECUTE alocare_paturi.ACTUALIZARE_PATURI_VALABILE;
EXECUTE alocare_paturi.AFISARE_PATURI_VALABILE;
DECLARE
    x BOOLEAN;
BEGIN 
    x := alocare_paturi.CAMERA_PLINA(1);
    IF x THEN
        DBMS_OUTPUT.PUT_LINE('Camera plina');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Camera nu e plina');
    END IF;
END;
/
DECLARE
    x BOOLEAN;
BEGIN 
    x := alocare_paturi.CAMERA_PLINA(5);
    IF x THEN
        DBMS_OUTPUT.PUT_LINE('Camera plina');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Camera nu e plina');
    END IF;
END;
/

select * from ocupa;
select * from pat;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Camera gasita: ' || TO_CHAR(alocare_paturi.ALOCARE_PAT(205, 2, SYSDATE)));
END;
/
EXECUTE alocare_paturi.AFISARE_PATURI_VALABILE;
EXECUTE alocare_paturi.ELIBERARE_PAT(103);
