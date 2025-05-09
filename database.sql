CREATE TABLE Patients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT,
    date_naissance DATE,
    genre CHAR(1)
);

CREATE TABLE Medecins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT,
    specialite TEXT
);

CREATE TABLE Consultations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    patient_id INTEGER REFERENCES Patients(id),
    medecin_id INTEGER REFERENCES Medecins(id),
    diagnostic TEXT
);

CREATE TABLE Prescriptions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    consultation_id INTEGER REFERENCES Consultations(id),
    medicament TEXT,
    posologie TEXT
);

CREATE TABLE Chambres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    numero INTEGER,
    type TEXT
);

CREATE TABLE Hospitalisations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER REFERENCES Patients(id),
    chambre_id INTEGER REFERENCES Chambres(id),
    date_entree DATE,
    date_sortie DATE
);

CREATE TABLE Costs (
    chambre_id INTEGER PRIMARY KEY,
    cost_per_day DECIMAL(10, 2)
);



INSERT INTO Patients (nom, date_naissance, genre) VALUES
('Aurore Carpentier', '2015-05-25', 'M'),
('Véronique Gilles', '1988-04-24', 'M'),
('Alain Lemoine', '1960-03-05', 'F'),
('Nath Coulon', '1981-02-17', 'M'),
('Mireille Mouet', '2009-08-21', 'M'),
('Michel Allard', '1991-04-18', 'M'),
('Christian Dupuis', '1987-11-02', 'F'),
('Gérard Bonneau', '2016-03-15', 'M'),
('Anne-Sophie Girard', '2018-12-16', 'F'),
('Claude Martin', '2006-11-05', 'F'),
('Jean-Michel Lefevre', '1970-01-23', 'M'),
('Chloé Guillet', '2001-02-19', 'F'),
('Bernadette Leclerc', '2004-03-05', 'M'),
('Solange Chavanon', '1998-11-04', 'F'),
('Patrick Lacroix', '1992-06-15', 'M'),
('Alain Favier', '1977-01-07', 'M'),
('Sylvain Delacroix', '2014-07-13', 'M'),
('Agnès Martel-Blondel', '1962-06-09', 'F'),
('Michel Maillard', '1994-03-25', 'F');
INSERT INTO Medecins (nom, specialite) VALUES
('Franck Lombard', 'Cardiologie'),
('Marcelle Laurent', 'Pneumologie'),
('Théodore Lefèvre', 'Dermatologie'),
('Alice Rebe', 'Pédiatrie'),
('Olivier Dupont', 'Neurologie'),
('Bernard Durand', 'Orthopédie'),
('Marie-Eve Bernard', 'Oncologie'),
('Patrick Dufresne', 'Gériatrie'),
('Lucien Gallon', 'Médecine générale'),
('Marie-Josée Klein', 'Gynécologie'),
('Sophie Marceau', 'Chirurgie'),
('Eric Martin', 'Rééducation'),
('Rachid Beggar', 'Ophtalmologie'),
('Valérie Perrin', 'Psychiatrie'),
('Antoine Léger', 'Médecine d’urgence'),
('Claude Joly', 'Endocrinologie'),
('Claude Delaroche', 'Gastroentérologie'),
('Henri Brice', 'Anesthésie'),
('Laurence Brault', 'Médecine du travail'),
('Thomas Ménard', 'Urologie');
INSERT INTO Chambres (numero, type) VALUES
(125, 'Individuelle'),
(144, 'Double'),
(134, 'Soins intensifs'),
(156, 'Individuelle'),
(187, 'Double'),
(191, 'Individuelle'),
(100, 'Soins intensifs'),
(129, 'Individuelle'),
(154, 'Double'),
(110, 'Soins intensifs'),
(111, 'Double'),
(118, 'Individuelle'),
(140, 'Soins intensifs'),
(120, 'Individuelle'),
(130, 'Double'),
(132, 'Individuelle'),
(103, 'Soins intensifs'),
(105, 'Double'),
(109, 'Soins intensifs'),
(117, 'Individuelle');
INSERT INTO Consultations (date, patient_id, medecin_id, diagnostic) VALUES
('2024-04-12', 5, 11, 'Douleurs thoraciques persistantes'),
('2023-08-19', 14, 3, 'Fièvre prolongée'),
('2024-01-05', 7, 6, 'Toux chronique'),
('2024-11-25', 2, 17, 'Migraine sévère'),
('2023-12-03', 19, 8, 'Douleur lombaire'),
('2024-02-22', 4, 2, 'Asthme modéré'),
('2024-03-15', 8, 12, 'Palpitations'),
('2023-09-09', 16, 1, 'Vertiges'),
('2024-01-30', 10, 7, 'Trouble du sommeil'),
('2024-05-02', 6, 14, 'Tension élevée'),
('2023-10-11', 11, 4, 'Infection ORL'),
('2023-07-07', 13, 9, 'Rhumatisme'),
('2024-04-20', 1, 10, 'Sinusite'),
('2024-02-17', 17, 5, 'Douleurs articulaires'),
('2023-11-23', 12, 20, 'Toux sèche'),
('2024-03-25', 9, 15, 'Fatigue chronique'),
('2023-06-04', 20, 16, 'Hypertension'),
('2024-01-10', 15, 19, 'Ulcère'),
('2024-04-28', 18, 13, 'Fièvre inexpliquée'),
('2023-08-30', 3, 18, 'Migraines récurrentes');
INSERT INTO Prescriptions (consultation_id, medicament, posologie) VALUES
(1, 'Ramipril', '1x par jour'),
(2, 'Ibuprofène', '3x par jour'),
(3, 'Paracétamol', '2x par jour'),
(4, 'Ventoline', '2x par jour'),
(5, 'Amoxicilline', '3x par jour'),
(6, 'Doliprane', '1x par jour'),
(7, 'Paracétamol', '2x par jour'),
(8, 'Ventoline', '1x par jour'),
(9, 'Ibuprofène', '3x par jour'),
(10, 'Amoxicilline', '2x par jour'),
(11, 'Ramipril', '1x par jour'),
(12, 'Paracétamol', '2x par jour'),
(13, 'Ventoline', '2x par jour'),
(14, 'Doliprane', '1x par jour'),
(15, 'Amoxicilline', '2x par jour'),
(16, 'Ibuprofène', '3x par jour'),
(17, 'Ramipril', '1x par jour'),
(18, 'Paracétamol', '2x par jour'),
(19, 'Ventoline', '2x par jour'),
(20, 'Amoxicilline', '3x par jour');
INSERT INTO Hospitalisations (patient_id, chambre_id, date_entree, date_sortie) VALUES
(3, 104, '2024-10-10', '2024-10-20'),
(12, 121, '2024-07-01', NULL),
(9, 145, '2024-05-15', '2024-05-28'),
(5, 178, '2024-11-02', NULL),
(18, 151, '2024-08-20', '2024-08-25'),
(2, 109, '2024-06-12', '2024-06-20'),
(6, 133, '2024-01-05', NULL),
(11, 189, '2023-12-14', '2023-12-25'),
(8, 127, '2024-02-17', '2024-03-01'),
(10, 115, '2023-10-11', '2023-10-20'),
(1, 101, '2023-09-04', NULL),
(7, 161, '2024-03-07', '2024-03-20'),
(4, 117, '2023-11-01', '2023-11-10'),
(14, 142, '2024-04-12', NULL),
(16, 150, '2023-06-21', '2023-07-01'),
(13, 112, '2024-03-25', NULL),
(15, 106, '2023-08-08', '2023-08-18'),
(19, 170, '2023-12-30', '2024-01-10'),
(20, 108, '2024-01-22', '2024-01-29'),
(17, 199, '2024-02-10', NULL);
INSERT INTO Costs (chambre_id, cost_per_day) VALUES
(101, 150.00),
(102, 180.00),
(103, 200.00),
(104, 220.00),
(105, 250.00),
(106, 175.00),
(107, 195.00),
(108, 210.00),
(109, 230.00),
(110, 240.00),
(111, 260.00),
(112, 270.00),
(113, 280.00),
(114, 300.00),
(115, 320.00),
(116, 340.00),
(117, 350.00),
(118, 370.00),
(119, 390.00),
(120, 400.00);
