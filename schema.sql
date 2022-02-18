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

CREATE TABLE vets(
  id SMALLSERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
  id SMALLSERIAL PRIMARY KEY,
  vets_id SMALLSERIAL,
  species_id SMALLSERIAL,
  CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
  CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
  id SMALLSERIAL PRIMARY KEY,
  animals_id SMALLSERIAL,
  vets_id SMALLSERIAL,
  date_of_visit DATE,
  CONSTRAINT vet_fk FOREIGN KEY(vets_id) REFERENCES vets(id),
  CONSTRAINT animals_fk FOREIGN KEY(animals_id) REFERENCES animals(id)
);