-- Liste des consultations par patient avec les médecins traitants
SELECT
    p.nom AS patient_nom,
    c.date AS consultation_date,
    m.nom AS medecin_nom,
    m.specialite AS medecin_specialite,
    c.diagnostic
FROM
    Consultations c
JOIN Patients p ON c.patient_id = p.id
JOIN Medecins m ON c.medecin_id = m.id
ORDER BY
    p.nom, c.date;

-- Dernière hospitalisation d'un patient spécifique
SELECT 
    p.nom AS patient_nom,
    c.date AS consultation_date,
    c.diagnostic,
    pr.medicament,
    pr.posologie,
    m.nom AS medecin_nom,
    m.specialite
FROM 
    Consultations c
JOIN Patients p ON c.patient_id = p.id
JOIN Medecins m ON c.medecin_id = m.id
LEFT JOIN Prescriptions pr ON pr.consultation_id = c.id
WHERE 
    p.nom = 'Bernadette Leclerc' --Exemple

UNION ALL

SELECT 
    'Aucune consultation trouvée pour cette patiente.' AS patient_nom, --Permet de vérifier s'il s'agit d'un nouveau patient ou non
    NULL, NULL, NULL, NULL,
    NULL, NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM Consultations c
    JOIN Patients p ON c.patient_id = p.id
    WHERE p.nom = 'Bernadette Leclerc'
);



-- Liste des patients ayant consulté plusieurs fois pour le même diagnostic
SELECT 
    p.nom AS patient_nom,
    TRIM(LOWER(c.diagnostic)) AS diagnostic,
    COUNT(*) AS nombre_consultations
FROM 
    Consultations c
JOIN 
    Patients p ON c.patient_id = p.id
GROUP BY 
    p.nom, TRIM(LOWER(c.diagnostic))
ORDER BY 
    nombre_consultations DESC;

-- Nombre de jours d'hospitalisation par spécialité de médecin
    SELECT 
    m.specialite AS medecin_specialite,
    SUM(JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree)) AS jours_hospitalisation
FROM 
    Hospitalisations h
JOIN 
    Consultations c ON h.patient_id = c.patient_id
JOIN 
    Medecins m ON c.medecin_id = m.id
WHERE 
    h.date_sortie IS NOT NULL
GROUP BY 
    m.specialite
ORDER BY 
    jours_hospitalisation DESC;

-- Nombre d'utilisations par chambre
SELECT 
    c.numero,
    COUNT(h.id) AS total_occupations
FROM 
    Chambres c
LEFT JOIN 
    Hospitalisations h ON h.chambre_id = c.numero
GROUP BY 
    c.numero
ORDER BY 
    total_occupations DESC;

-- Planning d'occupation des chambres à une période donnée
SELECT 
    COALESCE(p.nom, 'Aucune hospitalisation à cette période.') AS message, --Message d'erreur si aucune n'est trouvée
    p.nom AS patient,
    h.date_entree,
    h.date_sortie,
    c.numero AS chambre
FROM 
    Hospitalisations h
JOIN Chambres c ON h.chambre_id = c.id
JOIN Patients p ON h.patient_id = p.id
WHERE 
    h.date_sortie IS NULL 
    AND h.date_entree <= '2024-02-01'

UNION ALL

SELECT 
    'Aucune hospitalisation à cette période.' AS message, --Notre base de données est très simple donc retournera ce message mais en principe cela ne devrait pas exister
    NULL AS patient,
    NULL AS date_entree,
    NULL AS date_sortie,
    NULL AS chambre
WHERE NOT EXISTS (
    SELECT 1
    FROM Hospitalisations h
    JOIN Chambres c ON h.chambre_id = c.id
    JOIN Patients p ON h.patient_id = p.id
    WHERE 
        h.date_sortie IS NULL 
        AND h.date_entree <= '2024-02-01' --Exemple
);

-- Historique médecin spécifique
SELECT 
    pa.nom AS patient,
    c.date AS consultation_date,
    c.diagnostic,
    pr.medicament,
    pr.posologie
FROM 
    Prescriptions pr
JOIN Consultations c ON pr.consultation_id = c.id
JOIN Patients pa ON c.patient_id = pa.id
JOIN Medecins m ON c.medecin_id = m.id
WHERE 
    m.nom = 'Sophie Marceau'

UNION ALL

SELECT 
    'Aucune donnée' AS patient,
    NULL AS consultation_date,
    'Aucune prescription trouvée' AS diagnostic,
    NULL AS medicament,
    NULL AS posologie
WHERE NOT EXISTS (
    SELECT 1
    FROM Prescriptions pr
    JOIN Consultations c ON pr.consultation_id = c.id
    JOIN Medecins m ON c.medecin_id = m.id
    WHERE m.nom = 'Sophie Marceau'
)
ORDER BY 
    consultation_date DESC;


--Requête : Nombre de consultations par spécialité médicale
SELECT 
    m.specialite,
    COUNT(c.id) AS nombre_consultations
FROM 
    Consultations c
JOIN Medecins m ON c.medecin_id = m.id
GROUP BY 
    m.specialite
ORDER BY 
    nombre_consultations DESC;

--Requête : Durée moyenne d’hospitalisation par type de chambre
SELECT 
    c.numero AS chambre_numero,
    c.type AS chambre_type,
    AVG(JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree)) AS duree_moyenne
FROM 
    Hospitalisations h
JOIN Chambres c ON h.chambre_id = c.numero 
WHERE 
    h.date_sortie IS NOT NULL
    AND h.date_entree IS NOT NULL
GROUP BY 
    c.type; 

--Requête : Patients hospitalisés plus de 2 fois
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'Aucune hospitalisation ne correspond à cette condition.' --Notre base de données est très simple donc retournera ce message mais en principe cela ne devrait pas exister
        ELSE 'Hospitalisations trouvées.'
    END AS message,
    p.nom,
    COUNT(h.id) AS nb_hospitalisations
FROM 
    Hospitalisations h
JOIN Patients p ON h.patient_id = p.id
GROUP BY 
    p.id
HAVING 
    COUNT(h.id) > 2
UNION
SELECT 
    'Aucune hospitalisation ne correspond à cette condition.' AS message, 
    NULL AS nom, 
    NULL AS nb_hospitalisations
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM Hospitalisations h
        JOIN Patients p ON h.patient_id = p.id
        GROUP BY p.id
        HAVING COUNT(h.id) > 2
    )
LIMIT 1;

--Liste des patients hospitalisés actuellement
SELECT 
    p.nom,
    h.date_entree,
    h.chambre_id,
    h.date_sortie
FROM 
    Hospitalisations h
JOIN Patients p ON h.patient_id = p.id
WHERE 
    h.date_sortie IS NULL;

--Total des jours d'hospitalisation par patient
SELECT 
    p.nom,
    SUM(JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree)) AS total_jours_hospitalisation
FROM 
    Hospitalisations h
JOIN Patients p ON h.patient_id = p.id
WHERE 
    h.date_sortie IS NOT NULL
GROUP BY 
    p.id;

-- Analyse des hospitalisations liées à des consultations spécifiques
SELECT 
    p.nom AS patient_nom,
    m.specialite AS medecin_specialite,
    h.date_entree,
    h.date_sortie,
    c.diagnostic,
    JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree) AS duree_hospitalisation
FROM 
    Hospitalisations h
JOIN Patients p ON h.patient_id = p.id
JOIN Consultations c ON p.id = c.patient_id
JOIN Medecins m ON c.medecin_id = m.id
WHERE 
    h.date_sortie IS NOT NULL
    AND m.specialite = 'Cardiologie'  -- Exemple de spécialité
ORDER BY 
    duree_hospitalisation DESC;

--Calcul des coûts d'hospitalisation par patient
SELECT 
    p.nom AS patient_nom,
    SUM(
        (JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree)) * c.cost_per_day
    ) AS cout_total
FROM 
    Hospitalisations h
JOIN 
    Patients p ON h.patient_id = p.id
JOIN 
    Costs c ON h.chambre_id = c.chambre_id
WHERE 
    h.date_sortie IS NOT NULL
GROUP BY 
    p.id
ORDER BY 
    cout_total DESC;


-- Coût total par spécialité médicale (via consultations et hospitalisations)
SELECT 
    m.specialite,
    ROUND(SUM((JULIANDAY(h.date_sortie) - JULIANDAY(h.date_entree)) * cst.cost_per_day), 2) AS cout_total
FROM 
    Hospitalisations h
JOIN Consultations cons ON h.patient_id = cons.patient_id
JOIN Medecins m ON cons.medecin_id = m.id
JOIN Costs cst ON h.chambre_id = cst.chambre_id
WHERE 
    h.date_sortie IS NOT NULL
GROUP BY 
    m.specialite
ORDER BY 
    cout_total DESC;
