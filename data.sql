/* Populate database with sample data. */
INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (0, 'Agumon', '2020/02/03', '0', 'true', '10.23');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (1, 'Gabumon', '2018/11/15', '2', 'true', '8');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (
    2,
    'Pikachu',
    '2021/01/07',
    '1',
    'false',
    '15.04'
  );

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (3, 'Devimon', '2017/05/12', '5', 'true', '11');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (
    4,
    'Charmander',
    '2020/02/08',
    '0',
    'false',
    '-11'
  );

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (5, 'Plantmon', '2022/11/15', '2', 'true', '-5.7');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (
    6,
    'Squirtle',
    '1993/04/02',
    '3',
    'false',
    '-12.13'
  );

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (7, 'Angemon', '2005/06/12', '1', 'true', '-45');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (8, 'Boarmon', '2005/06/07', '7', 'true', '20.4');

INSERT INTO
  animals (
    id,
    animal_name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  (9, 'Blossom', '1998/10/13', '3', 'true', '17');

INSERT INTO
  owners (full_name, age)
VALUES
  ('Bob', 45);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jennifer Orwell', 19);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Melody Pond', 77);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Dean Winchester', 14);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jodie Whittaker', 38);

INSERT INTO
  species (name)
VALUES
  ('pokemon');

INSERT INTO
  species (name)
VALUES
  ('digimon');

/*update animals table so includes the species id*/
UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'digimon'
  )
WHERE
  animal_name LIKE '%mon';

UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'pokemon'
  )
WHERE
  animal_name NOT LIKE '%mon';

/*update animals table so includes the owner id*/
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
  )
WHERE
  name = 'Gabumon'
  OR name = 'Pikachu';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
  )
WHERE
  name = 'Devimon'
  OR name = 'Plantmon';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
  )
WHERE
  name = 'Charmander'
  OR name = 'Squirtle'
  OR name = 'Blossom';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
  )
WHERE
  name = 'Angemon'
  OR name = 'Boarmon';

/* Join tables Statements*/
INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO
  specializations (vets_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  );

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO
  specializations (vets_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  );

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO
  specializations (vets_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  );

INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-07-22'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-02'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-01-05'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-03-08'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-05-14'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2021-05-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-24'
  );

INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-12-21'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-08-10'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2021-04-07'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2019-09-29'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-10-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-11-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-01-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-05-15'
  );

INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-02-27'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-08-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2021-01-11'
  );