/*Queries that provide answers to the questions from all projects.*/
SELECT
    *
from
    animals
WHERE
    animal_name LIKE '%mon';

SELECT
    animal_name
FROM
    animals
WHERE
    date_of_birth >= '2016/01/01'
    AND date_of_birth <= '2019/12/31'
SELECT
    animal_name
FROM
    animals
WHERE
    neutered = 'true'
    AND escape_attempts < '3';

SELECT
    date_of_birth
FROM
    animals
WHERE
    animal_name IN ('Agumon', 'Pikachu');

SELECT
    animal_name,
    escape_attempts
FROM
    animals
WHERE
    weight_per_kg > 10.5;

SELECT
    *
FROM
    animals
WHERE
    neutered = 'true';

SELECT
    *
FROM
    animals
WHERE
    animal_name != 'Gabumon';

SELECT
    *
FROM
    animals
WHERE
    weight_per_kg >= '10.4'
    AND weight_per_kg <= '17.3';

/* first transaction transaction update the animals table by setting the species column to unspecified. then roll back*/
UPDATE
    animals
SET
    species = 'unspecified';

ROLLBACK;

SELECT
    *
FROM
    animals;

/* update transaction of animals species*/
SELECT
    *
FROM
    animals;

UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species = 'specified';

COMMIT;

SELECT
    *
FROM
    animals;

/* Delete all records then rollback */
BEGIN;

DELETE FROM
    animals;

ROLLBACK;

SELECT
    *
FROM
    animals;

/* Transaction Update 3 update animals weight, create savepoint, change negative values for kg */
BEGIN;

DELETE FROM
    animals
WHERE
    date_of_birth > '2022/01/01';

SAVEPOINT date_of_birth;

UPDATE
    animals
SET
    weight_kg = -1 * weight_kg;

ROLLBACK TO date_of_birth;

UPDATE
    animals
SET
    weight_kg = -1 * weight_kg
WHERE
    weight_kg < 0;

COMMIT;

SELECT
    *
FROM
    animals;

/*final aggregation functions*/
SELECT
    COUNT(*)
FROM
    animals;

SELECT
    COUNT(*)
FROM
    animals
WHERE
    escape_attempts = 0;

SELECT
    AVG(weight_kg)
FROM
    animals;

SELECT
    neutered,
    escape_attempts
FROM
    animals
GROUP BY
    neutered,
    escape_attempts
ORDER BY
    escape_attempts DESC
LIMIT
    1;

SELECT
    species,
    MAX(weight_kg) AS max_weight,
    MIN(weight_kg) AS min_weight
FROM
    animals
GROUP BY
    species;

SELECT
    species,
    AVG(escape_attempts) as average
FROM
    animals
WHERE
    date_of_birth BETWEEN '1990-01-01'
    AND '2000-12-31'
GROUP BY
    species;

/* What animals belong to Melody Pond? */
SELECT
    animal_name,
    full_name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon). */
SELECT
    animals.animal_name
FROM
    animals
    JOIN species ON animals.species_id = species.id
WHERE
    species.name = 'pokemon';

/* List of owners and their animals, remember to include those that don't own any animal. */
SELECT
    animals.animal_name,
    owners.full_name
FROM
    animals FULL
    JOIN owners ON animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT
    COUNT(animals.animal_name),
    species.name
FROM
    animals
    JOIN species ON animals.species_id = species.id
GROUP BY
    species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT
    animals.animal_name,
    owners.full_name,
    species.name
FROM
    animals
    JOIN owners ON owners.id = animals.owner_id
    JOIN species ON species.id = animals.species_id
WHERE
    owners.full_name = 'Jennifer Orwell'
    AND species.name = 'digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT
    animal_name,
    escape_attempts,
    full_name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    escape_attempts = 0
    AND full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT
    full_name,
    COUNT(animals.owner_id) as animals_count
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
GROUP BY
    owners.id
ORDER BY
    animals_count DESC
LIMIT
    1;

/* Join tables Queries */
/* Who was the last animal seen by William Tatcher? */
SELECT
    animals.animal_name,
    visits.date_of_visit
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.date_of_visit DESC
LIMIT
    1;

/* How many different animals did Stephanie Mendez see? */
SELECT
    COUNT(DISTINCT animals.animal_name)
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
GROUP BY
    vets.name
HAVING
    vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties. */
SELECT
    vets.name,
    species.name AS specialties
FROM
    vets FULL
    JOIN specializations ON vets.id = specializations.vets_id FULL
    JOIN species ON species.id = specializations.species_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT
    animals.animal_name,
    visits.date_of_visit
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    visits.date_of_visit BETWEEN '2020-04-01'
    AND '2020-08-30'
    AND vets.name = 'Stephanie Mendez';

/* What animal has the most visits to vets? */
SELECT
    animals.animal_name,
    COUNT(animals.id)
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
GROUP BY
    animals.name
ORDER BY
    COUNT(animals_id) DESC
LIMIT
    1;

/* Who was Maisy Smith's first visit? */
SELECT
    animals.animal_name,
    visits.date_of_visit
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'Maisy Smith'
ORDER BY
    visits.date_of_visit ASC
LIMIT
    1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT
    animals.*,
    vets.*,
    vistis.visit_date
FROM
    visits
    LEFT JOIN animals ON animals.id = visits.animal_id
    LEFT JOIN vets ON vets.id = visits.vet_id
ORDER BY
    visits.visit_date DESC
LIMIT
    1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT
    COUNT(visits.animals_id)
FROM
    visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animals ON animals.id = visits.animals_id
    JOIN specializations ON specializations.vets_id = vets.id
WHERE
    specializations.species_id <> animals.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT
    species.name,
    COUNT(visits.animals_id) as count
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
    JOIN species ON species.id = animals.species_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    species.name
ORDER BY
    count DESC
LIMIT
    1;