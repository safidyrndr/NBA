CREATE DATABASE nba;
\c nba;

CREATE TABLE equipe(
    idE VARCHAR(255) primary key,
    nomE VARCHAR(255)

);

CREATE TABLE joueur(
    idJ VARCHAR(255) primary key,
    nomJ VARCHAR(255),
    prenom VARCHAR(255),
    idE VARCHAR(255) REFERENCES equipe(idE)
);

CREATE TABLE match(
    idM VARCHAR(255) primary key,
    idE1 VARCHAR(255) REFERENCES equipe(idE),
    idE2 VARCHAR(255) REFERENCES equipe(idE),
    date_match DATE
);

CREATE TABLE stat(
    idS VARCHAR(255) primary key, 
    points_m INT,
    rebonds_m INT,
    contre_m INT,
    assists_m INT,
    idJ VARCHAR(255) REFERENCES joueur(idJ),
    idM VARCHAR(255) REFERENCES match(idM)
);


-- Insertion dans la table equipe
INSERT INTO equipe (idE, nomE) VALUES
('GSW', 'Golden State Warriors'),
('LAL', 'Los Angeles Lakers'),
('BOS', 'Boston Celtics'),
('MIA', 'Miami Heat');

-- Insertion dans la table joueur avec 5 joueurs par équipe
INSERT INTO joueur (idJ, nomJ, prenom, idE) VALUES
('CURRY', 'Curry', 'Stephen', 'GSW'),
('THOMPSON', 'Thompson', 'Klay', 'GSW'),
('GREEN', 'Green', 'Draymond', 'GSW'),
('WIGGINS', 'Wiggins', 'Andrew', 'GSW'),
('POOLE', 'Poole', 'Jordan', 'GSW'),

('JAMES', 'James', 'LeBron', 'LAL'),
('DAVIS', 'Davis', 'Anthony', 'LAL'),
('HOWARD', 'Howard', 'Dwight', 'LAL'),
('WESTBROOK', 'Westbrook', 'Russell', 'LAL'),
('MONK', 'Monk', 'Malik', 'LAL'),

('TATUM', 'Tatum', 'Jayson', 'BOS'),
('BROWN', 'Brown', 'Jaylen', 'BOS'),
('WALKER', 'Walker', 'Kemba', 'BOS'),
('SMART', 'Smart', 'Marcus', 'BOS'),
('WILLIAMS', 'Williams', 'Robert', 'BOS'),

('BUTLER', 'Butler', 'Jimmy', 'MIA'),
('HERRO', 'Herro', 'Tyler', 'MIA'),
('ROBINSON', 'Robinson', 'Duncan', 'MIA'),
('ADEBAYO', 'Adebayo', 'Bam', 'MIA'),
('LOWRY', 'Lowry', 'Kyle', 'MIA');

-- Insertion dans la table match
INSERT INTO match (idM, idE1, idE2, date_match) VALUES
('GM1', 'GSW', 'LAL', '2023-11-21'),
('GM2', 'BOS', 'MIA', '2023-11-22'),
('GM3', 'GSW', 'MIA', '2023-11-23');

-- Insertion dans la table stat
INSERT INTO stat (idS, points_m, rebonds_m, contre_m, assists_m, idJ, idM) VALUES
('1', 28, 7, 1, 6, 'CURRY', 'GM1'),
('2', 24, 5, 0, 4, 'THOMPSON', 'GM1'),
('3', 20, 8, 2, 2, 'JAMES', 'GM2'),
('4', 22, 6, 0, 7, 'TATUM', 'GM2'),
('5', 30, 7, 1, 6, 'CURRY', 'GM3'),
('6', 21, 5, 0, 4, 'THOMPSON', 'GM3');

-- Vue pour calculer la moyenne des points par joueur
CREATE VIEW moyenne_points_par_joueur AS
SELECT
    joueur.idJ,
    joueur.nomJ,
    AVG(stat.points_m) AS moyenne_points
FROM
    joueur
JOIN
    stat ON joueur.idJ = stat.idJ
GROUP BY
    joueur.idJ, joueur.nomJ;

-- Vue pour calculer la moyenne des rebonds par joueur
CREATE VIEW moyenne_rebonds_par_joueur AS
SELECT
    joueur.idJ,
    joueur.nomJ,
    AVG(stat.rebonds_m) AS moyenne_rebonds
FROM
    joueur
JOIN
    stat ON joueur.idJ = stat.idJ
GROUP BY
    joueur.idJ, joueur.nomJ;

-- Vue pour calculer la moyenne des assists par joueur
CREATE VIEW moyenne_assists_par_joueur AS
SELECT
    joueur.idJ,
    joueur.nomJ,
    AVG(stat.assists_m) AS moyenne_assists
FROM
    joueur
JOIN
    stat ON joueur.idJ = stat.idJ
GROUP BY
    joueur.idJ, joueur.nomJ;

-- Vue pour calculer la moyenne des contre par joueur
CREATE VIEW moyenne_contre_par_joueur AS
SELECT
    joueur.idJ,
    joueur.nomJ,
    AVG(stat.contre_m) AS moyenne_contre
FROM
    joueur
JOIN
    stat ON joueur.idJ = stat.idJ
GROUP BY
    joueur.idJ, joueur.nomJ;

