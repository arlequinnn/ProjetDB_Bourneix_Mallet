# Mini-projet : Conception et développement d'une base de données


## Etape 1 : Analyser les besoins

Choix du domaine : Matériels roulants d'Île-de-France (Transiliens et RER)

### Prompt envoyé à l'IAG pour récupérer les besoins :

Tu travailles dans le domaine des transports ferroviaires en Ile-de-France.
Ton administration a comme activité de répertorier et organiser les matériels roulants (trains, RER, TER) circulant sur le réseau
ferré francilien. C’est une administration publique comme la RATP ou SNCF Voyageurs. Les données ont été collectées sur les lignes de
transport, les gares et points d’arrêt, les types de matériels roulants (trains, RER, TER) et leur fiche technique.
Inspire-toi du portail Open Data d’Ile-de-France Mobilités ou du site officiel Transilien, ainsi que des
sites suivants : https://explorehunza.fr/2025/09/16/materiel-roulant-transilien-2025/, https://fr.wikipedia.org/wiki/Liste_des_Regio_2N,
https://omnil.fr/materiel-roulant-ferroviaire-et-routier.
Ton administration veut appliquer MERISE pour concevoir un système d'informations. Tu es chargé de la partie analyse,
c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet,
tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la 
base de données. D’abord, établis les règles de gestion des données de ton administration, sous la forme d'une liste à puce. 
Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas
comment se construit un système d’informations.
Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : 
signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à
fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

### Réponse de l'IAG :

Voici les règles de gestion qui dictent notre quotidien, ainsi que le dictionnaire de données pour ton analyse.

#### 1. Règles de Gestion des Données

Ces règles définissent le fonctionnement métier de l'administration et les contraintes de gestion des actifs ferroviaires :

##### Réseau et Infrastructure
* **Lignes :** Chaque ligne de transport (ex: Ligne N, RER A) est identifiée par un code unique et possède un nom commercial ainsi qu'une couleur de représentation.
* **Exploitation :** Une ligne est exploitée par un seul opérateur (SNCF Voyageurs, RATP ou un opérateur privé via IDFM).
* **Points d'arrêt :** Une ligne dessert plusieurs gares ou points d'arrêt. Inversement, une gare peut être desservie par une ou plusieurs lignes (nœuds de correspondance).
* **Géolocalisation :** Chaque point d'arrêt est précisément localisé par des coordonnées GPS et rattaché à une commune et une zone tarifaire.

##### Matériel Roulant
* **Modèles (Séries) :** Le matériel est répertorié par modèles techniques (ex: Z 57000, Regio 2N, Francilien). 
* **Fiche Technique :** Chaque modèle possède des caractéristiques fixes : constructeur, vitesse maximale, capacité de voyageurs, motorisation et hauteur de plancher.
* **Unités (Rames) :** Une "rame" est une unité physique individuelle identifiée par un numéro d'exploitation unique. Chaque rame appartient obligatoirement à un modèle.
* **Affectation :** Une rame est affectée à un centre de maintenance spécifique (STF - Supervision Technique de Flotte).
* **Compatibilité :** Seuls certains modèles de matériels sont autorisés à circuler sur une ligne donnée (contraintes de gabarit et d'infrastructure).
* **Cycle de vie :** Nous suivons pour chaque rame sa date de mise en service, son kilométrage total et son état de disponibilité (en service, en maintenance, radiée).

---

#### 2. Dictionnaire des Données Brutes

| Signification de la donnée | Type | Taille |
| :--- | :--- | :--- |
| Code unique de la ligne (ex: C01234) | Alphanumérique | 6 |
| Autorité organisatrice de la ligne (ex: Région Ile-de-France) | Texte | 20 |
| Couleur hexadécimale de la ligne | Texte | 7 |
| Nom de l'exploitant (ex: SNCF) | Texte | 50 |
| Type de ligne (Train, RER, Tram-train) | Texte | 15 |
| Nombre de points d'arrêts / Gares | Décimal | 100 |
| Numéro d'exploitation de la rame | Alphanumérique | 15 |
| Nom de la série (modèle) | Texte | 50 |
| Tension d'alimentation principale | Texte | 15 |
| Nombre de caisses par rame | Numérique | 2 |
| Masse à vide (tonnes) | Numérique | 5 |
| Nom du dépôt de maintenance | Texte | 50 |
| Code du modèle de matériel (ex: Z50000) | Alphanumérique | 10 |
| Nom usuel du matériel (ex: Francilien) | Texte | 50 |
| Constructeur (ex: Alstom, CAF) | Texte | 30 |
| Longueur totale de la rame (mètres) | Numérique | 3 |
| Largeur de la rame (mètres) | Décimal | 4 |
| Vitesse maximale autorisée (km/h) | Numérique | 3 |
| Capacité totale de voyageurs | Numérique | 5 |
| Accès PMR (nombre de plateformes) | Numérique | 4 |
| Type d'alimentation électrique | Texte | 20 |
| Livrée extérieure (ex: Île-de-France Mobilités, Carmillon) | Texte | 30 |
| Numéro de rame unique (N° exploitation) | Alphanumérique | 15 | X
| Date de mise en service | Date | 10 | 
| État actuel de la rame (Actif/Maintenance) | Texte | 15 | X
| Nom du centre de maintenance (STF) | Texte | 50 | X

### Amélioration de la base de données

Nous avons apporté quelques modifications à la réponse obtenue pour améliorer le réalisme et l'utilisabilité de la base de données : 
- Une ligne peut être gérée par plusieurs exploitants, le RER A et le RER B sont les deux exceptions qui sont à la fois confiées à la SNCF et à la RATP ; 
- La date de mise en service étant difficilement trouvable pour chaque rame et peu significative, elle a été remplacée par la date de commande ;
- L'information sur la tension a été modifiée pour devenir un attribut sur la motorisation et un autre attribut sur l'énergie utilisée (car en IDF toutes les rames ne sont pas des automoteurs électriques).

En plus des modifications listées ci-dessus, nous nous sommes permises de faire quelques ajouts pour enrichir la base de données : informations sur le confort des rames, détails sur les dépôts de maintenance, différents noms donnés à une même série ou à une même autorité organisatrice... 

## Etape 2 : MCD

<img width="2582" height="1450" alt="image" src="https://github.com/user-attachments/assets/fb04cfc0-87a1-4ae6-8150-c150c883da10" /> <br>
*Capture d'écran du MCD créé avec Looping, fichier fourni dans le répertoire Github*

## Etape 3 : MLD et MPD

### MLD obtenu généré avec Looping  
*Légende : les clés primaires sont en gras, les clés étrangères sont en italique.*

LIGNE = (**ligne_nom** VARCHAR(50), ligne_type VARCHAR(50), ligne_nb_stations INT, ligne_couleur_hex VARCHAR(50));

SERIE = (**serie_id** VARCHAR(50), serie_nom_modele VARCHAR(50), serie_effectifs INT, serie_est_articulee LOGICAL, serie_motorisation VARCHAR(50), serie_energie VARCHAR(50), serie_puissance INT, serie_vitesse_max INT, serie_largeur DOUBLE, serie_acces_pmr LOGICAL, serie_acces_toilettes LOGICAL, serie_climatisation LOGICAL, serie_livree VARCHAR(50));

AUTORITE_ORGANISATRICE = (**ao_nom** VARCHAR(50), ao_nom_commercial VARCHAR(50));

DEPOT = (**depot_id** VARCHAR(50), depot_nom VARCHAR(50), depot_ville VARCHAR(50), depot_capacite_voies INT);

EXPLOITANT = (**exp_id** INT, exp_nom VARCHAR(50));

CONSTRUCTEUR = (**constr_id** INT, constr_nom VARCHAR(50));

STF = (**stf_code_interne** VARCHAR(50), stf_nom VARCHAR(50), *#exp_id*); 

RAME = (**rame_matricule_motrice** VARCHAR(50), rame_composition VARCHAR(50), rame_longueur DOUBLE, rame_masse_a_vide DECIMAL(15,2), rame_capacite INT, rame_etat VARCHAR(50), *#ligne_nom*, *#ao_nom*, *#exp_id*, *#serie_id*);

Produire = (_**#serie_id**_, _**#constr_id**_, production_date DATE, production_nom_plateforme VARCHAR(50), production_nom_projet VARCHAR(50)); 

Utiliser = (_**#stf_code_interne**_, _**#depot_id**_);

Gérer = (_**#ligne_nom**_, _**#exp_id**_); 

Assembler = (_**#rame_matricule_motrice**_, _**#rame_matricule_motrice_1**_);

## Etape 4 : Insertion données

### Prompt fourni à l'IAG pour obtenir les données

Tu cherches à concevoir une base de données sur le parc ferroviaire d'Ile de France, spécifiquement les Transiliens et RER (pas les tram-trains !)
Donne les requêtes d’insertion permettant de remplir la base de données dont le modèle relationnel est le suivant : 

LIGNE = (ligne_nom VARCHAR(50), ligne_type VARCHAR(50), ligne_nb_stations INT, ligne_couleur_hex VARCHAR(50)); --> ligne_nom
SERIE = (serie_id VARCHAR(50), serie_nom_modele VARCHAR(50), serie_effectifs INT, serie_est_articulee LOGICAL, serie_motorisation VARCHAR(50), serie_energie VARCHAR(50), serie_puissance INT, serie_vitesse_max INT, serie_largeur DOUBLE, serie_acces_pmr LOGICAL, serie_acces_toilettes LOGICAL, serie_climatisation LOGICAL, serie_livree VARCHAR(50)); --> serie_id
AUTORITE_ORGANISATRICE = (ao_nom VARCHAR(50), ao_nom_commercial VARCHAR(50)); --> ao_nom
DEPOT = (depot_id VARCHAR(50), depot_nom VARCHAR(50), depot_ville VARCHAR(50), depot_capacite_voies INT); --> depot_id
EXPLOITANT = (exp_id INT, exp_nom VARCHAR(50)); --> exp_id
CONSTRUCTEUR = (constr_id INT, constr_nom VARCHAR(50)); --> constr_id
STF = (stf_code_interne VARCHAR(50), stf_nom VARCHAR(50), #exp_id); --> stf_code_interne
RAME = (rame_matricule_motrice VARCHAR(50), rame_composition VARCHAR(50), rame_longueur DOUBLE, rame_masse_a_vide DECIMAL(15,2), rame_capacite INT, rame_etat VARCHAR(50), #ligne_nom, #ao_nom, #exp_id, #serie_id); --> rame_matricule_motrice
Produire = (#serie_id, #constr_id, production_date DATE, production_nom_plateforme VARCHAR(50), production_nom_projet VARCHAR(50)); --> #serie_id, #constr_id
Utiliser = (#stf_code_interne, #depot_id); --> #stf_code_interne, #depot_id
Gérer = (#ligne_nom, #exp_id); --> #ligne_nom, #exp_id
Assembler = (#rame_matricule_motrice, #rame_matricule_motrice_1); --> #rame_matricule_motrice, #rame_matricule_motrice_1

Les clés primaires sont précisées à la fin de chaque relation, les clés étrangères sont identifiées par les #, et ont le même nom que les clés primaires auxquelles elles font référence.

Consignes de remplissage supplémentaires : 
- le nom des lignes se réfère à leur lettre
- le type des lignes se réfère au réseau (RER ou Transilien)
- la couleur est un code hexadécimal complet, # compris !
- le nom d'une série se compose de la première lettre (Z, X ou B) indiquant la motorisation + des chiffres qui l'identifient
- pour la motorisation choisis entre 'Automotrice', 'Autorail', 'Bimode' et 'Locomotive' 
- pour l'énergie choisis entre 'Electrique', 'Gazole' et 'Hybride'
- distingue bien le nom du modèle, du nom de projet, du nom de plateforme (exemple : nom de modèle Francilien, nom de projet NAT, nom de plateforme Spacium 3.06)
- serie_est_articulee est VRAI seulement pour les locomotives (BB27300), qui compte alors comme une 'Rame' avec une capacité faisant référence au convoi entier !
- ao_nom est le nom de la région, ao_nom_commercial est le nom commercial de la région (ex : Île-de-France et Île-de-France Mobilités)
- les unités sont en système international 

Les clés étrangères doivent faire référence aux clés primaires existantes : donne les lignes en commençant par remplir les tables dans lesquelles il n'y a pas de clés étrangères, puis les tables dans lesquelles les clés étrangères font références à des clés primaires des tables déjà remplies. 

Fournis l'ensemble sous la forme d’un script SQL prêt à être exécuté.

## Etape 5 : Interrogation de la BDD

### Scénarios d'utilisation

#### Une personne en charge de suivre le trafic ferroviaire pour adapter les fréquences de passage :

* Afficher toutes les lignes avec le nombre de rames actives dans l'ordre alphabétique des lignes
* Afficher dans l'ordre décroissant le nombre de rames par réseau (RER ou Transilien)
* Afficher pour chaque ligne le nombre de rames fonctionnant à l'énergie électrique et le nombre de rames fonctionnant au gazole
* Sommer la capacité de chaque rame assemblée à une rame choisie et renvoyer la capacité totale de l'unité
* Afficher le nombre de stations par type de réseau

#### Une personne en charge de contrôler les séances de maintenance et la gestion technique des rames :

* Afficher toutes les séries qui ont le même nom de modèle
* Lister toutes les séries ayant le même nom de plateforme
* Calculer la longueur d'une unité multiple en sommant la longueur de toutes les rames assemblées
* Lister tous les dépôts qui ne sont pas utilisés par une STF en particulier
* Lister toutes les séries dont la puissance est supérieure à la moyenne
* Afficher les dépôts qui sont utilisés par plus d'une STF

#### Une personne en charge de gérer les contrats :

* Lister par exploitant les rames lui étant affectées
* Lister par constructeur les séries produites ainsi que leur nombre d'effectifs
* Accéder à la date de production et au nom de projet d'une série
* Afficher les lignes qui sont gérées par plus d'un exploitant
* Lister les constructeurs récents avec leur première série
    
#### Une personne en charge de programmer les voyages longs et le confort des usagers :

* Afficher les caractéristiques liées au confort pour une série selon sa date de production
* Récupérer la couleur d'une ligne
* Lister toutes les séries qui roulent le plus vite
* Afficher les trois modèles ayant la vitesse max la plus élevée, parmi les modèles dont cette vitesse ne dépasse pas les 180 km/h

