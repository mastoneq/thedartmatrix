-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-05-10 07:01:11.834

-- tables
-- Table: encounter
CREATE TABLE encounter (
    csn int NOT NULL,
    date date NOT NULL,
    cc varchar(200) NOT NULL,
    diagnosis varchar(300) NOT NULL,
    edlos int NOT NULL,
    admit int NOT NULL,
    admitlos int NOT NULL,
    inj_mech int NOT NULL,
    patients_mrn int NOT NULL,
    sw int NOT NULL,
    dart int NOT NULL,
    dcf int NOT NULL,
    CONSTRAINT encounter_pk PRIMARY KEY (csn)
);

-- Table: encounter_dart_consults
CREATE TABLE encounter_dart_consults (
    id int NOT NULL,
    encounter_csn int NOT NULL,
    md varchar(100) NOT NULL,
    determination int NOT NULL,
    CONSTRAINT encounter_dart_consults_pk PRIMARY KEY (id)
);

-- Table: encounter_dcf
CREATE TABLE encounter_dcf (
    id int NOT NULL,
    text int NOT NULL,
    encounter_csn int NOT NULL,
    CONSTRAINT encounter_dcf_pk PRIMARY KEY (id)
);

-- Table: encounter_inj
CREATE TABLE encounter_inj (
    id int NOT NULL,
    encounter_csn int NOT NULL,
    injuries_id int NOT NULL,
    CONSTRAINT encounter_inj_pk PRIMARY KEY (id)
);

-- Table: imaging
CREATE TABLE imaging (
    orderid int NOT NULL,
    name varchar(300) NOT NULL,
    location varchar(300) NOT NULL,
    reading text NOT NULL,
    encounter_csn int NOT NULL,
    CONSTRAINT imaging_pk PRIMARY KEY (orderid)
);

-- Table: injuries
CREATE TABLE injuries (
    id int NOT NULL,
    name int NOT NULL,
    description int NOT NULL,
    CONSTRAINT injuries_pk PRIMARY KEY (id)
);

-- Table: labs
CREATE TABLE labs (
    labid int NOT NULL,
    name varchar(300) NOT NULL,
    result varchar(300) NOT NULL,
    ref_range varchar(300) NOT NULL,
    encounter_csn int NOT NULL,
    CONSTRAINT labs_pk PRIMARY KEY (labid)
);

-- Table: notes
CREATE TABLE notes (
    noteid int NOT NULL,
    author varchar(200) NOT NULL,
    type varchar(100) NOT NULL,
    date_start timestamp NOT NULL,
    date_sign timestamp NOT NULL,
    text text NOT NULL,
    encounter_csn int NOT NULL,
    CONSTRAINT notes_pk PRIMARY KEY (noteid)
);

-- Table: patients
CREATE TABLE patients (
    mrn int NOT NULL,
    name varchar(200) NOT NULL,
    race int NOT NULL,
    dob date NOT NULL,
    hispanic int NOT NULL,
    sex int NOT NULL,
    CONSTRAINT patients_pk PRIMARY KEY (mrn)
);

-- foreign keys
-- Reference: encounter_consults_encounter (table: encounter_dart_consults)
ALTER TABLE encounter_dart_consults ADD CONSTRAINT encounter_consults_encounter FOREIGN KEY encounter_consults_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- Reference: encounter_dcf_encounter (table: encounter_dcf)
ALTER TABLE encounter_dcf ADD CONSTRAINT encounter_dcf_encounter FOREIGN KEY encounter_dcf_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- Reference: encounter_inj_encounter (table: encounter_inj)
ALTER TABLE encounter_inj ADD CONSTRAINT encounter_inj_encounter FOREIGN KEY encounter_inj_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- Reference: encounter_inj_injuries (table: encounter_inj)
ALTER TABLE encounter_inj ADD CONSTRAINT encounter_inj_injuries FOREIGN KEY encounter_inj_injuries (injuries_id)
    REFERENCES injuries (id);

-- Reference: encounter_patients (table: encounter)
ALTER TABLE encounter ADD CONSTRAINT encounter_patients FOREIGN KEY encounter_patients (patients_mrn)
    REFERENCES patients (mrn);

-- Reference: imaging_encounter (table: imaging)
ALTER TABLE imaging ADD CONSTRAINT imaging_encounter FOREIGN KEY imaging_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- Reference: labs_encounter (table: labs)
ALTER TABLE labs ADD CONSTRAINT labs_encounter FOREIGN KEY labs_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- Reference: notes_encounter (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_encounter FOREIGN KEY notes_encounter (encounter_csn)
    REFERENCES encounter (csn);

-- End of file.

