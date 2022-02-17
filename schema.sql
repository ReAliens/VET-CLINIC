/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
  id INT PRIMARY KEY NOT NULL,
  animal_name VARCHAR(100),
  date_of_birth date NOT NULL,
  escape_attempts INT,
  neutered boolean NOT NULL,
  weight_kg decimal NOT NULL
);

/* Add Column species in animals table*/
ALTER TABLE
  animals
ADD
  COLUMN species VARCHAR(100);

CREATE TABLE owners(
  id SMALLSERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  age INT NOT NULL
);

CREATE TABLE species(
  id SMALLSERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

ALTER TABLE
  animals DROP COLUMN species;

ALTER TABLE
  animals
ADD
  species_id INT;

ALTER TABLE
  animals
ADD
  CONSTRAINT fk_animal_type FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE
  animals
ADD
  owner_id INT;

ALTER TABLE
  animals
ADD
  CONSTRAINT fk_animal_owner FOREIGN KEY (owner_id) REFERENCES owners(id);