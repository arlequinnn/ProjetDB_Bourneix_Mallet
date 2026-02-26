# Mini-projet : Conception et développement d'une base de données


# Etape 1 : Analyser les besoins

Choix du domaine : Matériels roulants d'Île-de-France

## Prompt envoyé à l'IAG pour récupérer les besoins :

Tu travailles dans le domaine destransports ferroviaires en Ile-de-France.
Ton administration a comme activité de répertorier et organiser les matériels roulants (trains, RER, TER) circulant sur le réseau
ferré francilien. C’est une administration publique comme la RATP ou SNCF Voyageurs. Les données ont été collectées sur les lignes de
transport, les gares et points d’arrêt, les types de matériels roulants (trains, RER, TER) et leur fiche technique.
Inspire-toi du portail Open Data d’Ile-de-France Mobilités ou du site officiel Transilien, ainsi que des
sites suivants : https://explorehunza.fr/2025/09/16/materiel-roulant-transilien-2025/, https://fr.wikipedia.org/wiki/Liste_des_Regio_2N,
https://omnil.fr/materiel-roulant-ferroviaire-et-routier.
Ton administration veut appliquer MERISE pourconcevoir un système d'information. Tu es chargé de la partie analyse,
c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet,
tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la 
base de données. D’abord, établis les règles de gestions des données de ton administration,sous la forme d'une liste à puce. 
Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas
comment se construit un système d’information.
Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : 
signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à
fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

## Réponse de l'IAG :

Voici les règles de gestion qui dictent notre quotidien, ainsi que le dictionnaire de données pour ton analyse.

## 1. Règles de Gestion des Données

Ces règles définissent le fonctionnement métier de l'administration et les contraintes de gestion des actifs ferroviaires :

### Réseau et Infrastructure
* **Lignes :** Chaque ligne de transport (ex: Ligne N, RER A) est identifiée par un code unique et possède un nom commercial ainsi qu'une couleur de représentation.
* **Exploitation :** Une ligne est exploitée par un seul opérateur (SNCF Voyageurs, RATP ou un opérateur privé via IDFM).
* **Points d'arrêt :** Une ligne dessert plusieurs gares ou points d'arrêt. Inversement, une gare peut être desservie par une ou plusieurs lignes (nœuds de correspondance).
* **Géolocalisation :** Chaque point d'arrêt est précisément localisé par des coordonnées GPS et rattaché à une commune et une zone tarifaire.

### Matériel Roulant
* **Modèles (Séries) :** Le matériel est répertorié par modèles techniques (ex: Z 57000, Regio 2N, Francilien). 
* **Fiche Technique :** Chaque modèle possède des caractéristiques fixes : constructeur, vitesse maximale, capacité de voyageurs, motorisation et hauteur de plancher.
* **Unités (Rames) :** Une "rame" est une unité physique individuelle identifiée par un numéro d'exploitation unique. Chaque rame appartient obligatoirement à un modèle.
* **Affectation :** Une rame est affectée à un centre de maintenance spécifique (STF - Supervision Technique de Flotte).
* **Compatibilité :** Seuls certains modèles de matériels sont autorisés à circuler sur une ligne donnée (contraintes de gabarit et d'infrastructure).
* **Cycle de vie :** Nous suivons pour chaque rame sa date de mise en service, son kilométrage total et son état de disponibilité (en service, en maintenance, radiée).

---

## 2. Dictionnaire des Données Brutes

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


# Etape 2 : MCD

<img width="2603" height="1433" alt="image" src="https://github.com/user-attachments/assets/8e0d3a0c-d8cf-4442-800a-f46f98c6f3f2" />
