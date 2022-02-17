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