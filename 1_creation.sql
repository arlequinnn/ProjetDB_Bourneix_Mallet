CREATE TABLE Ligne(
	ligne_nom VARCHAR(50),
    ligne_type VARCHAR(50) NOT NULL,
    ligne_nb_stations INT NOT NULL,
    ligne_couleur_hex VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_ligne PRIMARY KEY (ligne_nom)
);

CREATE TABLE Serie(
	serie_id VARCHAR(50),
    serie_nom_modele VARCHAR(50) NOT NULL,
    serie_effectifs INT NOT NULL,
    serie_est_articulee BOOL NOT NULL,
    serie_motorisation VARCHAR(50) NOT NULL,
    serie_energie VARCHAR(50) NOT NULL,
    serie_puissance INT NOT NULL,
    serie_vitesse_max INT NOT NULL,
    serie_largeur DECIMAL(15,2) NOT NULL,
    serie_acces_pmr BOOL NOT NULL,
    serie_acces_toilettes BOOL NOT NULL,
    serie_climatisation BOOL NOT NULL,
    serie_livree VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_serie PRIMARY KEY (serie_id)
);

CREATE TABLE Autorite_organisatrice(
	ao_nom VARCHAR(50),
    ao_nom_commercial VARCHAR(50),
    
    CONSTRAINT pk_autorite_organisatrice PRIMARY KEY (ao_nom)
);

CREATE TABLE Depot(
	depot_id VARCHAR(50),
    depot_nom VARCHAR(50) NOT NULL,
    depot_ville VARCHAR(50) NOT NULL,
    depot_capacite_voies INT,
    
    CONSTRAINT pk_depot PRIMARY KEY (depot_id)
);

CREATE TABLE Exploitant(
	exp_id INT,
    exp_nom VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_exploitant PRIMARY KEY (exp_id)
);

CREATE TABLE Constructeur(
	constr_id INT,
    constr_nom VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_constructeur PRIMARY KEY (constr_id)
);

CREATE TABLE Stf(
	stf_code_interne VARCHAR(50),
    stf_nom VARCHAR(50) NOT NULL,
    exp_id INT,
    
    CONSTRAINT pk_stf PRIMARY KEY (stf_code_interne),
    CONSTRAINT fk_stf_exploitant 
		FOREIGN KEY (exp_id) REFERENCES Exploitant(exp_id) 
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Rame(
	rame_matricule_motrice VARCHAR(50),
    rame_composition VARCHAR(50) NOT NULL,
    rame_longueur DOUBLE NOT NULL,
    rame_masse_a_vide DECIMAL(15,2) NOT NULL,
    rame_capacite INT NOT NULL,
    rame_etat VARCHAR(50),
    ligne_nom VARCHAR(50),
    ao_nom VARCHAR(50),
    exp_id INT, 
    serie_id VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_rame PRIMARY KEY (rame_matricule_motrice),
    CONSTRAINT fk_rame_ligne
		FOREIGN KEY (ligne_nom) REFERENCES Ligne(ligne_nom)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
	CONSTRAINT fk_rame_autorite_organisatrice
		FOREIGN KEY (ao_nom) REFERENCES Autorite_organisatrice(ao_nom)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
	CONSTRAINT fk_rame_exploitant
		FOREIGN KEY (exp_id) REFERENCES Exploitant(exp_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
	CONSTRAINT fk_rame_serie
		FOREIGN KEY (serie_id) REFERENCES Serie(serie_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Produire(
	serie_id VARCHAR(50) NOT NULL,
    constr_id INT NOT NULL,
    production_date DATE NOT NULL,
    production_nom_plateforme VARCHAR(50) NOT NULL,
    production_nom_projet VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_produire PRIMARY KEY (serie_id, constr_id),
    CONSTRAINT fk_produire_serie
		FOREIGN KEY (serie_id) REFERENCES Serie(serie_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_produire_constructeur
		FOREIGN KEY (constr_id) REFERENCES Constructeur(constr_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Utiliser(
	stf_code_interne VARCHAR(50) NOT NULL,
    depot_id VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_utiliser PRIMARY KEY (stf_code_interne, depot_id),
    CONSTRAINT fk_utiliser_stf
		FOREIGN KEY (stf_code_interne) REFERENCES Stf(stf_code_interne)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_utiliser_depot
		FOREIGN KEY (depot_id) REFERENCES Depot(depot_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Gerer(
	ligne_nom VARCHAR(50) NOT NULL,
    exp_id INT NOT NULL,
    
    CONSTRAINT pk_gerer PRIMARY KEY (ligne_nom, exp_id),
    CONSTRAINT fk_gerer_ligne
		FOREIGN KEY (ligne_nom) REFERENCES Ligne(ligne_nom)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_gerer_exploitant
		FOREIGN KEY (exp_id) REFERENCES Exploitant(exp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Assembler(
	rame_matricule_motrice_1 VARCHAR(50) NOT NULL,
    rame_matricule_motrice_2 VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_assembler PRIMARY KEY (rame_matricule_motrice_1, rame_matricule_motrice_2),
    CONSTRAINT fk_assembler_rame1
		FOREIGN KEY (rame_matricule_motrice_1) REFERENCES Rame(rame_matricule_motrice)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_assembler_rame2
		FOREIGN KEY (rame_matricule_motrice_2) REFERENCES Rame(rame_matricule_motrice)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




    



