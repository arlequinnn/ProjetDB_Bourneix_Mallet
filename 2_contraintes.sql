/* Contraintes de validation pour Ligne */
ALTER TABLE Ligne ADD CONSTRAINT ck_ligne_nom CHECK (ligne_nom IN ('A', 'B', 'C', 'D', 'E', 'H', 'J', 'K', 'L', 'N', 'P', 'R', 'U', 'V'));
ALTER TABLE Ligne ADD CONSTRAINT ck_ligne_type CHECK (ligne_type IN ('RER', 'Transilien'));
ALTER TABLE Ligne ADD CONSTRAINT ck_ligne_couleur_hex CHECK (ligne_couleur_hex LIKE '#______');

/* Contraintes de validation pour Serie */
ALTER TABLE Serie ADD CONSTRAINT ck_serie_id CHECK (serie_id LIKE 'Z%' OR serie_id LIKE 'X%' OR serie_id LIKE 'B%' OR serie_id LIKE 'CC%');
ALTER TABLE Serie ADD CONSTRAINT ck_serie_effectifs CHECK (serie_effectifs > 0);
ALTER TABLE Serie ADD CONSTRAINT ck_serie_motorisation CHECK (serie_motorisation IN ('Automotrice', 'Autorail', 'Bimode', 'Locomotive'));
ALTER TABLE Serie ADD CONSTRAINT ck_serie_energie CHECK (serie_energie IN ('Electrique', 'Gazole', 'Hybride'));
ALTER TABLE Serie ADD CONSTRAINT ck_serie_puissance CHECK (serie_puissance > 0);
ALTER TABLE Serie ADD CONSTRAINT ck_serie_vitesse_max CHECK (serie_vitesse_max > 0);
ALTER TABLE Serie ADD CONSTRAINT ck_serie_largeur CHECK (serie_largeur > 0);

/* Contraintes de validation pour Depot */
ALTER TABLE Depot ADD CONSTRAINT uq_depot_nom UNIQUE (depot_nom);
ALTER TABLE Depot ADD CONSTRAINT ck_depot_capacite_voies CHECK (depot_capacite_voies > 0);

/* Contraintes de validation pour Exploitant */
ALTER TABLE Exploitant ADD CONSTRAINT uq_exploitant_nom UNIQUE (exp_nom);

/* Contraintes de validation pour Constructeur */
ALTER TABLE Constructeur ADD CONSTRAINT uq_constructeur_nom UNIQUE (constr_nom);

/* Contraintes de validation pour Stf */
ALTER TABLE Stf ADD CONSTRAINT uq_stf_nom UNIQUE (stf_nom);

/* Contraintes de validation pour Rame */
ALTER TABLE Rame ADD CONSTRAINT ck_rame_matricule_motrice CHECK (rame_matricule_motrice LIKE 'Z%' OR rame_matricule_motrice LIKE 'X%' OR rame_matricule_motrice LIKE 'B%' OR rame_matricule_motrice LIKE 'CC%');
ALTER TABLE Rame ADD CONSTRAINT ck_rame_longueur CHECK (rame_longueur > 0);
ALTER TABLE Rame ADD CONSTRAINT ck_rame_masse_a_vide CHECK (rame_masse_a_vide > 0);
ALTER TABLE Rame ADD CONSTRAINT ck_rame_capacite CHECK (rame_capacite > 0);
ALTER TABLE Rame ADD CONSTRAINT ck_rame_etat CHECK (rame_etat IN ('Actif', 'Maintenance', 'Radié'));
