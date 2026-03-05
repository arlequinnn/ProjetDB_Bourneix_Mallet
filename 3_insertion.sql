-- ==========================================================
-- 1. TABLES INDÉPENDANTES (Pas de clés étrangères)
-- ==========================================================

INSERT INTO LIGNE (ligne_nom, ligne_type, ligne_nb_stations, ligne_couleur_hex) VALUES
('A', 'RER', 46, '#c93839'),
('B', 'RER', 47, '#638bc3'),
('C', 'RER', 84, '#ecc947'),
('D', 'RER', 59, '#488a5f'),
('E', 'RER', 26, '#a7488a'),
('H', 'Transilien', 46, '#836034'),
('J', 'Transilien', 56, '#c7cd46'),
('K', 'Transilien', 10, '#9d983e'),
('L', 'Transilien', 36, '#be9acf'),
('N', 'Transilien', 35, '#67b697'),
('P', 'Transilien', 32, '#df854b'),
('R', 'Transilien', 25, '#e3a7ba'),
('U', 'Transilien', 11, '#9e2445'),
('V', 'Transilien', 7, '#9d9738');

INSERT INTO SERIE (serie_id, serie_nom_modele, serie_effectifs, serie_est_articulee, serie_motorisation, serie_energie, serie_puissance, serie_vitesse_max, serie_largeur, serie_acces_pmr, serie_acces_toilettes, serie_climatisation, serie_livree) VALUES
-- RER A
('Z1600', 'MI 09', 140, FALSE, 'Automotrice', 'Electrique', 3900, 120, 2.90, TRUE, FALSE, TRUE, 'IDFM-RATP'),
('Z22500', 'MI 2N Altéo', 43, FALSE, 'Automotrice', 'Electrique', 3200, 120, 2.90, FALSE, FALSE, FALSE, 'RATP'),
('Z8100', 'MI 79', 119, FALSE, 'Automotrice', 'Electrique', 2824, 140, 2.80, FALSE, FALSE, FALSE, 'RATP-SNCF'),
('Z8400', 'MI 84', 73, FALSE, 'Automotrice', 'Electrique', 2824, 140, 2.80, FALSE, FALSE, FALSE, 'IDFM-RATP'),
-- Famille Z 2N
('Z5600', 'Z 2N', 52, FALSE, 'Automotrice', 'Electrique', 2800, 140, 2.82, FALSE, FALSE, FALSE, 'Transilien'),
('Z8800', 'Z 2N', 58, FALSE, 'Automotrice', 'Electrique', 2800, 140, 2.82, FALSE, FALSE, FALSE, 'Transilien'),
('Z20500', 'Z 2N', 200, FALSE, 'Automotrice', 'Electrique', 2800, 140, 2.82, FALSE, FALSE, FALSE, 'IDFM'),
('Z20900', 'Z 2N', 54, FALSE, 'Automotrice', 'Electrique', 3464, 140, 2.82, FALSE, FALSE, TRUE, 'Carmillon'),
-- RER NG & Eole
('Z58500', 'RER NG', 10, FALSE, 'Automotrice', 'Electrique', 6000, 140, 2.99, TRUE, FALSE, TRUE, 'IDFM'),
('Z22500_E', 'MI 2N Eole', 53, FALSE, 'Automotrice', 'Electrique', 3200, 120, 2.90, FALSE, FALSE, FALSE, 'SNCF'), -- ID unique pour Eole
('Z58000', 'RER NG', 131, FALSE, 'Automotrice', 'Electrique', 6000, 140, 2.99, TRUE, FALSE, TRUE, 'IDFM'),
-- Matériel Transilien Moderne
('Z50000', 'Francilien', 360, FALSE, 'Automotrice', 'Electrique', 2620, 140, 3.06, TRUE, FALSE, TRUE, 'IDFM'),
('Z57000', 'Regio 2N', 145, FALSE, 'Automotrice', 'Electrique', 3200, 160, 2.99, TRUE, FALSE, TRUE, 'IDFM'),
-- Cas spécifiques (Loco & Bimode)
('BB27300', 'Prima', 67, TRUE, 'Locomotive', 'Electrique', 4200, 140, 3.06, FALSE, FALSE, FALSE, 'Transilien'),
('B82500', 'BGC', 28, FALSE, 'Bimode', 'Hybride', 1900, 160, 2.95, TRUE, TRUE, TRUE, 'Transilien');

INSERT INTO AUTORITE_ORGANISATRICE (ao_nom, ao_nom_commercial) VALUES
('Île-de-France', 'Île-de-France Mobilités');

INSERT INTO EXPLOITANT (exp_id, exp_nom) VALUES
(1, 'SNCF Voyageurs'),
(2, 'RATP');

INSERT INTO CONSTRUCTEUR (constr_id, constr_nom) VALUES
(1, 'Alstom'),
(2, 'Bombardier Transport'),
(3, 'CAF');

INSERT INTO DEPOT (depot_id, depot_nom, depot_ville, depot_capacite_voies) VALUES
-- RER A (RATP)
('SUC', 'Atelier de Sucy-en-Brie', 'Sucy-en-Brie', 45),
('RUE', 'Atelier de Rueil-Malmaison', 'Rueil-Malmaison', 30),
('NAN', 'Dépôt de Nanterre-Université', 'Nanterre', 50),
-- RER E / Ligne P (SNCF)
('NOI', 'Technicentre de Noisy-le-Sec', 'Noisy-le-Sec', 60),
('PAN', 'Atelier de Pantin', 'Pantin', 15),
-- Lignes L / J (SNCF)
('VAL', 'Technicentre de Levallois', 'Levallois-Perret', 35),
('MSL', 'Dépôt de Maisons-Laffitte', 'Maisons-Laffitte', 20),
-- Lignes N / U (SNCF)
('VGP', 'Dépôt de Vaugirard', 'Paris', 20),
('TRA', 'Technicentre de Trappes', 'Trappes', 40),
-- RER C / Ligne N (SNCF)
('VIT', 'Technicentre de Vitry-sur-Seine', 'Vitry-sur-Seine', 55),
-- RER D / Ligne R (SNCF)
('VIL', 'Technicentre de Villeneuve-Saint-Georges', 'Villeneuve-Saint-Georges', 80),
('JON', 'Dépôt de Joncherolles', 'Villetaneuse', 45);

-- ==========================================================
-- 2. TABLES AVEC CLÉS ÉTRANGÈRES SIMPLES
-- ==========================================================

INSERT INTO STF (stf_code_interne, stf_nom, exp_id) VALUES
-- Secteurs SNCF (exp_id = 1)
('SLA', 'STF Lignes L/J/N', 1),
('SRE', 'STF RER E/P/T4', 1),
('SLN', 'STF Ligne N & U', 1),
('SCD', 'STF RER C & D', 1),
('SHU', 'STF Lignes H & U', 1),
('SMR', 'STF Ligne R', 1),
-- Secteurs RATP (exp_id = 2)
('RAT', 'Maintenance RATP A', 2),
('RBT', 'Maintenance RATP B', 2);

-- ID 1: Alstom | ID 2: Bombardier | ID 3: CAF

INSERT INTO Produire (serie_id, constr_id, production_date, production_nom_plateforme, production_nom_projet) VALUES
-- MI 09 (Consortium Alstom-Bombardier)
('Z1600', 1, '2011-12-01', 'MI 09', 'MI 09'),
('Z1600', 2, '2011-12-01', 'MI 09', 'MI 09'),
-- MI 2N Altéo & Eole (Consortium Alstom-Bombardier)
('Z22500', 1, '1996-06-01', 'MI 2N', 'Altéo'),
('Z22500', 2, '1996-06-01', 'MI 2N', 'Altéo'),
('Z22500_E', 1, '1996-03-01', 'MI 2N', 'Eole'),
('Z22500_E', 2, '1996-03-01', 'MI 2N', 'Eole'),
-- MI 79 / MI 84 (Consortium Alstom-ANF/Bombardier)
('Z8100', 1, '1980-12-01', 'MI 79', 'MI 79'),
('Z8100', 2, '1980-12-01', 'MI 79', 'MI 79'),
('Z8400', 1, '1984-07-01', 'MI 84', 'MI 84'),
('Z8400', 2, '1984-07-01', 'MI 84', 'MI 84'),
-- Famille Z 2N (Principalement Alstom, mais avec participations ANF)
('Z5600', 1, '1982-09-01', 'Z 2N', 'Z 5600'),
('Z8800', 1, '1985-03-01', 'Z 2N', 'Z 8800'),
('Z20500', 1, '1988-11-01', 'Z 2N', 'Z 20500'),
('Z20500', 2, '1988-11-01', 'Z 2N', 'Z 20500'),
('Z20900', 1, '2001-07-01', 'Z 2N', 'Z 20900'),
-- RER NG (Consortium Alstom-Bombardier)
('Z58500', 1, '2023-11-01', 'X Trapolis Cityduplex', 'RER NG Court'),
('Z58500', 2, '2023-11-01', 'X Trapolis Cityduplex', 'RER NG Court'),
('Z58000', 1, '2023-11-01', 'X Trapolis Cityduplex', 'RER NG Long'),
('Z58000', 2, '2023-11-01', 'X Trapolis Cityduplex', 'RER NG Long'),
-- Francilien & BGC (Bombardier seul à l'époque)
('Z50000', 2, '2009-12-01', 'Spacium 3.06', 'NAT'),
('B82500', 2, '2004-06-01', 'AGC', 'BGC'),
-- Regio 2N & Prima (Alstom seul / Alstom-Bombardier pour Regio2N)
('Z57000', 1, '2014-03-01', 'Omneo', 'Regio 2N'),
('Z57000', 2, '2014-03-01', 'Omneo', 'Regio 2N'),
('BB27300', 1, '2006-03-01', 'Prima 4200', 'Prima');

INSERT INTO Gerer (ligne_nom, exp_id) VALUES
-- Réseau RER
('A', 2), -- RATP (majoritaire)
('A', 1), -- SNCF (branches Nanterre-P. / Cergy / Poissy)
('B', 2), -- RATP (Sud)
('B', 1), -- SNCF (Nord)
('C', 1), -- SNCF
('D', 1), -- SNCF
('E', 1), -- SNCF
-- Réseau Transilien
('H', 1), -- SNCF
('J', 1), -- SNCF
('K', 1), -- SNCF
('L', 1), -- SNCF
('N', 1), -- SNCF
('P', 1), -- SNCF
('R', 1), -- SNCF
('U', 1); -- SNCF

INSERT INTO Utiliser (stf_code_interne, depot_id) VALUES
-- STF Lignes L/J/N (SLA)
('SLA', 'VAL'), -- Technicentre de Levallois (Base principale L/J)
('SLA', 'MSL'), -- Maisons-Laffitte
('SLA', 'VGP'), -- Vaugirard (Remisage/Entretien ligne N)
-- STF RER E/P/T4 (SRE)
('SRE', 'NOI'), -- Noisy-le-Sec (Base principale E/P)
('SRE', 'PAN'), -- Pantin
-- STF Ligne N & U (SLN)
('SLN', 'TRA'), -- Trappes (Base principale N/U)
('SLN', 'VGP'), -- Partage du dépôt de Vaugirard avec SLA
('SLN', 'VIT'), -- Vitry (Support maintenance)
-- STF RER C & D (SCD)
('SCD', 'VIT'), -- Vitry (Base principale C)
('SCD', 'VIL'), -- Villeneuve-Saint-Georges (Base principale D)
('SCD', 'JON'), -- Joncherolles
-- Maintenance RATP A (RAT)
('RAT', 'NAN'), -- Nanterre (Base principale)
('RAT', 'RUE'), -- Rueil-Malmaison
('RAT', 'SUC'), -- Sucy-en-Brie (Maintenance lourde)
-- Maintenance RATP B (RBT)
('RBT', 'SUC'); -- Le dépôt de Sucy est assez grand pour dépanner le RER B si besoin

-- ==========================================================
-- 3. TABLES DE DONNÉES OPÉRATIONNELLES (RAME ET ASSEMBLAGES)
-- ==========================================================

INSERT INTO RAME (rame_matricule_motrice, rame_composition, rame_longueur, rame_masse_a_vide, rame_capacite, rame_etat, ligne_nom, ao_nom, exp_id, serie_id) VALUES
/* L'état de la rame est théorique, info introuvable. */
-- RER A (RATP) - MI 09 & MI 2N Altéo
('Z1601', '5 voitures', 112.00, 240000.00, 1305, 'Actif', 'A', 'Île-de-France', 2, 'Z1600'),
('Z1602', '5 voitures', 112.00, 240000.00, 1305, 'Maintenance', 'A', 'Île-de-France', 2, 'Z1600'),
('Z1510', '5 voitures', 112.00, 235000.00, 1300, 'Actif', 'A', 'Île-de-France', 2, 'Z22500'),
-- RER B - MI 79 / MI 84
('Z8105', '4 voitures', 104.00, 208000.00, 850, 'Actif', 'B', 'Île-de-France', 2, 'Z8100'),
('Z8412', '4 voitures', 104.00, 208000.00, 850, 'Actif', 'B', 'Île-de-France', 2, 'Z8400'),
-- RER C & D - Famille Z 2N
('Z5601', '4 voitures', 102.00, 230000.00, 950, 'Actif', 'C', 'Île-de-France', 1, 'Z5600'),
('Z20545', '5 voitures', 130.00, 280000.00, 1200, 'Maintenance', 'D', 'Île-de-France', 1, 'Z20500'),
('Z20546', '5 voitures', 130.00, 280000.00, 1200, 'Actif', 'D', 'Île-de-France', 1, 'Z20500'),
('Z20912', '4 voitures', 103.00, 235000.00, 900, 'Actif', 'C', 'Île-de-France', 1, 'Z20900'),
('Z58501', '6 voitures', 130.00, 295000.00, 1500, 'Actif', 'E', 'Île-de-France', 1, 'Z58500'),
-- RER E - RER NG & MI 2N Eole
('Z58001', '6 voitures', 130.00, 295000.00, 1500, 'Actif', 'E', 'Île-de-France', 1, 'Z58000'),
('Z22505', '5 voitures', 112.00, 235000.00, 1300, 'Actif', 'E', 'Île-de-France', 1, 'Z22500_E'),
-- Lignes L, N & P - Francilien, Regio 2N, BGC, Prima
('Z50001', '7 voitures', 94.31, 210000.00, 800, 'Actif', 'L', 'Île-de-France', 1, 'Z50000'),
('Z50002', '7 voitures', 94.31, 210000.00, 800, 'Actif', 'H', 'Île-de-France', 1, 'Z50000'),
('Z50003', '7 voitures', 94.31, 210000.00, 800, 'Actif', 'H', 'Île-de-France', 1, 'Z50000'),
('Z57020', '8 voitures', 110.00, 250000.00, 1100, 'Radié', 'N', 'Île-de-France', 1, 'Z57000'),
('Z57021', '8 voitures', 110.00, 250000.00, 1100, 'Actif', 'R', 'Île-de-France', 1, 'Z57000'),
('BB27301', 'Loco + 6 voitures VB2N', 160.00, 350000.00, 1200, 'Actif', 'N', 'Île-de-France', 1, 'BB27300'),
('B82501', '4 voitures', 81.20, 165000.00, 450, 'Actif', 'P', 'Île-de-France', 1, 'B82500'),
('B82502', '4 voitures', 81.20, 165000.00, 450, 'Actif', 'P', 'Île-de-France', 1, 'B82500'),
('B82503', '4 voitures', 81.20, 165000.00, 450, 'Actif', 'P', 'Île-de-France', 1, 'B82500'),
('Z58501', '6 voitures', 130.00, 295000.00, 1500, 'Radié', 'E', 'Île-de-France', 1, 'Z58500');

INSERT INTO Assembler (rame_matricule_motrice_1, rame_matricule_motrice_2) VALUES
('Z1601', 'Z1602'), -- UM2 MI 09 (RER A)
('Z8105', 'Z8412'), -- UM2 MI 79/84 (RER B)
('Z50001', 'Z50002'), ('Z50002', 'Z50003'), -- UM3 Francilien (Ligne H)
('Z58001', 'Z58501'), -- UM2 RER NG (RER E)
('Z20545', 'Z20546'), -- UM2 Z 2N (RER D)
('B82501', 'B82502'), ('B82502', 'B82503'), -- UM3 BGC (Ligne P)
('Z57020', 'Z57021'); -- UM2 Regio 2N (Ligne R)