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
  COLUMN species VARCHAR
