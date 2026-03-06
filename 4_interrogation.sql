-- Afficher toutes les lignes avec le nombre de rames actives dans l'ordre alphabétique des lignes
SELECT L.ligne_nom, COUNT(R.rame_matricule_motrice) AS Nb_rames_actives
FROM Ligne L 
LEFT OUTER JOIN Rame R ON L.ligne_nom = R.ligne_nom AND R.rame_etat = 'Actif'
GROUP BY L.ligne_nom
ORDER BY L.ligne_nom ASC;

-- Afficher pour chaque ligne le nombre de rames fonctionnant à l'énergie électrique et le nombre de rames fonctionnant au gazole
SELECT L.ligne_nom, 
	-- La syntaxte pour compter selon une condition liée à l'attribut a été trouvée sur Internet.
	COUNT(CASE WHEN S.serie_energie = 'Electrique' THEN 1 END) AS Nb_energie_electrique, 
	COUNT(CASE WHEN S.serie_energie = 'Gazole' THEN 1 END) AS Nb_energie_gazole
FROM Ligne L 
LEFT OUTER JOIN Rame R ON L.ligne_nom = R.ligne_nom AND R.rame_etat <> 'Radié'
LEFT OUTER JOIN Serie S ON R.serie_id = S.serie_id
GROUP BY L.ligne_nom
ORDER BY L.ligne_nom ASC;

-- Afficher dans l'ordre décroissant le nombre de rames par réseau (RER ou Transilien)
SELECT L.ligne_type, COUNT(R.rame_matricule_motrice) AS Nb_rames
FROM Ligne L 
LEFT OUTER JOIN Rame R ON L.ligne_nom = R.ligne_nom AND R.Rame_etat <> 'Radié'
GROUP BY L.ligne_type
ORDER BY Nb_rames DESC;

-- Lister par exploitant les rames lui étant affectées
SELECT E.exp_nom, R.rame_matricule_motrice
FROM Rame R 
INNER JOIN Exploitant E ON E.exp_id = R.exp_id
ORDER BY E.exp_nom ASC, R.rame_matricule_motrice ASC;

-- Lister par constructeur les séries produites ainsi que leur nombre d'effectifs
SELECT C.constr_nom, S.serie_id, S.serie_effectifs
FROM Serie S 
LEFT OUTER JOIN Produire P ON S.serie_id = P.serie_id
LEFT OUTER JOIN Constructeur C ON P.constr_id = C.constr_id
ORDER BY C.constr_nom ASC, S.serie_effectifs DESC;

-- Accéder à la date de production et au nom de projet d'une série
SELECT S.serie_id, P.production_date, P.production_nom_projet
FROM Serie S 
LEFT OUTER JOIN Produire P ON S.serie_id = P.serie_id
WHERE S.serie_id = 'Z50000'; -- A remplacer par la série au besoin
    
-- Sommer la capacité de chaque rame assemblée à une rame choisie et renvoyer la capacité totale de l'unité
SELECT A.rame_matricule_motrice_1 AS Rame_1, A.rame_matricule_motrice_2 AS Rame_2, (R1.rame_capacite + R2.rame_capacite) AS capacite_totale
FROM Assembler A
JOIN Rame R1 ON A.rame_matricule_motrice_1 = R1.rame_matricule_motrice
JOIN Rame R2 ON A.rame_matricule_motrice_2 = R2.rame_matricule_motrice
ORDER BY capacite_totale DESC;
    
-- Afficher les caractéristiques liées au confort pour une série selon sa date de production
SELECT S.serie_id, S.serie_acces_pmr, S.serie_acces_toilettes, S.serie_climatisation
FROM Serie S
WHERE EXISTS (
	SELECT 1
    FROM Produire P
    WHERE S.serie_id = P.serie_id
    AND P.production_date BETWEEN '1980-12-01' AND '2001-07-01'
);

-- Afficher toutes les séries qui ont le même nom de modèle
SELECT S.serie_id
FROM Serie S 
WHERE S.serie_nom_modele = 'Z 2N'; -- A remplacer par la série au besoin

-- Récupérer la couleur d'une ligne
SELECT L.ligne_couleur_hex
FROM Ligne L
WHERE L.ligne_nom = 'L'; -- A remplacer par le nom de la ligne au besoin

-- Lister toutes les séries ayant le même nom de plateforme
SELECT S.serie_id
FROM Serie S 
WHERE S.serie_id IN (
	SELECT P.serie_id
    FROM Produire P
    WHERE P.production_nom_plateforme = 'Spacium 3.06' -- A remplacer par le nom de plateforme au besoin
);

-- Calculer la longueur d'une unité multiple en sommant la longueur de toutes les rames assemblées
SELECT A.rame_matricule_motrice_1 AS Rame_1, A.rame_matricule_motrice_2 AS Rame_2, (R1.rame_longueur + R2.rame_longueur) AS longueur_totale
FROM Assembler A
JOIN Rame R1 ON A.rame_matricule_motrice_1 = R1.rame_matricule_motrice
JOIN Rame R2 ON A.rame_matricule_motrice_2 = R2.rame_matricule_motrice
ORDER BY longueur_totale DESC;

-- Lister tous les dépôts qui ne sont pas utilisés par une STF en particulier
SELECT D.depot_nom
FROM Depot D
WHERE D.depot_id NOT IN (
	SELECT U.depot_id
    FROM Utiliser U
    WHERE U.stf_code_interne = 'SLA' 
)
ORDER BY D.depot_ville ASC;

-- Lister toutes les séries dont la puissance est supérieure à la moyenne
SELECT S.serie_id, S.serie_puissance
FROM Serie S
WHERE S.serie_puissance > (
	SELECT AVG(S2.serie_puissance)
    FROM Serie S2
)
ORDER BY S.serie_puissance DESC, S.serie_id ASC;

-- Lister toutes les séries qui roulent le plus vite
SELECT S.serie_id
FROM Serie S
WHERE S.serie_vitesse_max >= ALL (
	SELECT S2.serie_vitesse_max
    FROM Serie S2
)
ORDER BY S.serie_id ASC;

-- Afficher le nombre de stations par type de réseau
SELECT L.ligne_type, SUM(L.ligne_nb_stations) AS nb_stations
FROM Ligne L
GROUP BY L.ligne_type
ORDER BY nb_stations DESC;

-- Afficher les lignes qui sont gérées par plus d'un exploitant
SELECT L.ligne_nom, COUNT(E.exp_id) AS nb_exploitants
FROM Ligne L 
NATURAL JOIN Gerer 
NATURAL JOIN Exploitant E
GROUP BY L.ligne_nom
HAVING COUNT(E.exp_id) > 1;

-- Afficher les dépôts qui sont utilisés par plus d'une STF
SELECT D.depot_nom, COUNT(S.stf_nom) AS nb_stf
FROM Depot D
NATURAL JOIN Utiliser 
NATURAL JOIN Stf S
GROUP BY D.depot_id
HAVING COUNT(S.stf_code_interne) > 1;

-- Afficher les trois modèles ayant la vitesse max la plus élevée, parmi les modèles dont cette vitesse ne dépasse pas les 180 km/h
SELECT S.serie_nom_modele
FROM Serie S
GROUP BY S.serie_nom_modele
HAVING MAX(S.serie_vitesse_max) < 180
ORDER BY MAX(S.serie_vitesse_max) DESC
LIMIT 3;

-- Lister les constructeurs récents avec leur première série
SELECT C.constr_nom, MIN(P.production_date) AS date_production
FROM Constructeur C
NATURAL JOIN Produire P
GROUP BY C.constr_nom
HAVING MIN(P.production_date) > '2000-01-01'
ORDER BY date_production ASC;



